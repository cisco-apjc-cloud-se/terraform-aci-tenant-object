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
| <a name="module_epg-esg"></a> [epg-esg](#module\_epg-esg) | ./modules/epg-esg | n/a |
| <a name="module_epgs"></a> [epgs](#module\_epgs) | ./modules/epgs | n/a |
| <a name="module_esgs"></a> [esgs](#module\_esgs) | ./modules/esgs | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_application_profile.ap](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/application_profile) | resource |
| [aci_application_profile.ap](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/application_profile) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ap"></a> [ap](#input\_ap) | ## Application Profile ### | <pre>object({<br>    ap_name       = string<br>    use_existing  = optional(bool)<br>    # tenant_name = string<br>    description   = string<br>    #### Endpoint Security Groups (ESG) ####<br>    esgs = map(object({<br>      esg_name        = string<br>      use_existing    = optional(bool)<br>      # vrf_name        = string<br>      vrf = object({<br>        tenant_name = optional(string)<br>        vrf_name    = string<br>      })<br>      description     = string<br>      preferred_group = string<br>      consumed_contracts = map(object({<br>        tenant_name   = optional(string)<br>        contract_name = string<br>      }))<br>      provided_contracts = map(object({<br>        tenant_name   = optional(string)<br>        contract_name = string<br>      }))<br>    }))<br>    #### Endpoint Groups (EPG) ####<br>    epgs = map(object({<br>      epg_name      = string<br>      use_existing  = optional(bool)<br>      # bd_name   = string<br>      bd = object({<br>        tenant_name = optional(string)<br>        bd_name = string<br>      })<br>      description = string<br>      domains = map(object({<br>        name = string<br>        type = string<br>        vmm_allow_promiscuous = optional(string)<br>        vmm_forged_transmits  = optional(string)<br>        vmm_mac_changes       = optional(string)<br>        }))<br>      mapped_esg = object({<br>        # tenant_name = optional(string)<br>        esg_name    = optional(string)<br>        })<br>      preferred_group = optional(string)<br>      paths = map(object({<br>        pod       = number<br>        leaf_node = number<br>        port      = string<br>        vlan_id   = number<br>        mode      = string<br>        }))<br>      }))<br>  })</pre> | n/a | yes |
| <a name="input_bd_map"></a> [bd\_map](#input\_bd\_map) | ## BD Map ### | `any` | n/a | yes |
| <a name="input_contract_map"></a> [contract\_map](#input\_contract\_map) | ## Contract Map ### | `any` | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ## Tenant Details ### | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |
| <a name="input_vrf_map"></a> [vrf\_map](#input\_vrf\_map) | ## VRF Map ### | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ap_id"></a> [ap\_id](#output\_ap\_id) | n/a |
| <a name="output_epg_map"></a> [epg\_map](#output\_epg\_map) | n/a |
| <a name="output_esg_map"></a> [esg\_map](#output\_esg\_map) | n/a |
| <a name="output_internal_testing"></a> [internal\_testing](#output\_internal\_testing) | n/a |
<!-- END_TF_DOCS -->