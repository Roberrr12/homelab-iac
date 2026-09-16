``` mermaid
flowchart LR

    subgraph Provisioning["Provisioning"]
        E["Terraform"]
        F["k0sctl"]
    end

    subgraph Infra["Infraestructura — Host Proxmox VE (32 GB)"]
        subgraph Cluster["Cluster k0s"]
            direction TB
            B["ctrl-01<br/>controller · 4 GB<br/>tainted (sin cargas)"]
            C["wrk-01<br/>worker · 8 GB<br/>nodo de estado"]
            D["wrk-02<br/>worker · 4-6 GB<br/>stateless"]
            subgraph Workloads["Workloads"]
                K["Traefik (ingress)<br/>NodePort"]
                L["local-path-provisioner"]
                M["ArgoCD"]
                N["kube-prometheus-stack"]
                O["demo-api (FastAPI)"]
            end
        end
        P["MinIO<br/>2 GB · VM aparte<br/>FUERA del clúster"]
    end

    subgraph CICD["CI/CD"]
        G["GitHub Actions"]
        H["GHCR"]
        I["homelab-gitops<br/>(manifiestos)"]
    end

    U["Usuario "]

    E -- "crea las VMs" --> Cluster
    F -- "instala k0s (SSH)" --> Cluster
    E -- "guarda el state" --> P

    G -- "build + push imagen" --> H
    G -- "commit nuevo tag" --> I
    I -- "pull (GitOps)" --> M
    M --> O
    M --> K

    U -- "NodePort" --> K
```