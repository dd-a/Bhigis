from flask import Flask, render_template, request, jsonify, send_file
from db.db_config import get_ssh_tunnel, get_db_connection
import psycopg2
import os
import io
import datetime
import sqlite3
import geopandas as gpd
import pandas as pd
import zipfile
import json
from sqlalchemy import create_engine

app = Flask(__name__)

# ============================================================
# Connexion PostgreSQL
# ============================================================
def get_db_connection(tunnel):
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host="127.0.0.1",
        port=tunnel.local_bind_port
    )

# ============================================================
# Page d’accueil
# ============================================================
@app.route("/")
def index():
    return render_template("index.html")

# ============================================================
# Autocomplétion (optionnel)
# ============================================================
@app.route("/autocomplete")
def autocomplete():
    query = request.args.get("q", "")
    results = []

    if query:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute(
            "SELECT address FROM couches.adresses WHERE address ILIKE %s LIMIT 10",
            (f"%{query}%",),
        )
        results = [row[0] for row in cur.fetchall()]
        cur.close()
        conn.close()

    return jsonify(results)

# ============================================================
# Compteur d’appels à /geocode
# ============================================================
def increment_geocode_counter():
    count_file = "geocode_counter.txt"      ### à remplacer par /opt/bhigis/geocode_counter.txt !!!
    count = 0

    if os.path.exists(count_file):
        with open(count_file, "r") as f:
            try:
                count = int(f.read())
            except ValueError:
                count = 0

    count += 1
    with open(count_file, "w") as f:
        f.write(str(count))

# ============================================================
# Géocodage simple (requête unique)
# ============================================================
@app.route("/geocode")
def geocode():
    address = request.args.get("address", "")
    numero = request.args.get("numero", None)
    annee = request.args.get("annee", None)
    commune = request.args.get("commune", "").strip()
    results = []

    if address:
        increment_geocode_counter()
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            conn = get_db_connection(tunnel)
            conn.autocommit = True
            cur = conn.cursor()

            try:
                numero_int = int(numero) if numero else None
            except ValueError:
                numero_int = None

            try:
                annee_int = int(annee) if annee else None
            except ValueError:
                annee_int = None

            # 1. Vider la table
            cur.execute("TRUNCATE bhigis_webuser.new_geo_loc")

            # 2. Insérer les données utilisateur
            cur.execute(
                """
                INSERT INTO bhigis_webuser.new_geo_loc (nom_rue, numero, annee, commune)
                VALUES (%s, %s, %s, %s)
                """,
                (address, numero_int, annee_int, commune),
            )

            # 3. Appeler la fonction de traitement
            cur.execute("SELECT data.run_webuser()")

            # 4. Lire les résultats
            cur.execute(
                """
                SELECT DISTINCT
                    ST_Y(ST_Transform(ST_Centroid(geom), 4326)) AS lat,
                    ST_X(ST_Transform(ST_Centroid(geom), 4326)) AS lon,
                    found_street AS rue,
                    commune_loc AS commune,
                    annee_ref AS epoque,
                    ROUND(simila::numeric, 2)::numeric simila,
                    ROUND((dist_muni/1000)::numeric, 2) dist_muni,
                    best_answer,
                    main_name,
                    CASE WHEN %s ILIKE commune THEN 1 ELSE 0 END AS commune_match,
                    simsignif,
                    simsignif+simila sim
                FROM bhigis_webuser.adress_collect_pt
                WHERE simila > 0.35 OR simsignif > 0.5
                ORDER BY best_answer ASC, sim DESC, commune_match, dist_muni
                LIMIT 10
                """,
                (commune,),
            )

            rows = cur.fetchall()
            for row in rows:
                results.append(
                    {
                        "lat": row[0],
                        "lon": row[1],
                        "adresse": row[2],
                        "commune": row[3],
                        "époque": row[4],
                        "simila": row[5],
                        "dist_muni": row[6],
                        "best_answer": row[7],
                        "main_name": row[8],
                        "commune_match": row[9],
                    }
                )

            cur.close()
            conn.close()

    return jsonify(results)


# ============================================================
# Page pour traitement batch
# ============================================================
@app.route("/batch")
def batch_page():
    return render_template("batch.html")


# ============================================================
# Génération des résultats batch
# ============================================================
def generate_results_zip(base_filename, gdf1, df2, df3,
                         style1="style_bhigis.qml", style2="style_non_trouvés.qml"):
    # Générer un timestamp (ex: 20250916_114532)
    timestamp = datetime.datetime.now().strftime("%Y%m%d%H%M%S")

    # Nom unique du GeoPackage
    gpkg_filename = f"{base_filename}_{timestamp}_bhigis.gpkg"

    # Couche principale
    gdf1.to_file(gpkg_filename, driver="GPKG", layer="resultats")

    # Tables secondaires
    conn = sqlite3.connect(gpkg_filename)
    df2.to_sql("données_non_trouvées", conn, if_exists="replace", index=False)
    df3.to_sql("suggestions", conn, if_exists="replace", index=False)
    conn.close()

    # Nom unique de l’archive ZIP
    zip_filename = f"{base_filename}_{timestamp}_bhigis.zip"
    with zipfile.ZipFile(zip_filename, "w") as zf:
        zf.write(gpkg_filename, os.path.basename(gpkg_filename))
        if os.path.exists(style1):
            zf.write(style1, os.path.basename(style1))
        if os.path.exists(style2):
            zf.write(style2, os.path.basename(style2))

    return zip_filename


# ============================================================
# Analyse d'un fichier batch pour extraire les colonnes
# ============================================================
@app.route("/analyze_file", methods=["POST"])
def analyze_file():
    """
    Analyse le fichier uploadé :
    - Lit les colonnes du fichier (csv ou xlsx)
    - Récupère les colonnes attendues dans la table PostgreSQL
    - Retourne les deux listes en JSON
    """
    file = request.files.get("file")
    if not file:
        return jsonify({"error": "Aucun fichier fourni"}), 400

    filename = file.filename
    base_filename, ext = os.path.splitext(filename)

    # Lire fichier
    try:
        if ext.lower() == ".xlsx":
            df = pd.read_excel(file)
        elif ext.lower() == ".csv":
            df = pd.read_csv(file, sep=";")
        elif ext.lower() == ".ods":
            df = pd.read_excel(file, engine="odf")
        else:
            return jsonify({"error": "Format non supporté (xlsx, csv ou ods attendu)"}), 400
    except Exception as e:
        return jsonify({"error": f"Erreur lecture fichier: {str(e)}"}), 500

    file_columns = df.columns.astype(str).tolist()

    # Colonnes de la table cible PostgreSQL
    try:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            conn = get_db_connection(tunnel)
            cur = conn.cursor()
            cur.execute("""
                SELECT column_name
                FROM information_schema.columns
                WHERE table_schema = 'bhigis_webuser'
                AND table_name = 'new_geo_loc'
                ORDER BY ordinal_position;
            """)
            db_columns = [row[0] for row in cur.fetchall()]
            cur.close()
            conn.close()
    except Exception as e:
        return jsonify({"error": f"Erreur lecture colonnes DB: {str(e)}"}), 500

    return jsonify({
        "file_columns": file_columns,
        "db_columns": db_columns
    })


# ============================================================
# Page batch + traitement
# ============================================================
@app.route("/batch_geocode", methods=["POST"])
def batch_geocode():
    file = request.files.get("file")
    mapping_json = request.form.get("mapping")

    if not file:
        return "Aucun fichier envoyé", 400
    if not mapping_json:
        return "Aucun mapping fourni", 400

    try:
        mapping = json.loads(mapping_json)
    except Exception as e:
        return f"Erreur de parsing du mapping : {e}", 400

    filename = file.filename
    base_filename, ext = os.path.splitext(filename)

    # Lecture du fichier
    # Lecture du fichier
    if ext.lower() == ".xlsx":
        df_input = pd.read_excel(file)
    elif ext.lower() == ".csv":
        df_input = pd.read_csv(file, sep=";")
    elif ext.lower() == ".ods":
        df_input = pd.read_excel(file, engine="odf")
    else:
        return "Format non supporté (xlsx, csv ou ods uniquement)", 400

    # Vérifie que les colonnes demandées existent dans le fichier
    missing_cols = [col for col in mapping.values() if col not in df_input.columns]
    if missing_cols:
        return f"Colonnes manquantes dans le fichier : {missing_cols}", 400

    # Renommer les colonnes selon le mapping
    df_input = df_input.rename(columns={v: k for k, v in mapping.items()})

    try:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            conn = get_db_connection(tunnel)
            conn.autocommit = True
            cur = conn.cursor()

            # 1. Créer un schéma de travail
            cur.execute("SELECT data.prepar_schema()")
            schema_name = cur.fetchone()[0]
            table_name = "new_geo_loc"

            # 2. Récupérer les colonnes attendues dans la table cible
            cur.execute("""
                SELECT column_name 
                FROM information_schema.columns
                WHERE table_schema = %s AND table_name = %s
                ORDER BY ordinal_position
            """, (schema_name, table_name))
            table_columns = [row[0] for row in cur.fetchall()]

            # 3. Charger les données via COPY
            csv_buffer = io.StringIO()
            df_input.to_csv(csv_buffer, index=False, header=False, sep="\t")
            csv_buffer.seek(0)

            copy_sql = f"""
                COPY {schema_name}.{table_name} ({', '.join(table_columns)})
                FROM STDIN WITH (FORMAT csv, DELIMITER E'\\t')
            """
            cur.copy_expert(copy_sql, csv_buffer)

            # 4. Exécuter les fonctions de traitement avec le schema_name
            functions_to_execute = [
                f"SELECT data.find_street('{schema_name}')",
                f"SELECT data.find_nb('{schema_name}')",
                f"SELECT data.find_errors('{schema_name}')"
            ]
            for query in functions_to_execute:
                cur.execute(query)

            # 5. Lire les résultats dans ce schéma
            engine = create_engine(
                f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}"
                f"@127.0.0.1:{tunnel.local_bind_port}/{os.getenv('DB_NAME')}"
            )
            gdf1 = gpd.read_postgis(f"SELECT * FROM {schema_name}.adress_geoloc_pt", engine, geom_col="geom")
            df2 = pd.read_sql(f"SELECT * FROM {schema_name}.missing", engine)
            df3 = pd.read_sql(f"SELECT * FROM {schema_name}.online_suggest", engine)

            # 6. Générer le ZIP
            zip_path = generate_results_zip(base_filename, gdf1, df2, df3)

            # 7. Nettoyer : supprimer le schéma temporaire
            cur.execute(f"DROP SCHEMA {schema_name} CASCADE")

            cur.close()
            conn.close()

        return send_file(zip_path, as_attachment=True, download_name=os.path.basename(zip_path))

    except Exception as e:
        return f"Erreur lors du traitement batch : {str(e)}", 500


# ============================================================
# Lancement de l’app
# ============================================================
if __name__ == "__main__":
    app.run(debug=True)