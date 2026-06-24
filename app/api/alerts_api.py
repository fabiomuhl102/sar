from flask import Blueprint, jsonify
import sqlite3

DB = "/opt/automacao/data/metrics.db"

alerts_api = Blueprint("alerts_api", __name__)


@alerts_api.route("/api/alerts")
def alerts():

    conn = sqlite3.connect(DB)
    conn.row_factory = sqlite3.Row
    c = conn.cursor()

    c.execute("""
        SELECT
            id,
            timestamp,
            host,
            type,
            value,
            severity,
            status,
            telegram_sent
        FROM alerts
        ORDER BY id DESC
        LIMIT 50
    """)

    rows = c.fetchall()
    conn.close()

    return jsonify([
        dict(row)
        for row in rows
    ])
