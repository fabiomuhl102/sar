#!/usr/bin/env bash

echo ""
echo "========================================"
echo "     REINICIANDO STACK"
echo "========================================"
echo ""

docker compose -f docker/compose.yml restart

echo ""
echo "✔ Stack reiniciada."
echo ""
