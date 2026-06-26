# =====================================================
# SAR V5 - MOTOR DE STACK (PROFISSIONAL)
# =====================================================

docker_stack() {

BASE="/opt/automacao/sar_git/docker"

case "$1" in

start)
    echo "[DOCKER] Iniciando stack..."
    docker compose -f "$BASE/compose.yml" up -d
    ;;

restart)
    echo "[DOCKER] Reiniciando stack..."
    docker compose -f "$BASE/compose.yml" restart
    ;;

stop)
    echo "[DOCKER] Parando stack..."
    docker compose -f "$BASE/compose.yml" down
    ;;

clean_start)
    echo "[DOCKER] Limpando e iniciando stack..."
    docker compose -f "$BASE/compose.yml" down
    docker compose -f "$BASE/compose.yml" up -d
    ;;

status)
    echo ""
    echo "========== STATUS SAR =========="
    docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
    echo "================================"
    ;;

logs)
    echo "[DOCKER] Logs gerais (Ctrl+C para sair)"
    docker compose -f "$BASE/compose.yml" logs -f
    ;;

*)
    echo "Uso: docker_stack {start|restart|stop|clean_start|status|logs}"
    ;;

esac

}
