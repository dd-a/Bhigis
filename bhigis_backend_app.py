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
import re
from sqlalchemy import create_engine

def get_connection():
    """
    Ouvre une connexion PostgreSQL :
    - Si USE_SSH_TUNNEL est défini à 1 → ouvre un tunnel SSH.
    - Sinon → connexion directe.
    """
    use_tunnel = os.getenv("USE_SSH_TUNNEL", "0") == "1"
    if use_tunnel:
        tunnel = get_ssh_tunnel()
        tunnel.start()
        conn = get_db_connection(tunnel)
        return conn, tunnel
    else:
        conn = get_db_connection()
        return conn, None
        
app = Flask(__name__)

# ============================================================
# Traductions simples (FR/NL)
# ============================================================
communes_fr = [
    "Anderlecht",
    "Auderghem",
    "Berchem-Sainte-Agathe",
    "Bruxelles",
    "Etterbeek",
    "Evere",
    "Forest",
    "Ganshoren",
    "Haren",
    "Ixelles",
    "Jette",
    "Koekelberg",
    "Laeken",
    "Molenbeek-Saint-Jean",
    "Neder-Over-Heembeek",
    "Saint-Gilles",
    "Saint-Josse-Ten-Noode",
    "Schaerbeek",
    "Uccle",
    "Watermael-Boitsfort",
    "Woluwe-Saint-Lambert",
    "Woluwe-Saint-Pierre"
]

communes_nl = [
    "Anderlecht",
    "Brussel",
    "Elsene",
    "Etterbeek",
    "Evere",
    "Ganshoren",
    "Haren",
    "Jette",
    "Koekelberg",
    "Laken",
    "Neder-Over-Heembeek",
    "Oudergem",
    "Schaarbeek",
    "Sint-Agatha-Berchem",
    "Sint-Gillis",
    "Sint-Jans-Molenbeek",
    "Sint-Joost-Ten-Node",
    "Sint-Lambrechts-Woluwe",
    "Sint-Pieters-Woluwe",
    "Ukkel",
    "Vorst",
    "Watermaal-Bosvoorde"
]

translations = {
    "fr": {
        "title": "Bienvenue dans BhiGIS",
        "intro": "L’outil de géolocalisation historique à Bruxelles",
        "simple_search": "⇦ Retour à la recherche simple",
        "index_title": "Localisation ponctuelle d'adresses historiques à Bruxelles",
        "batch_title": "Bienvenue dans BhiGIS (traitement par lots)",
        "file_struct": "Exemple de structure de fichier :",
        "tbl_rue": "rue",
        "tbl_num": "numero",
        "tbl_muni": "commune",
        "tbl_ann": "année",
        "tbl_other": "commentaire",
        "tbl_ex1": "Rue Royale",
        "tbl_ex2": "Bruxelles",
        "tbl_ex3": "boulangerie",
        "tbl_ex4": "Saint-Gilles",
        "tbl_ex5": "Peintres-artistes",
        "tbl_ex6": "Couture",
        "rue_default": "Rue...",
        "nr_default": "Numéro...",
        "communes": sorted(communes_fr),   # liste FR triée
        "choose_commune": "(Choisissez une commune)",
        "choose_year": "Année (ex: 1905)",
        "search_btn": "Rechercher",
        "best_result": "Meilleur",
        "copy_coord": "Copier les coordonnées",
        "unknown_address": "(adresse inconnue)",
        "epoch_label": "Époque",
        "similarity_lb": "Similarité du nom",
        "similarity_na": "Similarité non disponible",
        "dist_to_commune": "Éloignement à la commune recherchée",
        "file_error": "Erreur lecture fichier :",
        "processing_error": "Erreur lors du traitement batch :",
        "success_msg": "Les données ont bien été traitées.",
        "go_batch_btn": "📂 Ou alors aller vers la localisation par lot -->",
        "intro_batch": "Vous pouvez charger un fichier <strong>Excel (.xlsx)</strong> ou <strong>LibreOffice (.ods)</strong> ou un fichier <strong>CSV UTF-8</strong> avec séparateur <code>';'</code>. <br><br>Les adresses peuvent indifféremment être libellées en français ou en néerlandais. La structure attendue est : un identifiant unique, le nom de rue, le numéro, la commune, l’année, et un champ libre (commentaire). Les champs 'id', 'nom de rue', 'commune' doivent impérativement contenir quelque chose,	le champ 'année' est vivement conseillé, le numéro ne sera probablement pas utilisé dans les époques très anciennes (< 1850). Les noms des communes doivent être standard en français ou en néerlandais (les codes postaux sont également acceptés), et correspondre à l'époque recherchée.",
        "intro_t1": "L'application 'BhiGIS' (Brussels History Geographical Information System) permet de localiser des adresses à Bruxelles en fonction de données historiques, depuis la fin du 18ème siècle (1777) jusqu'à aujourd'hui.",
        "intro_t2": "Comme les rues peuvent aussi bien avoir conservé leur nom et leur tracé au fil du temps, qu'avoir complètement changé, ou que certains noms ont pu être utilisés à de multiples reprises dans des parties différentes de Bruxelles, plusieurs résultats sont généralement proposés (y compris dans d'autres communes) sur base d'une ressemblance de nom et d'une relative proximité temporelle et spatiale. Ceux-ci sont classés par ordre de pertinence estimée, le meilleur étant en tête.",
        "intro_t3": "Les pastilles colorées donnent une idée de la pertinence : vert pour les plus proches, rouge pour les moins bonnes correspondances, que ce soit dû à une inadéquation des noms ou de l'époque.",
        "intro_t4": "Enfin, pour les adresses anciennes les positions exactes des n° dans la rue ne sont généralement pas connues, mais si possible nous calculons une position entre les n° minimum et maximum du segment de rue trouvé, sinon nous plaçons le point au milieu de la rue.",
        "step1": "1. Sélectionnez votre fichier :",
        "step2": "2. Téléchargez vos résultats :",
        "batch_expl1": "Le fichier de résultats contient 3 tables :",
        "batch_expl2": "les adresses géocodées,",
        "batch_expl3": "les adresses non trouvées,",
        "batch_expl4": "des suggestions de correction.",
        "sstitre_result": "Résultats",
        "sstitre_legend": "Légende des couleurs",
        "legend1": "Meilleure correspondance",
        "legend2": "Moyenne",
        "legend3": "Correspondance faible",
        "legend4": "Les coordonnées des points sont disponibles en cliquant sur les globes.",
        "outro1": "BhiGIS a été développé par une équipe de ",
        "outro2": "l'IGEAT",
        "outro3": " à l'Université Libre de Bruxelles. Plus d'informations sur le projet ici: ",
        "download_btn": "3. Télécharger le fichier ZIP",
        "file_help": "Vous pouvez charger un fichier Excel (.xlsx) ou LibreOffice (.ods) ou CSV UTF-8 ; séparateur ;",
        "error1": "Aucun fichier fourni",
        "error2": "Aucun fichier envoyé",
        "error3": "Aucun fichier fourni",
        "error4": "Format non supporté (xlsx, csv ou ods attendu)",
        "error5": "Erreur lecture fichier: "
    },
    "nl": {
        "title": "Welkom bij BhiGIS",
        "intro": "Het historische geolokalisatie-instrument in Brussel",
        "simple_search": "⇦ Terug naar eenvoudige zoekopdracht",
        "index_title": "Puntlocatie van historische adressen in Brussel",
        "batch_title": "Welkom bij BhiGIS (batchverwerking)",
        "file_struct": "Voorbeeld van een bestandsstructuur :",
        "tbl_rue": "straat",
        "tbl_num": "nummer",
        "tbl_muni": "gemeente",
        "tbl_ann": "jaar",
        "tbl_other": "commentaar",
        "tbl_ex1": "Koningsstraat",
        "tbl_ex2": "Brussel",
        "tbl_ex3": "bakkerij",
        "tbl_ex4": "Sint-Gillis",
        "tbl_ex5": "Schilders-kunstenaars",
        "tbl_ex6": "Naaiwerk",
        "rue_default": "Straat...",
        "nr_default": "Nummer...",
        "communes": sorted(communes_nl),   # liste NL triée
        "choose_commune": "(Kies een gemeente)",
        "choose_year": "Jaar (ex: 1905)",
        "search_btn": "Zoeken",
        "best_result": "Best",
        "copy_coord": "Contactgegevens kopiëren",
        "unknown_address": "(onbekend adres)",
        "epoch_label": "Periode",
        "similarity_lb": "Overeenkomst in naam",
        "similarity_na": "Overeenkomst niet beschikbaar",
        "dist_to_commune": "Verwijdering naar de gewenste gemeente",
        "copy_tooltip": "Contactgegevens kopiëren",
        "file_error": "Fout bij het lezen van het bestand :",
        "processing_error": "Fout tijdens batchverwerking :",
        "success_msg": "De gegevens zijn correct verwerkt.",
        "go_batch_btn": "📂 Of ga naar batch-lokalisatie -->",
        "intro_batch": "U kunt een <strong>Excel (.xlsx)</strong> of <strong>LibreOffice (.ods)</strong> of een <strong>CSV UTF-8</strong> bestand met scheidingsteken <code>‘;’</code> uploaden. <br><br>De adressen mogen zowel in het Frans als in het Nederlands worden vermeld. De verwachte structuur is: een unieke identificatiecode, de straatnaam, het huisnummer, de gemeente, het jaar en een vrij veld (opmerking). De velden ‘id’, ‘straatnaam’ en ‘gemeente’ moeten verplicht iets bevatten. Het veld ‘jaar’ wordt sterk aanbevolen. Het huisnummer zal waarschijnlijk niet worden gebruikt voor zeer oude periodes (< 1850).	De namen van de gemeenten moeten standaard zijn in het Frans of Nederlands (postcodes worden ook geaccepteerd) en overeenkomen met de gezochte periode.",
        "intro_t1": "Met de applicatie ‘BhiGIS’ (Brussels History Geographical Information System) kunnen adressen in Brussel worden gelokaliseerd op basis van historische gegevens, vanaf het einde van de 18e eeuw (1777) tot vandaag.",
        "intro_t2": "Aangezien straten in de loop der tijd zowel hun naam en tracé kunnen hebben behouden als volledig kunnen zijn veranderd, of bepaalde namen meerdere keren in verschillende delen van Brussel kunnen zijn gebruikt, worden er meestal meerdere resultaten voorgesteld (ook in andere gemeenten) op basis van een gelijkenis in naam en een relatieve tijds- en ruimtelijke nabijheid. Deze worden gerangschikt op basis van geschatte relevantie, met de beste bovenaan.",
        "intro_t3": "De gekleurde stippen geven een indicatie van de relevantie: groen voor de meest relevante resultaten, rood voor de minst relevante resultaten, of dit nu te wijten is aan een mismatch tussen de namen of de periode.",
        "intro_t4": "Ten slotte zijn voor oude adressen de exacte posities van de huisnummers in de straat meestal niet bekend, maar indien mogelijk berekenen we een positie tussen het minimum- en maximumhuisnummer van het gevonden straatsegment, anders plaatsen we het punt in het midden van de straat.",
        "step1": "1. Selecteer uw bestand:",
        "step2": "2. Download uw resultaten:",
        "batch_expl1": "Het resultatenbestand bevat 3 tabellen :",
        "batch_expl2": "geocodeerde adressen,",
        "batch_expl3": "de niet-gevonden adressen,",
        "batch_expl4": "correctiesuggesties.",
        "sstitre_result": "Resultaten",
        "sstitre_legend": "Legenda kleuren",
        "legend1": "Beste overeenkomst",
        "legend2": "Gemiddeld",
        "legend3": "Slechte overeenkomst",
        "legend4": "De coördinaten van de punten zijn beschikbaar door op de globes te klikken.",
        "outro1": "BhiGIS is ontwikkeld door een team van ",
        "outro2": "IGEAT",
        "outro3": " aan de Vrije Universiteit Brussel. Meer informatie over het project vindt u hier: ",
        "download_btn": "3. Download het ZIP-bestand",
        "file_help": "U kunt een Excel-bestand (.xlsx) of LibreOffice (.ods) of CSV UTF-8 ; scheidingsteken ; uploaden",
        "error1": "Geen bestand opgegeven",
        "error2": "Geen bestand geselecteerd",
        "error3": "Geen bestand opgegeven",
        "error4": "Niet-ondersteund formaat (xlsx, csv of ods verwacht)",
        "error5": "Fout bij het lezen van het bestand: "
    }
}


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
    lang = request.args.get("lang", "fr")
    if lang not in translations:
        lang = "fr"
    return render_template("index.html", t=translations[lang], lang=lang)

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
    lang = request.args.get("lang", "fr")
    if lang not in translations:
        lang = "fr"
    return render_template("batch.html", t=translations[lang], lang=lang)


# ============================================================
# Génération des résultats batch
# ============================================================
def generate_results_zip(base_filename, gdf1, df2, df3,
                         style1="bhigis_style.qml", style2="not_found_style.qml"):
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
        return jsonify({"error": {{ t.error1 }}}), 400

    filename = file.filename
    base_filename, ext = os.path.splitext(filename)
    base_filename = re.sub(r'[^A-Za-z0-9_\-]', '_', base_filename)  # remplace tout caractère non alphanumérique (ni _ ni -) par un underscore _.

    # Lire fichier
    try:
        if ext.lower() == ".xlsx":
            df = pd.read_excel(file)
        elif ext.lower() == ".csv":
            df = pd.read_csv(file, sep=";")
        elif ext.lower() == ".ods":
            df = pd.read_excel(file, engine="odf")
        else:
            return jsonify({"error": {{ t.error4 }}}), 400
    except Exception as e:
        return jsonify({"error": t[lang]["error5"] + {str(e)}}), 500

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
        return {{ t.error2 }}, 400
    if not mapping_json:
        return {{ t.error3 }}, 400

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
        return t[lang]["error4"], 400

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

        print(zip_filename)
        return send_file(
            zip_path, 
            as_attachment=True, 
            #download_name=zip_filename,
            download_name=os.path.basename(zip_path))
            mimetype="application/zip"
        )

    except Exception as e:
        return f"Erreur lors du traitement batch : {str(e)}", 500


# ============================================================
# Lancement de l’app
# ============================================================
if __name__ == "__main__":
    app.run(debug=True)
