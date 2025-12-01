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
    result = {}

    if address:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            conn = get_db_connection(tunnel)
            cur = conn.cursor()
            cur.execute("""
                SELECT ST_Y(ST_Centroid(geom)), 
                    ST_X(ST_Centroid(geom)), 
                    pznc code_postal, 
                    comm_name commune, 
                    annee epoque, 
                    min_nr numero_min, 
                    max_nr numero_max, 
                    ABS(min_nr - %s) + ABS(max_nr - %s) AS pertinence
                FROM couches.adresses
                WHERE address ILIKE %s
                AND (
                    min_nr IS NULL OR 
                    max_nr IS NULL OR 
                    (%s BETWEEN min_nr AND max_nr)
                    )
                ORDER BY epoque DESC, pertinence NULLS LAST
                LIMIT 10;
            """, (numero, numero, f'%{address}%', numero))
            row = cur.fetchone()
            if row:
                result = {
                    'lat': row[0], 
                    'lon': row[1],
                    'code_postal': row[2],
                    'commune': row[3],
                    'époque': row[4],
                    'min_nr': row[5],
                    'max_nr': row[6]
                }
            cur.close()
            conn.close()

    return jsonify(result)


if __name__ == '__main__':
    app.run(debug=True)
