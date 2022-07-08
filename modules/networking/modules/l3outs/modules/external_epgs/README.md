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
| [aci_external_network_instance_profile.extepg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/external_network_instance_profile) | resource |
| [aci_contract.external_consumed_contracts](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/contract) | data source |
| [aci_contract.external_provided_contracts](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/contract) | data source |
| [aci_external_network_instance_profile.contract_masters](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/external_network_instance_profile) | data source |
| [aci_external_network_instance_profile.extepg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/external_network_instance_profile) | data source |
| [aci_l3_outside.contract_masters](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/l3_outside) | data source |
| [aci_tenant.contract_tenants](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_contract_map"></a> [contract\_map](#input\_contract\_map) | n/a | `any` | n/a | yes |
| <a name="input_external_epg"></a> [external\_epg](#input\_external\_epg) | n/a | <pre>object({<br>    extepg_name     = string<br>    use_existing    = optional(bool)<br>    description     = string<br>    preferred_group = string<br>    consumed_contracts = map(object({<br>      tenant_name   = optional(string)<br>      contract_name = string<br>    }))<br>    provided_contracts = map(object({<br>      tenant_name   = optional(string)<br>      contract_name = string<br>    }))<br>    contract_master_epgs = map(object({<br>      l3out_name = string<br>      extepg_name = string<br>    }))<br>    subnets = map(object({<br>      description = string<br>      aggregate   = string<br>      ip          = string<br>      scope       = list(string)<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_l3out_dn"></a> [l3out\_dn](#input\_l3out\_dn) | n/a | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_extepg_id"></a> [extepg\_id](#output\_extepg\_id) | n/a |
<!-- END_TF_DOCS -->