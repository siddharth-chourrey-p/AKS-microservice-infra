variable "infra_config" {
  description = "Complete infrastructure configuration for Dev environment"
  type = object({
    resource_groups = map(object({
      location = string
      tags     = optional(map(string), {})
    }))
    container_registries = map(object({
      rg_key        = string
      sku           = optional(string, "Standard")
      admin_enabled = optional(bool, false)
      tags          = optional(map(string), {})
    }))
    kubernetes_clusters = map(object({
      rg_key     = string
      dns_prefix = string
      default_node_pool = object({
        name       = string
        node_count = optional(number, 1)
        vm_size    = optional(string, "Standard_DS2_v2")
      })
      tags = optional(map(string), {})
      ingress_application_gateway = optional(object({
        gateway_id   = optional(string)
        gateway_name = optional(string)
        subnet_cidr  = optional(string)
        subnet_id    = optional(string)
      }))
    }))
  })
}
