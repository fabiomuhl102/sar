#!/bin/bash
# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca Docker
# =====================================================

docker_ativo() {
    systemctl is-active --quiet docker
}

docker_versao() {
    docker --version | cut -d',' -f1
}

docker_containers() {
    docker ps -q | wc -l
}
