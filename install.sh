#!/usr/bin/env bash

set -euo pipefail

BASE="/opt/automacao/sar_git"
COMPOSE_FILE="$BASE/compose.yml"
LOG="$BASE/logs/sar-v4.log"
mkdir -p /var/log
exec > >(tee -a "$LOG") 2>&1

echo "========================================"
echo "   SAR INSTALLER V4 - PROFESSIONAL"
echo "========================================"
echo "Base: $BASE"
echo "Log : $LOG"
echo ""

# -------------------------
# CHECK DOCKER
# -------------------------
check_docker() {
    echo "[CHECK] Docker..."
    command -v docker >/dev/null || { echo "Docker não instalado"; exit 1; }
    docker info >/dev/null || { echo "Docker daemon não ativo"; exit 1; }
}

# -------------------------
# STOP SAFE
# -------------------------
stop_stack() {
    echo "[STACK] Parando stack V4..."
    docker compose -f "$COMPOSE_FILE" down --remove-orphans || true
}

# -------------------------
# START STACK
# -------------------------
start_stack() {
    echo "[STACK] Subindo stack V4..."
    docker compose -f "$COMPOSE_FILE" up -d --remove-orphans
}

# -------------------------
# CLEAN SAFE (NUNCA DESTRUTIVO)
# -------------------------
cleanup() {
    echo "[CLEAN] Removendo apenas orphans e redes antigas..."
    docker container prune -f || true
    docker network prune -f || true
}

# -------------------------
# STATUS
# -------------------------
status() {
    echo ""
    echo "=========== STATUS ==========="
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    echo "=============================="
}

# -------------------------
# MENU
# -------------------------
echo "Selecione:"
echo "1) START STACK"
echo "2) RESTART STACK"
echo "3) STOP STACK"
echo "4) CLEAN + START"
echo "5) STATUS"
echo ""

read -p "Opção: " opt

check_docker

case "$opt" in

1)
    start_stack
    ;;

2)
    stop_stack
    start_stack
    ;;

3)
    stop_stack
    ;;

4)
    stop_stack
    cleanup
    start_stack
    ;;

5)
    status
    ;;

*)
    echo "Opção inválida"
    exit 1
    ;;
esac

echo ""
status
echo ""
echo "✔ FINALIZADO V4"
