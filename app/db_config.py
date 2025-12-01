from pathlib import Path
from dotenv import load_dotenv
#load_dotenv(dotenv_path=Path(__file__).resolve().parent / "bhigispro_config.env")
import os
import psycopg2

#load_dotenv(dotenv_path="/opt/bhigis/app/bhigispro_config.env")
load_dotenv(dotenv_path="bhigispro_config.env")

#print("DB_USER =", os.getenv("DB_USER"))

#load_dotenv(dotenv_path=Path(__file__).resolve().parent / "bhigispro_config.env")

def get_db_connection():
    return psycopg2.connect(
        dbname=os.getenv("DB_NAME"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        host=os.getenv("DB_HOST", "localhost"),
        port=int(os.getenv("DB_PORT", 5432))
    )
