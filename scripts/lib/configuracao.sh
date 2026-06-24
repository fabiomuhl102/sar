#!/bin/bash
# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca de Configuração
# =====================================================

SAR_RAIZ="/opt/automacao"

SAR_CONFIG="$SAR_RAIZ/configs"
SAR_LIB="$SAR_RAIZ/scripts/lib"
SAR_BIN="$SAR_RAIZ/bin"
SAR_BACKUP="/mnt/backups"
SAR_LOG="$SAR_RAIZ/logs"
SAR_MONITOR="$SAR_RAIZ/monitor"
SAR_RESTORE="$SAR_RAIZ/restore"
SAR_TEMP="$SAR_RAIZ/temp"
SAR_VOLUMES="$SAR_RAIZ/volumes"

source "$SAR_CONFIG/servicos.conf"
