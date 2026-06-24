#!/bin/bash
# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca do Sistema Operacional
# =====================================================

sistema_nome() {
    source /etc/os-release
    echo "$PRETTY_NAME"
}

kernel_versao() {
    uname -r
}

hostname_servidor() {
    hostname
}

uptime_servidor() {
    uptime -p
}

data_hora() {
    date "+%d/%m/%Y %H:%M:%S"
}
