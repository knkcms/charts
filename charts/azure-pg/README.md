# Azure Flexible Server for `postgres`

![Version: 0.1.0](https://img.shields.io/badge/Version-0.1.0-informational?style=for-the-badge)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=for-the-badge)
![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=for-the-badge)

![Postgres](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

# # Description

A Helm chart for Kubernetes

# # Usage
<fill out>
abc

# # Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kubernetesNamespace | string | `"default"` | Namespace where the CRDs are placed to |
| location | string | `"westeurope"` | Set the Azure Location of the resources |
| postgres.database.create | bool | `true` | Specifies whether a Postgres Database should be created |
| postgres.database.name | string | `"knkcms-dev"` | Name of the Postgres Database |
| postgres.server.create | bool | `true` | Specifies whether a Postgres Server should be created |
| postgres.server.firewall.createAzureRule | bool | `true` | Specifies whether to enable access of Azure Resources to the Postgres Server |
| postgres.server.name | string | `"knkcms-dev"` | Name of the Postgres Server |
| postgres.server.port | int | `5432` | (int) Port of the Postgres Server |
| postgres.server.sku.name | string | `"Standard_B1ms"` | SKU Name of the Postgres Server |
| postgres.server.sku.tier | string | `"Burstable"` | SKU Tier of the Postgres Server |
| postgres.server.username | string | `"knkAdmin"` | Username of the initial Postgres Server User |
| postgres.server.version | int | `13` | Version of the Postgres Server |
| resourceGroup.create | bool | `true` | Specifies whether a Resource Group should be created |
| resourceGroup.name | string | `"knkcms-dev"` | Name of the Resource Group |

