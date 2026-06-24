#!/bin/bash

# ==========================================================
# Biblioteca de Cores
# ==========================================================

# Reset
NC='\033[0m'

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'

# Estilos
BOLD='\033[1m'

# Funções

info() {
    echo -e "${BLUE}$*${NC}"
}

success() {
    echo -e "${GREEN}$*${NC}"
}

warning() {
    echo -e "${YELLOW}$*${NC}"
}

error() {
    echo -e "${RED}$*${NC}"
}

title() {
    echo
    echo -e "${CYAN}${BOLD}$*${NC}"
}
