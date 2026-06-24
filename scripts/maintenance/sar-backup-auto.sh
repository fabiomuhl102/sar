#!/bin/bash

# =====================================================
# SAR - Backup Automático
# Executado via cron
# =====================================================

# -----------------------------------------------------
# Carrega ambiente base (ordem importa)
# -----------------------------------------------------
source /opt/automacao/scripts/lib/logger.sh
source /opt/automacao/scripts/lib/configuracao.sh
source /opt/automacao/scripts/lib/identidade.sh

LOG="/opt/automacao/logs/backup.log"

# -----------------------------------------------------
# Início do processo
# -----------------------------------------------------
log_info "Iniciando backup automático do SAR"

# -----------------------------------------------------
# Verificação do sistema
# -----------------------------------------------------
/usr/local/bin/sar-check >/dev/null 2>&1

if [ $? -ne 0 ]; then
    log_error "sar-check falhou. Backup abortado por segurança"
    exit 1
fi

# -----------------------------------------------------
# Execução do backup
# -----------------------------------------------------
/usr/local/bin/sar-backup >> "$LOG" 2>&1

if [ $? -eq 0 ]; then
    log_ok "Backup concluído com sucesso"
else
    log_error "Falha na execução do backup"
fi

# -----------------------------------------------------
# Limpeza de backups antigos (retenção 7 dias)
# -----------------------------------------------------
find /mnt/backups -name "sar_backup_*.tar.gz" -mtime +7 -delete

log_info "Limpeza de backups antigos executada"
