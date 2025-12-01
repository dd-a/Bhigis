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
    result = {}

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

            query = """
                SELECT ST_Y(ST_Transform(ST_Centroid(a.geom), 4326)), 
                        ST_X(ST_Transform(ST_Centroid(a.geom), 4326)),
                        s.nom_rue rue, 
                        a.comm_name commune, 
                        a.pznc code_postal, 
                        a.annee epoque, 
                        a.min_nr numero_min, 
                        a.max_nr numero_max,
                       ABS(min_nr - %s) + ABS(max_nr - %s) AS pertinence,
                       ABS(a.annee - %s) AS ecart_annee
                FROM couches.adresses a
                LEFT JOIN couches.streets s ON (a.rue_id, a.annee, a.lang) = (s.rue_id, s.annee, s.lang)
                WHERE s.nom_rue ILIKE %s
                 AND (
                     min_nr IS NULL OR 
                     max_nr IS NULL OR 
                     (%s BETWEEN min_nr AND max_nr)
                  )
                ORDER BY ecart_annee NULLS LAST, pertinence NULLS LAST
                LIMIT 10;
            """

            cur.execute(query, (
                numero_int, numero_int,
                annee_int,
                f'%{address}%',
                numero_int
            ))
            
            rows = cur.fetchall()
            results = []

            for row in rows:
                results.append({
                    'lat': row[0],
                    'lon': row[1],
                    'commune': row[2],
                    'code_postal': row[3],
                    'époque': row[4],
                    'min_nr': row[5],
                    'max_nr': row[6],
                    'adresse': row[7]
                })
            

            # row = cur.fetchone()
            # if row:
            #     result = {
            #         'lat': row[0],
            #         'lon': row[1],
            #         'rue': row[2],
            #         'code_postal': row[3],
            #         'commune': row[4],
            #         'époque': row[5],
            #         'min_nr': row[6],
            #         'max_nr': row[7]
            #     }

            cur.close()
            conn.close()

    return jsonify(results)


# @app.route('/geocode')
# def geocode():
#     address = request.args.get('address', '')
#     numero = request.args.get('numero', None)
#     result = {}
#
#     if address:
#         with get_ssh_tunnel() as tunnel:
#             tunnel.start()
#             conn = get_db_connection(tunnel)
#             cur = conn.cursor()
#             cur.execute("""
#                 SELECT ST_Y(ST_Centroid(a.geom)),
#                     ST_X(ST_Centroid(a.geom)),
#                     a.pznc code_postal,
#                     a.comm_name commune,
#                     a.annee epoque,
#                     a.min_nr numero_min,
#                     a.max_nr numero_max,
#                     ABS(a.min_nr - %s) + ABS(a.max_nr - %s) AS pertinence
#                 FROM couches.adresses a
#                 LEFT JOIN couches.streets s ON (a.rue_id, a.annee, a.lang) = (s.rue_id, s.annee, s.lang)
#                 WHERE s.nom_rue ILIKE %s
#                 AND (
#                     min_nr IS NULL OR
#                     max_nr IS NULL OR
#                     (%s BETWEEN min_nr AND max_nr)
#                     )
#                 ORDER BY ORDER BY ABS(epoque - %s)) DESC, pertinence NULLS LAST
#                 LIMIT 10;
#             """, (numero, numero, f'%{address}%', numero))
#             row = cur.fetchone()
#             if row:
#                 result = {
#                     'lat': row[0],
#                     'lon': row[1],
#                     'code_postal': row[2],
#                     'commune': row[3],
#                     'époque': row[4],
#                     'min_nr': row[5],
#                     'max_nr': row[6]
#                 }
#             cur.close()
#             conn.close()
#
#     return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)
