#!/bin/bash

# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca de Serviços
# =====================================================

source /opt/automacao/scripts/lib/configuracao.sh

# -----------------------------------------------------
# Verifica se um container existe
# -----------------------------------------------------
servico_existe() {
    local SERVICO="$1"

    docker container inspect "$SERVICO" >/dev/null 2>&1
}

# -----------------------------------------------------
# Verifica se um container está em execução
# -----------------------------------------------------
servico_online() {
    local SERVICO="$1"

    docker ps --format '{{.Names}}' | grep -qx "$SERVICO"
}

# -----------------------------------------------------
# Obtém o status textual
# -----------------------------------------------------
servico_status() {

    local SERVICO="$1"

    if ! servico_existe "$SERVICO"; then
        echo "INEXISTENTE"
        return
    fi

    if servico_online "$SERVICO"; then
        echo "ONLINE"
    else
        echo "OFFLINE"
    fi

}

# -----------------------------------------------------
# Iniciar
# -----------------------------------------------------
servico_iniciar() {

    docker start "$1" >/dev/null

}

# -----------------------------------------------------
# Parar
# -----------------------------------------------------
servico_parar() {

    docker stop "$1" >/dev/null

}

# -----------------------------------------------------
# Reiniciar
# -----------------------------------------------------
servico_reiniciar() {

    docker restart "$1" >/dev/null

}

# -----------------------------------------------------
# Logs
# -----------------------------------------------------
servico_logs() {

    docker logs --tail 30 "$1"

}
