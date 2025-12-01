from flask import Flask, render_template, request, jsonify
from db.db_config import get_db_connection
import psycopg2

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/autocomplete')
def autocomplete():
    query = request.args.get('q', '')
    results = []

    if query:
        conn = get_db_connection()
        cur = conn.cursor()
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

    if address:
        conn = get_db_connection()
        cur = conn.cursor()

        try:
            numero_int = int(numero) if numero else None
        except ValueError:
            numero_int = None

        try:
            annee_int = int(annee) if annee else None
        except ValueError:
            annee_int = None

        # 1. Nettoyage de la table temporaire utilisateur
        cur.execute("DELETE FROM bhigis_webuser.new_geo_loc")

        # 2. Insertion des données utilisateur
        cur.execute("""
            INSERT INTO bhigis_webuser.new_geo_loc (nom_rue, numero, annee, commune)
            VALUES (%s, %s, %s, %s)
        """, (address, numero_int, annee_int, commune))

        # 3. Lancer le traitement
        cur.execute("SELECT data.run_webuser()")

        # 4. Lire les résultats
        cur.execute("""
            SELECT
                ST_Y(ST_Transform(ST_Centroid(geom), 4326)) AS lat,
                ST_X(ST_Transform(ST_Centroid(geom), 4326)) AS lon,
                found_street AS rue,
                commune_loc AS commune,
                annee_ref AS epoque,
                simila,
                dist_muni,
                best_answer,
                CASE WHEN %s ILIKE commune THEN 1 ELSE 0 END AS commune_match
            FROM bhigis_webuser.adress_collect_pt
        """, (commune,))

        rows = cur.fetchall()

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
    app.run(debug=False, host='0.0.0.0', port=8000)