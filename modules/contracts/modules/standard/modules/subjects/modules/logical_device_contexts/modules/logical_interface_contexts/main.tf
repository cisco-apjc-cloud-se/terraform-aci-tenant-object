terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = ">=2.0.0"
    }
  }
  experiments = [module_variable_optional_attrs]
}

### Locals ###
locals {
  # bd_id     = var.interface.type == "general" ? var.interface.bd.tenant_name != null ? data.aci_bridge_domain.external_bd[0].id : var.bd_map[var.interface.bd.bd_name].id : null
  # extepg_id = var.interface.type == "route_peering" ? var.interface.l3out.tenant_name != null ? data.aci_bridge_domain.external_bd[0].id : var.l3out_map[var.interface.extepg.l3out_name].extepg_map[var.interface.extepg.extepg_name].id : null

  ### NOTE:  To avoid a cyclic loop, can't refer to bd_map or l3out_map - Need to infer DN instead ###
  bd_id = var.interface.type == "general" ? var.interface.bd.tenant_name != null ? data.aci_bridge_domain.external_bd[0].id : format("%s/BD-%s", var.tenant_dn, var.interface.bd.bd_name) : null
  extepg_id = var.interface.type == "route_peering" ? var.interface.l3out.tenant_name != null ? data.aci_external_network_instance_profile.extepg[0].id : format("%s/out-%s/instP-%s", var.tenant_dn, var.interface.extepg.l3out_name, var.interface.extepg.extepg_name) : null

  logical_interface_id = var.logical_int_map[var.interface.cluster_interface].id

  srp_id = var.srp_map[var.interface.redirect_policy].id
}

### Load existing External Bridge Domain ###
data "aci_tenant" "external_bd_tenant" {
  count = var.interface.bd.tenant_name != null ? 1 : 0

  name = var.interface.bd.tenant_name
}

data "aci_bridge_domain" "external_bd" {
  count = var.interface.bd.tenant_name != null ? 1 : 0

  name         = var.interface.bd.bd_name
  tenant_dn    = data.aci_tenant.external_bd_tenant[0].id
}

### Load existing External ExtEPG ###
data "aci_tenant" "external_extepg_tenant" {
  count = var.interface.extepg.tenant_name != null ? 1 : 0

  name = var.interface.extepg.tenant_name
}

data "aci_l3_outside" "external_l3_out" {
  count = var.interface.extepg.tenant_name != null ? 1 : 0

  tenant_dn  = data.aci_tenant.external_extepg_tenant[0].id
  name       = var.interface.extepg.l3out_name
}

data "aci_external_network_instance_profile" "extepg" {
  count = var.interface.extepg.tenant_name != null ? 1 : 0

  l3_outside_dn = data.aci_l3_outside.external_l3_out[0].id
  name          = var.interface.extepg.extepg_name
}


## Create L4-L7 Logical Device Interface Contexts ##
resource "aci_logical_interface_context" "interface" {
	logical_device_context_dn        = var.logical_device_context_dn
	conn_name_or_lbl                 = var.interface.conn_name # "consumer"
  description                      = var.interface.description
  annotation                       = var.interface.annotation
	l3_dest                          = var.interface.l3_dest != null ? var.interface.l3_dest : "no" # "yes"  ##NOTE: Set to "no" by default
  name_alias                       = var.interface.name_alias
	permit_log                       = var.interface.permit_log # "no"

  ### Map to existing Bridge Domain for General type connections ###
  relation_vns_rs_l_if_ctx_to_bd    = local.bd_id

  ### Map to existing L3out External EPG for Route Peering type connections ###
  # relation_vns_rs_l_if_ctx_to_out_def - (Optional) Relation to class l3extOutDef. Cardinality - N_TO_ONE. Type - String.  ## NOTE: ??
  relation_vns_rs_l_if_ctx_to_out   = local.extepg_id

  # relation_vns_rs_l_if_ctx_to_cust_qos_pol - (Optional) Relation to class qosCustomPol. Cardinality - N_TO_ONE. Type - String. ## NOTE: ??
  # relation_vns_rs_l_if_ctx_to_svc_e_pg_pol - (Optional) Relation to class vnsSvcEPgPol. Cardinality - N_TO_ONE. Type - String.
  # relation_vns_rs_l_if_ctx_to_inst_p - (Optional) Relation to class fvEPg. Cardinality - N_TO_ONE. Type - String. ## NOTE: ??

  ### Map to existing Service Redirection Policy ###
  relation_vns_rs_l_if_ctx_to_svc_redirect_pol = local.srp_id

  ### Map to L4-L7 Device Logical Interface ###
  # relation_vns_rs_l_if_ctx_to_l_if - (Optional) Relation to class vnsALDevLIf. Cardinality - N_TO_ONE. Type - String.
  relation_vns_rs_l_if_ctx_to_l_if  = local.logical_interface_id #"${aci_tenant.this.id}/lDevVip-${var.device_name}/lIf-External"



}
