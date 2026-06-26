#!/usr/bin/env bash

echo ""
echo "========================================"
echo "        STATUS DO SAR"
echo "========================================"
echo ""

docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"

echo ""
