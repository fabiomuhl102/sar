#!/bin/bash

source /opt/automacao/scripts/lib/config.sh
source /opt/automacao/scripts/lib/colors.sh

banner() {

clear

echo -e "${CYAN}"
echo "============================================================"
echo "            ${PLATFORM_NAME}"
echo "============================================================"
echo -e "${NC}"

printf "%-18s %s\n" "Versão:" "$PLATFORM_VERSION"
printf "%-18s %s\n" "Hostname:" "$(hostname)"
printf "%-18s %s\n" "Sistema:" "$(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
printf "%-18s %s\n" "Kernel:" "$(uname -r)"
printf "%-18s %s\n" "Data:" "$(date '+%d/%m/%Y %H:%M:%S')"

echo
echo "============================================================"
echo

}
