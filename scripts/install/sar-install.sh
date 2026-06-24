#!/bin/bash

# =====================================================
# SAR - INSTALLER (VERSÃO CORRIGIDA)
# =====================================================

echo
echo "=========================================================="
echo "         INSTALADOR DO SAR - SERVIDOR DE AUTOMAÇÃO"
echo "=========================================================="
echo

# -----------------------------------------------------
# Verificação de permissões (OBRIGATÓRIO)
# -----------------------------------------------------
if [ "$EUID" -ne 0 ]; then
    echo "⚠ Este instalador precisa ser executado com sudo"
    echo
    echo "Execute:"
    echo "  sudo sar-install"
    exit 1
fi

# -----------------------------------------------------
# Variáveis base
# -----------------------------------------------------
SAR_DIR="/opt/automacao"
BIN_DIR="$SAR_DIR/bin"
SCRIPT_DIR="$SAR_DIR/scripts"
LOG_DIR="$SAR_DIR/logs"

# -----------------------------------------------------
# Criação de estrutura (SEM TOCAR EM VOLUMES)
# -----------------------------------------------------
echo "ℹ Criando estrutura de diretórios..."

mkdir -p "$BIN_DIR"
mkdir -p "$SCRIPT_DIR"
mkdir -p "$SCRIPT_DIR/lib"
mkdir -p "$SAR_DIR/configs"
mkdir -p "$SAR_DIR/documentacao"
mkdir -p "$LOG_DIR"
mkdir -p /mnt/backups

echo "✔ Estrutura criada"

# -----------------------------------------------------
# Permissões SEGURAS (SEM VOLUMES)
# -----------------------------------------------------
echo "ℹ Ajustando permissões do SAR..."

chmod -R 775 "$BIN_DIR"
chmod -R 775 "$SCRIPT_DIR"
chmod -R 775 "$SAR_DIR/configs"
chmod -R 775 "$SAR_DIR/documentacao"
chmod -R 775 "$LOG_DIR"

echo "✔ Permissões ajustadas"

# -----------------------------------------------------
# Links simbólicos globais
# -----------------------------------------------------
echo "ℹ Registrando comandos globais..."

ln -sf "$BIN_DIR/sar-status" /usr/local/bin/sar-status
ln -sf "$BIN_DIR/sar-monitor" /usr/local/bin/sar-monitor
ln -sf "$BIN_DIR/sar-servicos" /usr/local/bin/sar-servicos
ln -sf "$BIN_DIR/sar-logs" /usr/local/bin/sar-logs
ln -sf "$BIN_DIR/sar-backup" /usr/local/bin/sar-backup
ln -sf "$BIN_DIR/sar-update" /usr/local/bin/sar-update
ln -sf "$BIN_DIR/sar-restore" /usr/local/bin/sar-restore
ln -sf "$BIN_DIR/sar-dash" /usr/local/bin/sar-dash

echo "✔ Comandos registrados"

# -----------------------------------------------------
# Validação final
# -----------------------------------------------------
echo
echo "ℹ Validando instalação..."

if [ -d "$SAR_DIR" ] && [ -d "$BIN_DIR" ]; then
    echo "✔ SAR instalado com sucesso"
else
    echo "✖ Falha na instalação"
    exit 1
fi

echo
echo "=========================================================="
echo "             INSTALAÇÃO FINALIZADA COM SUCESSO"
echo "=========================================================="
echo
echo "Comandos disponíveis:"
echo "  sar-status"
echo "  sar-monitor"
echo "  sar-servicos"
echo "  sar-logs"
echo "  sar-backup"
echo "  sar-update"
echo "  sar-restore"
echo "  sar-dash"
echo
