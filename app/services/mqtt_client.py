import json
import paho.mqtt.client as mqtt

from app.config.settings import (
    MQTT_ENABLED,
    MQTT_HOST,
    MQTT_PORT,
    MQTT_KEEPALIVE,
    MQTT_TOPIC_BASE,
    MQTT_TOPIC_ALERTS
)

MQTT_USER = "mqtt"
MQTT_PASSWORD = "mqtt123"


class MQTTClient:

    def __init__(self):

        self.client = mqtt.Client()

        self.client.username_pw_set(
            MQTT_USER,
            MQTT_PASSWORD
        )

        if MQTT_ENABLED:

            self.client.connect(
                MQTT_HOST,
                MQTT_PORT,
                MQTT_KEEPALIVE
            )

            self.client.loop_start()

    def publish_alert(
        self,
        host,
        alert_type,
        value,
        severity
    ):

        if not MQTT_ENABLED:
            return

        topic = f"{MQTT_TOPIC_BASE}/{MQTT_TOPIC_ALERTS}/{host}"

        payload = {
            "host": host,
            "type": alert_type,
            "value": value,
            "severity": severity
        }

        result = self.client.publish(
            topic,
            json.dumps(payload),
            qos=0,
            retain=False
        )

        print(
            f"[MQTT] topic={topic} rc={result.rc}"
        )


mqtt_client = MQTTClient()
