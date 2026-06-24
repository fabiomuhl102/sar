"""
Configurações gerais do Sistema de Automação
"""

# -------------------------------------------------------------------
# Banco de Dados
# -------------------------------------------------------------------

DB_PATH = "/opt/automacao/data/metrics.db"


# -------------------------------------------------------------------
# Servidor Flask
# -------------------------------------------------------------------

FLASK_HOST = "0.0.0.0"
FLASK_PORT = 8088


# -------------------------------------------------------------------
# Informações do Sistema
# -------------------------------------------------------------------

SYSTEM_NAME = "Sistema de Automação"

VERSION = "1.0.0"


# -------------------------------------------------------------------
# Intervalo de coleta
# -------------------------------------------------------------------

COLLECT_INTERVAL = 5

# -------------------------------------------------------------------
# MQTT
# -------------------------------------------------------------------

MQTT_ENABLED = True

MQTT_HOST = "127.0.0.1"

MQTT_PORT = 1883

MQTT_KEEPALIVE = 60

MQTT_TOPIC_BASE = "automacao"

MQTT_TOPIC_ALERTS = "alerts"

MQTT_TOPIC_METRICS = "metrics"

MQTT_TOPIC_DISCOVERY = "discovery"

MQTT_TOPIC_COMMANDS = "commands"
