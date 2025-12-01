from db.db_config import get_ssh_tunnel, get_db_connection

def test_db():
    try:
        with get_ssh_tunnel() as tunnel:
            tunnel.start()
            print(f"Tunnel SSH ouvert sur le port local {tunnel.local_bind_port}")
            conn = get_db_connection(tunnel)
            cur = conn.cursor()
            cur.execute("SELECT version();")
            version = cur.fetchone()
            print("Connexion réussie à PostgreSQL ! Version :", version[0])
            cur.close()
            conn.close()
    except Exception as e:
        print("Erreur de connexion :", e)

if __name__ == "__main__":
    test_db()
