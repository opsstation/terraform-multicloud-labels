# 🌍 Terraform-Multicloud-Labels

[![OpsStation](https://img.shields.io/badge/Made%20by-OpsStation-blue?style=flat-square&logo=terraform)](https://www.opsstation.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Terraform](https://img.shields.io/badge/Terraform-1.13%2B-purple.svg?logo=terraform)](#)
[![CI](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml/badge.svg)](https://github.com/OpsStation/terraform-multicloud-labels/actions/workflows/ci.yml)

> 🧩 **A universal, opinionated Terraform module by [OpsStation](https://www.opsstation.com)**  
> to generate consistent **resource names, tags, and labels** across **AWS, Azure, GCP, DigitalOcean, and Hetzner**.

---

## 🏢 About OpsStation

**OpsStation** delivers **Cloud & DevOps excellence** for modern teams:
- 🚀 **Infrastructure Automation** with Terraform, Ansible & Kubernetes
- 💰 **Cost Optimization** via scaling & right-sizing
- 🛡️ **Security & Compliance** baked into CI/CD pipelines
- ⚙️ **Fully Managed Operations** across AWS, Azure, and GCP

> 💡 Need enterprise-grade DevOps automation?  
> 👉 Visit [**www.opsstation.com**](https://www.opsstation.com) or email **hello@opsstation.com**

---

## 🌟 Features

- ✅ Unified **naming & tagging** across all major clouds
- ✅ Auto-sanitizes labels for **GCP, DigitalOcean, Hetzner** (lowercase-safe)
- ✅ Generates AWS-compatible **`Name`** and title-case tags
- ✅ Prevents invalid characters & enforces compliance
- ✅ Lightweight, reusable, and easy to integrate

---

## ⚙️ Usage Examples

### ☁️ AWS Example
```hcl
module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["v2"]

  extra_tags = {
    Owner      = "Sohan"
    CostCenter = "Finance"
  }
}

resource "aws_security_group" "main" {
  name = module.labels.id
  tags = module.labels.tags
}
```
### ☁️ GCP Example
```hcl
module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["gcp"]
}

resource "google_storage_bucket" "main" {
  name   = module.labels.id
  labels = module.labels.labels
}
```

### ☁️ DigitalOcean Example
```hcl

module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = "payment-api"
  environment = "prod"
  repository  = "terraform-multicloud-labels"
  attributes  = ["do"]
}

locals {
  do_tag_list = [for k, v in module.labels.labels : "${k}:${v}"]
}

resource "digitalocean_droplet" "main" {
  name   = module.labels.id
  region = "nyc3"
  image  = "ubuntu-22-04-x64"
  size   = "s-1vcpu-1gb"
  tags   = local.do_tag_list
}
```
### ☁️ Hetzner Example
```hcl
module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = "payment-api"
  environment = "dev"
  repository  = "terraform-multicloud-labels"
  attributes  = ["hetzner"]
}

resource "hcloud_server" "main" {
  name        = "${module.labels.id}-vm"
  server_type = "cx11"
  image       = "ubuntu-22.04"
  location    = "nbg1"
  labels      = module.labels.labels
}
```
### ☁️ Azure Example
```hcl
module "labels" {
  source      = "opsstation/labels/multicloud"
  version     = "1.0.0"
  name        = "payment-api"
  environment = "uat"
  repository  = "terraform-multicloud-labels"
  attributes  = ["az"]
}

resource "azurerm_resource_group" "main" {
  name     = module.labels.id
  location = "East US"
  tags     = module.labels.tags
}
```
### ☁️ Outputs
| Name         | Description                                                                 |
|---------------|------------------------------------------------------------------------------|
| `id`          | Normalized identifier built from `name`, `environment`, and `attributes`.   |
| `tags`        | AWS/Azure-style TitleCase map (includes `Name`).                            |
| `labels`      | GCP/DO/Hetzner lowercase-safe label map.                                    |
| `all_tags`    | Raw lowercase normalized map (before formatting).                           |
| `name`        | Normalized resource name.                                                   |
| `environment` | Lowercased environment name.                                                |
| `managedby`   | Source or management owner.                                                 |
| `repository`  | Terraform module or repository name.                                        |

### ☁️ Tag Normalization Rules
| Cloud          | Case             | Allowed characters | Example                        |
|----------------|------------------|--------------------|----------------------------------|
| **AWS**        | TitleCase        | Any                | `Name`, `Environment`, `CostCenter` |
| **Azure**      | Case-insensitive | Any                | `environment`, `Name`           |
| **GCP**        | Lowercase        | `[a-z0-9_-]`       | `environment`, `repository`     |
| **DigitalOcean** | Lowercase      | `[a-z0-9_-]`       | `environment`, `repository`     |
| **Hetzner**    | Lowercase        | `[a-z0-9_-]`       | `environment`, `repository`     |


### 💙 Maintained by [OpsStation](https://www.opsstation.com)
> OpsStation — Simplifying Cloud, Securing Scale.