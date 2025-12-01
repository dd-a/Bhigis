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

    if address:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            conn = get_db_connection(tunnel)
            cur = conn.cursor()

            try:
                numero_int = int(numero) if numero else None
            except ValueError:
                numero_int = None

            try:
                annee_int = int(annee) if annee else None
            except ValueError:
                annee_int = None

            sql = """
                SELECT * FROM (
                    SELECT DISTINCT
                        ST_Y(ST_Transform(ST_Centroid(a.geom), 4326)) AS lat,
                        ST_X(ST_Transform(ST_Centroid(a.geom), 4326)) AS lon,
                        s.nom_rue AS rue,
                        a.comm_name AS commune,
                        a.pznc AS code_postal,
                        a.annee AS epoque,
                        a.min_nr AS numero_min,
                        a.max_nr AS numero_max,
                        ABS(min_nr - %s) + ABS(max_nr - %s) AS pertinence,
                        ABS(a.annee - %s) AS ecart_annee,
                        row_number() OVER (PARTITION BY s.rue_id, a.comm_name ORDER BY ABS(a.annee - %s)) AS filtre_annee,
                        row_number() OVER (PARTITION BY s.rue_id, a.annee, a.comm_name, a.min_nr, a.max_nr ORDER BY ABS(a.min_nr)) AS filtre_num,
                        CASE WHEN a.comm_name ILIKE %s THEN 1 ELSE 0 END AS commune_match
                    FROM couches.adresses a
                    LEFT JOIN data.street_names s
                        ON (a.rue_id, a.annee, a.lang) = (s.rue_id, s.yr_ref, s.lang)
                    WHERE s.nom_rue ILIKE %s
                    AND (%s IS NULL OR min_nr IS NULL OR max_nr IS NULL OR (%s BETWEEN min_nr AND max_nr))
                ) x
                WHERE filtre_annee = 1 AND filtre_num = 1
                ORDER BY commune_match DESC, ecart_annee NULLS LAST, pertinence NULLS LAST
                LIMIT 10;
            """

            cur.execute(sql, (
                numero_int if numero_int is not None else 0,
                numero_int if numero_int is not None else 0,
                annee_int if annee_int is not None else 0,
                annee_int if annee_int is not None else 0,
                commune if commune else '%',
                f'%{address}%',
                numero_int,
                numero_int
            ))

            rows = cur.fetchall()

            for row in rows:
                results.append({
                    'lat': row[0],
                    'lon': row[1],
                    'adresse': row[2],
                    'commune': row[3],
                    'code_postal': row[4],
                    'époque': row[5],
                    'min_nr': row[6],
                    'max_nr': row[7]
                })

            cur.close()
            conn.close()

    return jsonify(results)


if __name__ == '__main__':
    app.run(debug=True)
