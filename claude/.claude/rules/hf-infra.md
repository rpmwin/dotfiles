---
glob: /Users/iamrpm/Developer/hf/**
---

# Hyperface Infra Context

Role: DevOps. Stack: Terraform, AWS, Docker Compose, mise, Go services.

## Directory Layout

```
~/Developer/hf/
├── adr/deployments/           # app deployments — compose files, envs, dist/
├── adr/ubi-deployments/       # UBI-specific deployments
├── devops/iac/                # Terraform infra-as-code
│   └── terraform/aws/
│       ├── modules/           # reusable TF modules
│       └── environments/      # per-env TF configs (uat, prod)
└── apps/                      # Go microservices
    # bifrost, doraemon, grimlock, ironbank, jetfire, nimbus, quibbler
```

## Stack

- Deployments: `mise run generate <env> <version>` → produces `dist/*.compose.yml`
- Running: `docker compose -f dist/<env>.compose.yml <cmd>`
- Env configs: `envs/<env>/` yml sources — `dist/` files are generated, never edit directly
- AWS profiles: `hf-infra` (primary), regions: `ap-south-1`, `eu-north-1`
- SSH: `ssh hf-rpms` or key-based via `~/.ssh/`

## Architecture

- Services communicate via internal Docker network
- Secrets injected via env at runtime — source of truth is yml env configs
- UBI stack: Kafka + ClickHouse + MySQL in db container
- Temporal for workflow orchestration in ext-app container

## Directives

- MUST confirm target environment before any operation — never assume uat vs prod.
- MUST run `mise tasks` before suggesting raw docker/terraform commands — a task may already exist.
- MUST prefer `mise run <task>` over raw commands.
- MUST run `terraform plan` before `terraform apply`.
- MUST NOT edit `dist/` or generated files directly — edit source yml then regenerate.
- MUST NOT store passwords or secrets in commands — use env vars or secret managers.
- MUST NOT run `terraform apply -auto-approve`.
- MUST verify target DB/schema before running any database query.

## Skills

- Deployment debugging → `investigate`
- Multi-step state-sensitive work → `checkpoint` first
- Security/secrets changes → `cso`
- Infra design → `system-design`
