#!/bin/bash

set -e  # 🔥 para tudo se der erro

echo "==================================="
echo " SAR INSTALLER - SAFE VERSION"
echo "==================================="

BASE="/opt/automacao"

echo "[1/6] Criando estrutura base..."
sudo mkdir -p "$BASE"

echo "[2/6] Copiando sistema..."
sudo rsync -av \
  --exclude 'venv' \
  --exclude '__pycache__' \
  --exclude '*.pyc' \
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
sudo ln -sf "$BASE/bin/sar-backup-disaster" /usr/local/bin/sar-backup-disaster
sudo ln -sf "$BASE/bin/sar-backup-auto" /usr/local/bin/sar-backup-auto

echo "[6/6] Finalizando..."

echo "✔ SAR instalado com sucesso"
