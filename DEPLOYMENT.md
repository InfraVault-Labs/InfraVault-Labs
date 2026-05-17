# 🛡️ Manual de Despliegue Operativo: Kit de Infraestructura Híbrida (Proxmox VE 9.1 Stable)

Este documento describe de forma estricta los pasos de ingeniería requeridos para la personalización, compilación de ISO físicas y aprovisionamiento final del Kit "Llave en mano" de InfraVault-Labs.

---

## 🛠️ Matriz de Direccionamiento IP y Segmentación Unificada


| Subred / Uso | ID VLAN | Rango IP / Máscara | Gateway | IPs de Componentes | Propósito Operativo |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Gestión (LAN)** | VLAN 100 | `192.168.100.0/24` | `192.168.100.1` | pfSense: `.1`<br>PVM-01: `.11`<br>PVM-02: `.12`<br>TrueNAS: `.13` | Acceso Web Administración, API, SSH, QDevice. |
| **Corosync (Cluster)** | No VLAN | `10.10.10.0/24` | No aplica | PVM-01: `.11`<br>PVM-02: `.12` | **Enlace directo morado.** Latidos de alta disponibilidad. |
| **SAN (Storage)** | No VLAN | `172.16.10.0/24` | No aplica | Nodos: `.11` / `.12`<br>TrueNAS Ports: `.13` / `.14` | **Enlaces directos rojos.** iSCSI/NFS con MTU 9000. |
| **Datos CORP** | VLAN 110 | `192.168.110.0/24` | `192.168.110.1` | Estaciones de usuarios | Red plana de empleados aislada de la gestión. |