from flask import Blueprint, jsonify
import sqlite3

metrics_api = Blueprint("metrics_api", __name__)

DB = "/opt/automacao/data/metrics.db"


@metrics_api.route("/api/metrics/latest")
def latest_metrics():
    conn = sqlite3.connect(DB)
    c = conn.cursor()

    c.execute("""
        SELECT timestamp, host, cpu, mem, disk
        FROM metrics
        ORDER BY id DESC
        LIMIT 1
    """)

    row = c.fetchone()

    if not row:
        return jsonify({"error": "no data"}), 404

    return jsonify({
        "timestamp": row[0],
        "host": row[1],
        "cpu": row[2],
        "mem": row[3],
        "disk": row[4]
    })
