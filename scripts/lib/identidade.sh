#!/bin/bash
# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca de Identidade
# =====================================================

ARQUIVO_IDENTIDADE="/opt/automacao/configs/identidade.conf"

if [ ! -f "$ARQUIVO_IDENTIDADE" ]; then
    echo "ERRO: Arquivo de identidade não encontrado."
    exit 1
fi

source "$ARQUIVO_IDENTIDADE"
