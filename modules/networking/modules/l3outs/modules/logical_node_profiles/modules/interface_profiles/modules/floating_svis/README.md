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
| [aci_l3out_floating_svi.svi](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/l3out_floating_svi) | resource |
| [aci_physical_domain.physical](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/physical_domain) | data source |
| [aci_vmm_domain.vmware](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/data-sources/vmm_domain) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_floating_svi"></a> [floating\_svi](#input\_floating\_svi) | n/a | <pre>object({<br>    pod         = number<br>    node        = number<br>    vlan_id     = number<br>    ip          = string ## Anchor Node IP<br>    description = optional(string)<br>    domains     = map(object({<br>      name              = string<br>      type              = string<br>      floating_ip       = optional(string)<br>      forged_transmit   = optional(string) # Disabled, Enabled<br>      mac_change        = optional(string) # Disabled, Enabled<br>      promiscuous_mode  = optional(string) # Disabled, Enabled<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_intprof_dn"></a> [intprof\_dn](#input\_intprof\_dn) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->