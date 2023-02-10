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

No modules.

## Resources

| Name | Type |
|------|------|
| [aci_endpoint_security_group.esg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/endpoint_security_group) | resource |
| [aci_contract.external_consumed_contracts](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/contract) | data source |
| [aci_contract.external_provided_contracts](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/contract) | data source |
| [aci_endpoint_security_group.esg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/endpoint_security_group) | data source |
| [aci_tenant.contract_tenants](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |
| [aci_vrf.vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vrf) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ap"></a> [ap](#input\_ap) | n/a | `any` | n/a | yes |
| <a name="input_contract_map"></a> [contract\_map](#input\_contract\_map) | n/a | `any` | n/a | yes |
| <a name="input_esg"></a> [esg](#input\_esg) | n/a | <pre>object({<br>    esg_name        = string<br>    use_existing    = optional(bool)<br>    # vrf_name        = string<br>    vrf = object({<br>      tenant_name = optional(string)<br>      vrf_name    = string<br>    })<br>    description     = string<br>    preferred_group = string<br>    consumed_contracts = map(object({<br>      tenant_name   = optional(string)<br>      contract_name = string<br>    }))<br>    provided_contracts = map(object({<br>      tenant_name   = optional(string)<br>      contract_name = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_key"></a> [key](#input\_key) | ### Endpoint Security Groups (ESG) #### | `any` | n/a | yes |
| <a name="input_tenant_dn"></a> [tenant\_dn](#input\_tenant\_dn) | n/a | `any` | n/a | yes |
| <a name="input_vrf_map"></a> [vrf\_map](#input\_vrf\_map) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_esg_id"></a> [esg\_id](#output\_esg\_id) | n/a |
| <a name="output_internal_consumed_contracts"></a> [internal\_consumed\_contracts](#output\_internal\_consumed\_contracts) | n/a |
| <a name="output_internal_provided_contracts"></a> [internal\_provided\_contracts](#output\_internal\_provided\_contracts) | n/a |
<!-- END_TF_DOCS -->