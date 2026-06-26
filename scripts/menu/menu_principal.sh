#!/usr/bin/env bash

# =====================================================
# SAR V5 - PAINEL PRINCIPAL (PROFISSIONAL)
# =====================================================

menu_principal() {

while true
do
clear

echo "========================================"
echo "        SAR V5 - PAINEL PRINCIPAL"
echo "========================================"
echo ""

echo "1) 🚀 Iniciar Stack"
echo "2) 🔄 Reiniciar Stack"
echo "3) ⛔ Parar Stack"
echo "4) 🧹 Clean + Start"
echo "5) 📊 Status Geral"
echo "6) 🌐 Abrir Dashboard"
echo "7) 📜 Logs do Sistema"
echo "8) ❌ Sair"
echo ""

read -p "Escolha uma opção: " opcao

case $opcao in

1)
    bash scripts/lib/docker.sh docker_stack start
    ;;

2)
    bash scripts/lib/docker.sh docker_stack restart
    ;;

3)
    bash scripts/lib/docker.sh docker_stack stop
    ;;

4)
    bash scripts/lib/docker.sh docker_stack clean_start
    ;;

5)
    bash scripts/lib/docker.sh docker_stack status
    ;;

6)
    echo "Abrindo dashboard..."
    xdg-open http://localhost:8088 2>/dev/null || \
    echo "Acesse: http://localhost:8088"
    ;;

7)
    bash scripts/lib/docker.sh docker_stack logs
    ;;

8)
    echo "Saindo..."
    exit 0
    ;;

*)
    echo "Opção inválida"
    sleep 1
    ;;

esac

echo ""
read -p "Pressione ENTER para continuar..."

done

}

# EXECUÇÃO DIRETA DO MENU
menu_principal
