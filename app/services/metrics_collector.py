import psutil
import sqlite3
import time
import socket
from datetime import datetime

from app.services.alert_service import AlertService

DB = "/opt/automacao/data/metrics.db"


def collect_metrics():
    conn = sqlite3.connect(DB)
    c = conn.cursor()

    host = socket.gethostname()

    while True:
        cpu = psutil.cpu_percent(interval=1)
        mem = psutil.virtual_memory().percent
        disk = psutil.disk_usage('/').percent
        timestamp = datetime.now().isoformat()

        # =========================
        # SALVA MÉTRICAS
        # =========================
        c.execute("""
            INSERT INTO metrics (timestamp, host, cpu, mem, disk)
            VALUES (?, ?, ?, ?, ?)
        """, (timestamp, host, cpu, mem, disk))

        conn.commit()

        # =========================
        # PROCESSA ALERTAS
        # =========================
        AlertService.process(conn, host, cpu, mem, disk)

        print(f"[METRICS] {timestamp} host={host} cpu={cpu}% mem={mem}% disk={disk}%")

        time.sleep(5)


if __name__ == "__main__":
    collect_metrics()
