#!/usr/bin/env bash

main_menu() {

clear

echo "=================================================="
echo "          SAR V5 PROFESSIONAL"
echo "=================================================="
echo
echo "1) Stack Docker"
echo "2) Dashboard"
echo "3) Backups"
echo "4) Sistema"
echo "5) Configurações"
echo "6) Status"
echo
echo "0) Sair"
echo

read -rp "Escolha: " MENU

case "$MENU" in

1)
    stack_menu
    ;;

2)
    dashboard_menu
    ;;

3)
    backup_menu
    ;;

4)
    system_menu
    ;;

5)
    config_menu
    ;;

6)
    status_screen
    ;;

0)
    exit 0
    ;;

*)
    echo
    echo "Opção inválida."
    sleep 1
    ;;

esac

}
