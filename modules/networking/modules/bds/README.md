<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >=2.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >=2.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./modules/subnets | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_bridge_domain.bd](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/bridge_domain) | resource |
| [aci_bridge_domain.bd](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/bridge_domain) | data source |
| [aci_l3_outside.external_l3outs](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l3_outside) | data source |
| [aci_tenant.l3out_external_tenants](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_tenant.vrf_external_tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_vrf.external_vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bd"></a> [bd](#input\_bd) | ## Bridge Domain ### | <pre>object({<br>    bd_name       = string<br>    use_existing  = optional(bool)<br>    vrf = object({<br>      tenant_name = optional(string)<br>      vrf_name    = string<br>      })<br>    description   = string<br>    arp_flood     = string<br>    mac_address   = string<br>    l3outs        = map(object({<br>      tenant_name = optional(string)<br>      l3out_name  = string<br>      }))<br>    subnets = map(object({<br>      description   = string<br>      ip            = string<br>      scope         = list(string)<br>      preferred     = string<br>      }))<br>    })</pre> | n/a | yes |
| <a name="input_l3out_map"></a> [l3out\_map](#input\_l3out\_map) | ## L3Out Map ### | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |
| <a name="input_vrf_map"></a> [vrf\_map](#input\_vrf\_map) | ## VRF Map ### | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bd_id"></a> [bd\_id](#output\_bd\_id) | n/a |
<!-- END_TF_DOCS -->