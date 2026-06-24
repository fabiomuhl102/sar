from flask import Blueprint, jsonify, request
import sqlite3
from datetime import datetime, timedelta

HIST_DB = "/opt/automacao/data/metrics.db"

history_api = Blueprint("history_api", __name__)


@history_api.route("/api/history")
def history():

    period = request.args.get("period", "1h")
    host = request.args.get("host", None)

    now = datetime.now()

    if period == "10m":
        start_time = now - timedelta(minutes=10)
    elif period == "24h":
        start_time = now - timedelta(hours=24)
    else:
        start_time = now - timedelta(hours=1)

    conn = sqlite3.connect(HIST_DB)
    c = conn.cursor()

    if host:
        c.execute("""
            SELECT timestamp, cpu, mem, disk
            FROM metrics
            WHERE timestamp >= ? AND host = ?
            ORDER BY id ASC
        """, (start_time.isoformat(), host))
    else:
        c.execute("""
            SELECT timestamp, cpu, mem, disk
            FROM metrics
            WHERE timestamp >= ?
            ORDER BY id ASC
        """, (start_time.isoformat(),))

    rows = c.fetchall()
    conn.close()

    return jsonify([
        {
            "time": r[0],
            "cpu": r[1],
            "mem": r[2],
            "disk": r[3]
        }
        for r in rows
    ])
