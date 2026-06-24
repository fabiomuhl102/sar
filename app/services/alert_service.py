import sqlite3
from datetime import datetime

from app.services.mqtt_client import mqtt_client

DB = "/opt/automacao/data/metrics.db"


class AlertService:

    @staticmethod
    def get_active_alert(conn, host, alert_type):
        c = conn.cursor()

        c.execute("""
            SELECT id
            FROM alerts
            WHERE host=?
              AND type=?
              AND status='active'
            LIMIT 1
        """, (host, alert_type))

        return c.fetchone()

    @staticmethod
    def create_alert(conn, host, alert_type, value, severity="critical"):
        c = conn.cursor()

        c.execute("""
            INSERT INTO alerts
            (timestamp, host, type, value, severity, status, telegram_sent)
            VALUES (?, ?, ?, ?, ?, ?, ?)
        """, (
            datetime.now().isoformat(),
            host,
            alert_type,
            value,
            severity,
            "active",
            0
        ))

        conn.commit()

        # Publica automaticamente no MQTT
        mqtt_client.publish_alert(
            host=host,
            alert_type=alert_type,
            value=value,
            severity=severity
        )

    @staticmethod
    def close_alert(conn, alert_id):
        c = conn.cursor()

        c.execute("""
            UPDATE alerts
               SET status='resolved'
             WHERE id=?
        """, (alert_id,))

        conn.commit()

    @staticmethod
    def process(conn, host, cpu, mem, disk):

        metrics = {
            "cpu": cpu,
            "mem": mem,
            "disk": disk
        }

        thresholds = {
            "cpu": 80,
            "mem": 80,
            "disk": 90
        }

        for alert_type, value in metrics.items():

            active = AlertService.get_active_alert(
                conn,
                host,
                alert_type
            )

            if value > thresholds[alert_type]:

                if not active:
                    AlertService.create_alert(
                        conn,
                        host,
                        alert_type,
                        value
                    )

            else:

                if active:
                    AlertService.close_alert(
                        conn,
                        active[0]
                    )
