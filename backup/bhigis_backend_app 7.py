from flask import Flask, render_template, request, jsonify
from db.db_config import get_ssh_tunnel, get_db_connection
import psycopg2
import os

app = Flask(__name__)

# Connexion à la base PostgreSQL (à adapter plus tard pour le tunnel sécurisé)
def get_db_connection(tunnel):
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host='127.0.0.1',
        port=tunnel.local_bind_port
    )

@app.route('/')
def index():
    return render_template('index.html')

# Endpoint pour l'autocomplétion
@app.route('/autocomplete')
def autocomplete():
    query = request.args.get('q', '')
    results = []

    if query:
        conn = get_db_connection()
        cur = conn.cursor()
        # Exemple de requête à adapter selon ta fonction SQL
        cur.execute("SELECT address FROM couches.adresses WHERE address ILIKE %s LIMIT 10", (f'%{query}%',))
        results = [row[0] for row in cur.fetchall()]
        cur.close()
        conn.close()

    return jsonify(results)

@app.route('/geocode')
def geocode():
    address = request.args.get('address', '')
    numero = request.args.get('numero', None)
    annee = request.args.get('annee', None)
    commune = request.args.get('commune', '').strip()
    results = []
    #print("==> Appel à /geocode reçu")

    if address:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            #print(f"Tunnel SSH ouvert sur le port local {tunnel.local_bind_port}")
            conn = get_db_connection(tunnel)
            conn.autocommit = True      # à commenter après les tests AUTOCOMMIT
            cur = conn.cursor()
            #print("Connexion réussie à PostgreSQL !")
            #print(conn.notices)

            try:
                numero_int = int(numero) if numero else None
            except ValueError:
                numero_int = None

            try:
                annee_int = int(annee) if annee else None
            except ValueError:
                annee_int = None
            # print("==> Appel à /geocode reçu")
            # 1. Vider la table (ou à adapter selon logique)
            cur.execute("TRUNCATE bhigis_webuser.new_geo_loc")
            #print("DELETE FROM bhigis_webuser.new_geo_loc")
            #print(conn.notices)
            
            #cur.execute("INSERT INTO debug(texte, source) SELECT  '1. delete new_geo_loc', 'bhigis_backend_app.py' ")

            # 2. Insérer les données utilisateur
            cur.execute("""
                INSERT INTO bhigis_webuser.new_geo_loc (nom_rue, numero, annee, commune)
                VALUES (%s, %s, %s, %s)
            """, (address, numero_int, annee_int, commune))
            
            # 3. Appeler la fonction de traitement
            # cur.execute("LOCK TABLE bhigis_webuser.new_geo_loc IN ACCESS EXCLUSIVE MODE")
            cur.execute("SELECT data.run_webuser()")

            # 4. Lire les résultats produits
            cur.execute("""
                SELECT DISTINCT
                    ST_Y(ST_Transform(ST_Centroid(geom), 4326)) AS lat,
                    ST_X(ST_Transform(ST_Centroid(geom), 4326)) AS lon,
                    found_street AS rue,
                    commune_loc AS commune,
                    annee_ref AS epoque,
                    ROUND(simila::numeric, 2)::numeric simila,
                    dist_muni,
                    best_answer,
                    CASE WHEN %s ILIKE commune THEN 1 ELSE 0 END AS commune_match
                FROM bhigis_webuser.adress_collect_pt
                WHERE simila > 0.25
                ORDER BY best_answer ASC, simila DESC, commune_match, dist_muni
                LIMIT 10
            """, (commune,))

            rows = cur.fetchall()
            for row in cur.fetchall():
                        print(f"| **{row[0]}** | {row[1]} |")

            for row in rows:
                results.append({
                    'lat': row[0],
                    'lon': row[1],
                    'adresse': row[2],
                    'commune': row[3],
                    'époque': row[4],
                    'simila': row[5],
                    'dist_muni': row[6],
                    'best_answer': row[7],
                    'commune_match': row[8]
                })

            cur.close()
            conn.close()

    return jsonify(results)

if __name__ == '__main__':
    app.run(debug=True)
