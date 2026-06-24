#!/bin/bash

set -e  # interrompe em qualquer erro real

echo "==================================="
echo " SAR INSTALLER - SAFE VERSION"
echo "==================================="

# =========================
# BASE (pode ser sobrescrito externamente)
# =========================
BASE="${BASE:-/opt/automacao}"

echo "[1/6] Criando estrutura base..."
sudo mkdir -p "$BASE"

echo "[2/6] Copiando sistema..."
sudo rsync -av \
  --exclude 'venv' \
  --exclude '__pycache__' \
  --exclude '*.pyc' \
  --exclude '.git' \
  ./ "$BASE/"

cd "$BASE" || exit 1

echo "[3/6] Criando ambiente Python..."
python3 -m venv venv
source venv/bin/activate

echo "[4/6] Instalando dependências..."
pip install --upgrade pip

if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

echo "[5/6] Criando links globais..."

sudo ln -sf "$BASE/bin/sar-backup" /usr/local/bin/sar-backup
sudo ln -sf "$BASE/bin/sar-backup-full" /usr/local/bin/sar-backup-full
sudo ln -sf "$BASE/bin/sar-backup-auto" /usr/local/bin/sar-backup-auto
sudo ln -sf "$BASE/bin/sar-backup-disaster" /usr/local/bin/sar-backup-disaster
sudo ln -sf "$BASE/bin/sar-check" /usr/local/bin/sar-check
sudo ln -sf "$BASE/bin/sar-restore" /usr/local/bin/sar-restore

echo "[6/7] Finalizando instalação..."

# =========================
# VALIDAÇÃO PÓS-INSTALL
# =========================

echo "[CHECK] Validando instalação..."

if ! command -v sar-check >/dev/null 2>&1; then
    echo "❌ sar-check não encontrado"
    exit 1
fi

if [ ! -d "$BASE/venv" ]; then
    echo "❌ venv não criado corretamente"
    exit 1
fi

if [ ! -d "$BASE/bin" ]; then
    echo "❌ bin não encontrado"
    exit 1
fi

echo "✔ Instalação validada com sucesso"

echo ""
echo "==================================="
echo " ✔ SAR INSTALADO COM SUCESSO"
echo " ✔ BASE: $BASE"
echo " ✔ READY TO USE"
echo "==================================="
