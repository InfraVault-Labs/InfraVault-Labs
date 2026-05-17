#!/bin/bash
# -------------------------------------------------------------------
# InfraVault-Labs - Compilador de ISO Automatizada (Proxmox VE 9.1)
# -------------------------------------------------------------------
set -e

ISO_VERSION="9.1-1"
ISO_NAME="proxmox-ve_${ISO_VERSION}.iso"
URL_ISO="https://proxmox.com{ISO_NAME}"
OUTPUT_ISO="infravault-pve-91-unattended.iso"

echo "=== 1. Validando dependencias locales ==="
if ! command -v wget &> /dev/null || ! command -v xorriso &> /dev/null; then
    echo "Faltan herramientas esenciales (wget, xorriso). Instálelas primero."
    exit 1
fi

echo "=== 2. Descargando ISO oficial de Proxmox VE 9.1 ==="
if [ ! -f "$ISO_NAME" ]; then
    wget --show-progress "$URL_ISO"
else
    echo "La ISO base ya existe. Omitiendo descarga."
fi

echo "=== 3. Descargando asistente de instalación automatizada ==="
if [ ! -f "proxmox-auto-install-assistant" ]; then
    wget https://proxmox.com
    chmod +x proxmox-auto-install-assistant
fi

echo "=== 4. Inyectando answer.toml y compilando ISO final ==="
./proxmox-auto-install-assistant prepare-iso "$ISO_NAME" --answer answer.toml --output "$OUTPUT_ISO"

echo "========================================================"
echo "¡ÉXITO! ISO generada: iso-builder/$OUTPUT_ISO"
echo "Queme este archivo en un pendrive para instalación 100% desatendida."
echo "========================================================"