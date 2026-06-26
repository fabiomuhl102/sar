#!/usr/bin/env bash

echo ""
echo "========================================"
echo "      INICIANDO STACK SAR"
echo "========================================"
echo ""

docker compose -f docker/compose.yml up -d

echo ""
echo "✔ Stack iniciada."
echo ""
