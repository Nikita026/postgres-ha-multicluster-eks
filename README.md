
# PostgreSQL High Availability (HA) Across Two EKS Clusters

## Overview

This project sets up a **Highly Available PostgreSQL cluster** across **two AWS EKS clusters** using **Stolon**.  
It handles **automatic failover**, **replication**, and **client redirection** without manual intervention.  
**Stolon** and **etcd** are installed and managed via **Terraform**.

---

## Components

- **EKS Clusters** (2) — Kubernetes clusters to run PostgreSQL.
- **Stolon** — Manages PostgreSQL HA (keeper, proxy, sentinel pods).
- **etcd** — Stores Stolon cluster state
- **Terraform** — Automates infrastructure deployment (EKS, Networking, Stolon, etcd).
- **Helm** — Installs etcd and Stolon on Kubernetes.

---

## Replication Details

- **Type**: Physical replication (using PostgreSQL WAL).
- **How**:
  - Standbys replicate continuously from primary.
  - Stolon ensures cluster consistency using etcd.

---

## Failover Behavior

- **Primary Goes Down**:
  - Sentinels detect failure.
  - New primary is automatically elected.
  - Proxies reroute traffic to new primary.

- **Old Primary Comes Back**:
  - It becomes a standby automatically.
  - Resynchronizes with the new primary.

_No manual action needed._

---

## Important Commands

- Deploy Infrastructure:
  ```bash
  terraform init
  terraform apply -var="postgres_password=YOUR_PASSWORD" -var="postgres_replication_password=YOUR_REPL_PASSWORD"
  ```

---