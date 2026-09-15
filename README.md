# homelab-iac

> Infraestructura del homelab como codigo: las VMs del cluster k0s,
> creadas y gestionadas con Terraform sobre Proxmox VE.

## Estado

En construccion. Fase 1.

## Problema

<!-- TODO: que problema resuelve este repo. Concreto, no generico. -->

## Arquitectura

Ver [`docs/arquitectura.md`](docs/arquitectura.md).

## Stack

- Terraform
- Provider `bpg/proxmox`
- Proxmox VE
- MinIO como backend remoto de state (S3 compatible)

## Requisitos previos

<!-- TODO: lista explicita. Versiones, accesos, herramientas.

Aclarar aqui que se crea A MANO y por que:
- El host Proxmox VE.
- El API token de Proxmox con privilegios minimos.
- MinIO (huevo y gallina: el state necesita un backend que ya exista).
-->

## Como reproducirlo

<!-- TODO: del clon al resultado, en pocos comandos. -->

## Ficheros

| Fichero | Proposito |
|---|---|
| `versions.tf` | Versiones de Terraform y del provider |
| `providers.tf` | Configuracion del provider y del backend |
| `variables.tf` | Variables de entrada |
| `main.tf` | Recursos: las VMs del cluster |
| `outputs.tf` | IPs y datos de las VMs (entrada para la fase 2) |
| `example.tfvars` | Valores de ejemplo (sin secretos) |
| `modules/vm/` | Modulo reutilizable de VM |

## Decisiones de diseno

Ver [`docs/adr/`](docs/adr/). Las mas relevantes:
- ADR-0005: por que el state vive fuera del cluster
- ADR-0006: por que Terraform y no OpenTofu
- ADR-0014: por que reconstruir en vez de importar

## Evidencia

<!-- TODO: salida real de `terraform apply` y de `terraform plan` vacio. -->

## Limitaciones conocidas

<!-- TODO: seccion honesta. -->

## Que haria distinto / siguiente paso

<!-- TODO -->
