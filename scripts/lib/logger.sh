#!/bin/bash

# =====================================================
# SAR - LOGGER CENTRAL
# Versão: 1.0.0
# =====================================================

LOG_DIR="/opt/automacao/logs"
LOG_FILE="$LOG_DIR/sar.log"

mkdir -p "$LOG_DIR"

# -----------------------------------------------------
# Função base
# -----------------------------------------------------
log() {
    LEVEL="$1"
    MSG="$2"
    DATA="[$(date '+%Y-%m-%d %H:%M:%S')] [$LEVEL] $MSG"
    echo "$DATA" | tee -a "$LOG_FILE"
}

# -----------------------------------------------------
# Atalhos
# -----------------------------------------------------
log_info() {
    log "INFO" "$1"
}

log_ok() {
    log "OK" "$1"
}

log_warn() {
    log "WARN" "$1"
}

log_error() {
    log "ERROR" "$1"
}
