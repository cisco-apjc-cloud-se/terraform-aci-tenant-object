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
| <a name="module_entries"></a> [entries](#module\_entries) | ./modules/entries | n/a |

## Resources

| Name | Type |
|------|------|
| [aci_filter.filter](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/filter) | resource |
| [aci_filter.filter](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/filter) | data source |
| [aci_tenant.tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/tenant) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_filter"></a> [filter](#input\_filter) | n/a | <pre>object({<br>    filter_name   = string<br>    use_existing  = optional(bool)<br>    tenant_name   = optional(string)<br>    description   = string<br>    entries = map(object({<br>      name        = string<br>      description = string<br>      ether_t     = string<br>      d_from_port = string<br>      d_to_port   = string<br>      prot        = string<br>      s_from_port = string<br>      s_to_port   = string<br>      }))<br>  })</pre> | n/a | yes |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | n/a | <pre>object({<br>    id    = string<br>    name  = string<br>    })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_filter_id"></a> [filter\_id](#output\_filter\_id) | n/a |
<!-- END_TF_DOCS -->