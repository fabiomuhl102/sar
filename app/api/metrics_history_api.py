from flask import Blueprint, jsonify
import sqlite3

metrics_history_api = Blueprint("metrics_history_api", __name__)

DB = "/opt/automacao/data/metrics.db"


@metrics_history_api.route("/api/metrics/history")
def metrics_history():
    conn = sqlite3.connect(DB)
    c = conn.cursor()

    c.execute("""
        SELECT timestamp, cpu, mem, disk
        FROM metrics
        ORDER BY id DESC
        LIMIT 20
    """)

    rows = c.fetchall()

    rows.reverse()

    return jsonify([
        {
            "timestamp": r[0],
            "cpu": r[1],
            "mem": r[2],
            "disk": r[3]
        }
        for r in rows
    ])
