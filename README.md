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

## Decisiones de diseño

# Decisiones técnicas

## SOPS + age vs Vault

Se ha decidido utilizar **SOPS + age** en lugar de Vault debido a los siguientes factores:

- **Menor complejidad operativa** y menor consumo de recursos.
- Mejor integración con un enfoque **GitOps**, permitiendo mantener los secretos cifrados junto a la configuración.
- No requiere un proceso de **unsealing** tras el reinicio de una VM.
- Menor infraestructura que mantener, al no requerir un servicio dedicado de gestión de secretos.

**Coste asumido:** la custodia de los secretos dependerá de una única clave privada de **age**, que deberá almacenarse de forma segura y contar con un mecanismo de recuperación.

---

## k0s vs k3s

Se ha descartado **k3s** en favor de **k0s**, ya que k3s incorpora herramientas y componentes adicionales que no son necesarios para el proyecto.

El objetivo es desplegar y configurar estos componentes de forma independiente, manteniendo un mayor control sobre la infraestructura y evitando depender de funcionalidades preinstaladas que no se utilizarán.

---

## Local Path vs Longhorn

Se ha decidido utilizar **Local Path** en lugar de **Longhorn** debido a que el proyecto no maneja datos críticos y el cluster contará únicamente con **2 workers**.

Con esta configuración, la replicación proporcionada por Longhorn no aporta una alta disponibilidad completa para los workloads, ya que la pérdida de un nodo reduciría significativamente la capacidad disponible del cluster.

Además, Local Path presenta una menor complejidad y consumo de recursos, lo que encaja mejor con las necesidades actuales del proyecto.

**Coste asumido:** los workloads con estado, como **ArgoCD y Prometheus**, se configurarán explícitamente para ejecutarse siempre en el mismo nodo. En caso de pérdida de dicho nodo, estos workloads dejarán de estar disponibles hasta su recuperación.

## Evidencia

<!-- TODO: salida real de `terraform apply` y de `terraform plan` vacio. -->

## Limitaciones conocidas

<!-- TODO: seccion honesta. -->

## Que haria distinto / siguiente paso

<!-- TODO -->
