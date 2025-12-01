import os
from dotenv import load_dotenv
from sshtunnel import SSHTunnelForwarder
import psycopg2

load_dotenv(dotenv_path="bhigispro_config.env")

def get_ssh_tunnel():
    return SSHTunnelForwarder(
        (os.getenv("SSH_HOST"), int(os.getenv("SSH_PORT"))),
        ssh_username=os.getenv("SSH_USER"),
        ssh_pkey=os.getenv("SSH_KEY_PATH"),
        remote_bind_address=('127.0.0.1', 5432)
    )

def get_db_connection(tunnel):
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host='127.0.0.1',
        port=tunnel.local_bind_port
    )
