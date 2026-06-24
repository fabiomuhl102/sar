# SAR – Servidor de Automação Residencial

## Arquitetura Oficial

### Objetivo

O SAR é uma plataforma para gerenciamento de automação residencial baseada em Linux, Docker e Home Assistant.

Seu objetivo é fornecer uma forma simples, organizada e segura de instalar, administrar, monitorar e manter um servidor de automação residencial.

---

# Camadas do Sistema

## 1. Sistema Operacional

Linux Mint

Responsável por:

* Hardware
* Rede
* Armazenamento
* Segurança

---

## 2. Docker

Responsável pela execução dos serviços.

Serviços previstos:

* Home Assistant
* Node-RED
* Mosquitto
* ESPHome
* Portainer

---

## 3. Plataforma SAR

Responsável por:

* Administração
* Monitoramento
* Backup
* Diagnóstico
* Atualizações
* Documentação

---

# Estrutura

/opt/automacao

* backup
* bin
* compose
* configs
* documentacao
* logs
* monitor
* restore
* scripts
* temp
* volumes

---

# Comandos

sar-status

Mostra o estado geral do servidor.

---

sar-servicos

Gerencia os serviços.

---

sar-backup

Executa backups.

---

sar-restaurar

Restaura backups.

---

sar-monitor

Monitoramento em tempo real.

---

sar-info

Informações da plataforma.

---

sar-diagnostico

Diagnóstico completo.

---

sar-atualizar

Atualiza a plataforma SAR.

---

# Filosofia

Todo comando deve:

* ser simples;
* reutilizar bibliotecas;
* evitar código duplicado;
* produzir saída legível;
* facilitar manutenção.

---

Versão da Arquitetura

0.1.0
