#!/bin/bash

# =====================================================
# SAR - DISASTER RECOVERY (EVOLUÇÃO SEGURA)
# APP + VOLUMES (compatível com sistema atual)
# =====================================================

BACKUP_DIR="/mnt/backups"
LOG="/opt/automacao/logs/restore.log"

APP_DIR="/opt/automacao"
VOLUMES_DIR="/opt/automacao/volumes"

mkdir -p "$(dirname "$LOG")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG"
}

clear

echo "========================================="
echo "   SAR DISASTER RECOVERY (SAFE MODE)"
echo "========================================="
echo ""
echo "⚠️  SISTEMA SERÁ RESTAURADO"
echo "    APP + CONFIGS + (VOLUMES se existir backup)"
echo ""

# -----------------------------------------------------
# LISTAR BACKUPS
# -----------------------------------------------------
echo "📦 Backups disponíveis:"
echo ""
ls -1t "$BACKUP_DIR" | grep "sar_backup" | head -n 10
echo ""

read -p "Digite o nome EXATO do backup APP: " APP_BACKUP

APP_PATH="$BACKUP_DIR/$APP_BACKUP"

if [ ! -f "$APP_PATH" ]; then
    log "ERRO: Backup APP não encontrado"
    echo "❌ Arquivo inválido"
    exit 1
fi

echo ""
echo "📄 Backup APP selecionado:"
echo "$APP_PATH"
echo ""

read -p "⚠️ CONFIRMA RESTAURAÇÃO DO SISTEMA? (digite YES): " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    log "Restore cancelado pelo usuário"
    echo "❌ Cancelado"
    exit 0
fi

# -----------------------------------------------------
# BACKUP DE SEGURANÇA DO ESTADO ATUAL
# -----------------------------------------------------
SAFE="sar_pre_restore_$(date +%F_%H-%M-%S).tar.gz"

log "Criando backup de segurança do estado atual"

tar -czf "$BACKUP_DIR/$SAFE" \
    "$APP_DIR" \
    "$VOLUMES_DIR" \
    /opt/automacao/configs 2>/dev/null

log "Backup de segurança criado: $SAFE"

# -----------------------------------------------------
# RESTAURAÇÃO APP
# -----------------------------------------------------
log "Restaurando APP"

tar -xzf "$APP_PATH" -C /

if [ $? -ne 0 ]; then
    log "ERRO na restauração do APP"
    exit 1
fi

# -----------------------------------------------------
# VERIFICAR VOLUMES
# -----------------------------------------------------
if [ -d "$VOLUMES_DIR" ]; then
    log "Volumes detectados no sistema"

    echo ""
    echo "ℹ️ Volumes existem no sistema."
    echo "⚠️ Backup de volumes separado ainda não detectado automaticamente."
    echo "👉 Eles não foram alterados neste restore."
fi

# -----------------------------------------------------
# FINAL
# -----------------------------------------------------
log "RESTORE CONCLUÍDO COM SUCESSO"

echo ""
echo "✅ Sistema restaurado com sucesso"
echo "🔁 Recomenda-se reiniciar Docker/serviços"
echo ""
