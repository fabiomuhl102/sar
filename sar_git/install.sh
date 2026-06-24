#!/bin/bash

echo "==================================="
echo "  SAR INSTALLER"
echo "==================================="

BASE="/opt/automacao"

echo "[1/5] Criando estrutura..."
mkdir -p "$BASE"
mkdir -p "$BASE/backup"
mkdir -p "$BASE/logs"

echo "[2/5] Copiando scripts..."

cp -r ./scripts "$BASE/"
cp -r ./config "$BASE/"

echo "[3/5] Ajustando permissões..."
chmod +x "$BASE/scripts/maintenance/"*.sh 2>/dev/null
chmod +x "$BASE/scripts/"* 2>/dev/null

echo "[4/5] Criando links globais..."

ln -sf "$BASE/scripts/maintenance/sar-backup-disaster.sh" /usr/local/bin/sar-backup-disaster
ln -sf "$BASE/scripts/maintenance/sar-backup-auto.sh" /usr/local/bin/sar-backup-auto

echo "[5/5] Finalizado"

echo "SAR instalado com sucesso"
