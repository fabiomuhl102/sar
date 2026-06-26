#!/usr/bin/env bash

set -e

BASE="$(cd "$(dirname "$0")" && pwd)"
LOG="/var/log/sar-install.log"

mkdir -p /var/log

exec > >(tee -a "$LOG") 2>&1

# =========================
# HEADER
# =========================

echo "========================================"
echo "     SAR INSTALLER V3 (PRODUCTION)"
echo "========================================"
echo "Log: $LOG"
echo ""

# =========================
# MENU
# =========================

echo "Selecione o modo:"
echo "1) Instalar FULL STACK (PC1 / PC2)"
echo "2) Reinstalar (SAFE MODE)"
echo "3) Apenas verificar sistema"
echo "4) Parar stack"
echo ""

read -p "Opção: " OPTION

# =========================
# FUNÇÕES
# =========================

check_docker() {
    echo "[CHECK] Docker..."
    if ! command -v docker >/dev/null 2>&1; then
        echo "❌ Docker não instalado"
        exit 1
    fi

    if ! docker info >/dev/null 2>&1; then
        echo "❌ Docker daemon não está rodando"
        exit 1
    fi
}

start_stack() {

    echo "[STACK] Iniciando serviços..."

    docker compose -f compose/mosquitto/docker-compose.yml up -d
    docker compose -f compose/homeassistant/docker-compose.yml up -d
    docker compose -f compose/nodered/docker-compose.yml up -d
    docker compose -f compose/esphome/docker-compose.yml up -d
    docker compose -f compose/portainer/docker-compose.yml up -d

    docker compose -f compose/prometheus/docker-compose.yml up -d || true
    docker compose -f compose/grafana/docker-compose.yml up -d || true
    docker compose -f compose/dashboard/docker-compose.yml up -d || true
}

stop_stack() {
    echo "[STACK] Parando serviços..."

    docker stop $(docker ps -q) || true
}

check_ports() {
    echo "[CHECK] Portas críticas..."

    ss -tuln | grep -E "1880|8123|3000|9090|9443|8088" || true
}

status_report() {
    echo ""
    echo "========== STATUS =========="
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    echo "============================"
}

# =========================
# EXECUÇÃO
# =========================

check_docker

case "$OPTION" in

1)
    echo "[MODE] FULL STACK INSTALL"
    start_stack
    ;;

2)
    echo "[MODE] SAFE REINSTALL"
    stop_stack
    start_stack
    ;;

3)
    echo "[MODE] SYSTEM CHECK"
    check_ports
    status_report
    ;;

4)
    echo "[MODE] STOP STACK"
    stop_stack
    ;;

*)
    echo "❌ Opção inválida"
    exit 1
    ;;
esac

# =========================
# FINAL
# =========================

echo ""
echo "✔ FINALIZADO"
status_report

echo ""
echo "Dashboard: http://localhost:8088"
echo "Grafana: http://localhost:3000"
echo "Node-RED: http://localhost:1880"
echo "Home Assistant: http://localhost:8123"
echo ""
echo "Log salvo em: $LOG"
