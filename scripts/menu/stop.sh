#!/usr/bin/env bash

echo ""
echo "========================================"
echo "      PARANDO STACK"
echo "========================================"
echo ""

docker compose -f docker/compose.yml down

echo ""
echo "✔ Stack parada."
echo ""
