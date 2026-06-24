#!/bin/bash
# =====================================================
# SAR - Servidor de Automação Residencial
# Biblioteca de Disco
# =====================================================

disco_sistema() {
    df -h / | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}'
}

disco_backup() {
    df -h /mnt/backups | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}'
}

disco_livre_sistema() {
    df -h / | awk 'NR==2 {print $4}'
}

disco_livre_backup() {
    df -h /mnt/backups | awk 'NR==2 {print $4}'
}
