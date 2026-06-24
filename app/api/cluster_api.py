from flask import Blueprint, jsonify
import sqlite3

DB = "/opt/automacao/data/metrics.db"

cluster_api = Blueprint("cluster_api", __name__)


@cluster_api.route("/api/cluster")
def cluster():

    conn = sqlite3.connect(DB)
    c = conn.cursor()

    c.execute("""
        SELECT host,
               cpu,
               mem,
               disk,
               timestamp
        FROM metrics
        ORDER BY id DESC
    """)

    rows = c.fetchall()
    conn.close()

    latest = {}

    # pega último registro de cada host
    for r in rows:
        host = r[0]
        if host not in latest:
            latest[host] = {
                "host": host,
                "cpu": r[1],
                "mem": r[2],
                "disk": r[3],
                "time": r[4]
            }

    return jsonify(list(latest.values()))
