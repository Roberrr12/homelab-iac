# Arquitectura — homelab-platform

<!-- Sustituye este bloque por tu diagrama real (imagen exportada desde draw.io
     o Mermaid renderizado). Este es solo un recordatorio de los elementos
     que el diagrama debe mostrar. -->

## Elementos que debe reflejar el diagrama

- Host Proxmox VE (32 GB RAM) como punto de partida
- 3 VMs del cluster k0s:
  - `ctrl-01` — controller, tainted, sin cargas
  - `wrk-01` — worker, nodo "de estado" (ArgoCD, Prometheus, ingress)
  - `wrk-02` — worker, stateless
- 1 VM/LXC adicional con **MinIO**, FUERA del cluster (backend del state)
- Flujo de aprovisionamiento: **Terraform -> VMs** (aprovisionar)
- Flujo de configuracion: **k0sctl -> cluster k0s** (configurar)
- Flujo de despliegue: **GitHub Actions -> GHCR -> ArgoCD (pull) -> cluster**
- Acceso exterior: **Traefik (NodePort) + Tailscale**
- Dentro del cluster: local-path-provisioner, ArgoCD, kube-prometheus-stack, app FastAPI

## Por que importa la frontera

Terraform termina en la VM creada y su IP. A partir de ahi empieza k0sctl.
Esa frontera es el motivo de que sean dos herramientas y no una.
