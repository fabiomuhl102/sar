import sqlite3
import os
from datetime import datetime

DB_PATH = "/opt/automacao/data/metrics.db"


# =========================
# INIT DATABASE
# =========================

def init_db():

    os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    # =========================
    # TABELA DE MÉTRICAS
    # =========================
    c.execute("""
        CREATE TABLE IF NOT EXISTS metrics (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            host TEXT,
            cpu REAL,
            mem REAL,
            disk REAL
        )
    """)

    # =========================
    # TABELA DE ALERTAS
    # =========================
    c.execute("""
        CREATE TABLE IF NOT EXISTS alerts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            timestamp TEXT,
            host TEXT,
            type TEXT,
            value REAL,
            severity TEXT,
            status TEXT
        )
    """)

    conn.commit()
    conn.close()


# =========================
# INSERT MÉTRICAS
# =========================

def insert_metrics(host, cpu, mem, disk):

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    c.execute("""
        INSERT INTO metrics (timestamp, host, cpu, mem, disk)
        VALUES (?, ?, ?, ?, ?)
    """, (
        datetime.now().isoformat(),
        host,
        cpu,
        mem,
        disk
    ))

    conn.commit()
    conn.close()


# =========================
# INSERT ALERT (manual helper opcional)
# =========================

def insert_alert(host, alert_type, value, severity="warning", status="active"):

    conn = sqlite3.connect(DB_PATH)
    c = conn.cursor()

    c.execute("""
        INSERT INTO alerts (timestamp, host, type, value, severity, status)
        VALUES (?, ?, ?, ?, ?, ?)
    """, (
        datetime.now().isoformat(),
        host,
        alert_type,
        value,
        severity,
        status
    ))

    conn.commit()
    conn.close()
