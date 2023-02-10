variable "template_dn" {}

variable "device_map" {}

## New Single-Object Tenant Model ##
variable "node" {
  type = object({
    node_name           = string
    annotation          = optional(string)
    description         = optional(string)
    func_template_type  = string
    func_type           = optional(string)
    is_copy             = optional(string)
    managed             = optional(string)
    name_alias          = optional(string)
    routing_mode        = string
    sequence_number     = number
    share_encap         = optional(string)
    device              = object({
      tenant_name = optional(string)
      device_name = string
    })

    # relation_vns_rs_node_to_abs_func_prof - (Optional) Relation to class vnsAbsFuncProf. Cardinality - N_TO_ONE. Type - String.
    # relation_vns_rs_node_to_l_dev - (Optional) Relation to class vnsALDevIf. Cardinality - N_TO_ONE. Type - String.
    # relation_vns_rs_node_to_m_func - (Optional) Relation to class vnsMFunc. Cardinality - N_TO_ONE. Type - String.
    # relation_vns_rs_default_scope_to_term - (Optional) Relation to class vnsATerm. Cardinality - ONE_TO_ONE. Type - String.
    # relation_vns_rs_node_to_cloud_l_dev - (Optional) Relation to class cloudALDev. Cardinality - N_TO_ONE. Type - String.

  })
}
