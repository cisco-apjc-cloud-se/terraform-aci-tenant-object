## New Single-Object Tenant Model ##
variable "tenant" {
  type = object({
    name          = string
    # id            = optional(string)
    use_existing  = optional(bool)
    description   = optional(string)
    ### Application Profiles ###
    aps = map(object({
      ap_name       = string
      use_existing  = optional(bool)
      # tenant_name = string
      description   = string
      #### Endpoint Security Groups (ESG) ####
      esgs = map(object({
        esg_name        = string
        use_existing    = optional(bool)
        # vrf_name        = string
        vrf = object({
          tenant_name = optional(string)
          vrf_name    = string
        })
        description     = string
        preferred_group = string
        consumed_contracts = map(object({
          tenant_name   = optional(string)
          contract_name = string
        }))
        provided_contracts = map(object({
          tenant_name   = optional(string)
          contract_name = string
        }))
      }))
      #### Endpoint Groups (EPG) ####
      epgs = map(object({
        epg_name      = string
        use_existing  = optional(bool)
        # bd_name   = string
        bd = object({
          tenant_name = optional(string)
          bd_name = string
        })
        description = string
        domains = map(object({
          name = string
          type = string
          vmm_allow_promiscuous = optional(string)
          vmm_forged_transmits  = optional(string)
          vmm_mac_changes       = optional(string)
          }))
        mapped_esg = object({
          # tenant_name = optional(string)
          esg_name    = optional(string)
          })
        preferred_group = optional(string)
        paths = map(object({
          pod       = number
          leaf_node = number
          port      = string
          vlan_id   = number
          mode      = string
          }))
        }))
    }))
    ### Networking ###
    networking = object({
      #### VRFS ####
      vrfs = map(object({
        vrf_name        = string
        use_existing    = optional(bool)
        description     = string
        # tenant_name     = string
        preferred_group = string
      }))
      #### Bridge Domains ####
      bds = map(object({
        bd_name       = string
        use_existing  = optional(bool)
        vrf = object({
          tenant_name = optional(string)
          vrf_name    = string
          })
        # vrf_name      = string
        description   = string
        # tenant_name   = string
        arp_flood     = string
        mac_address   = string
        l3outs        = map(object({
          tenant_name = optional(string)
          l3out_name  = string
          }))
        subnets = map(object({
          description   = string
          ip            = string
          scope         = list(string)
          preferred     = string
          }))
      }))
      #### L3Outs ####
      l3outs = map(object({
        l3out_name    = string
        use_existing  = optional(bool)
        description   = string
        vrf = object({
          tenant_name = optional(string)
          vrf_name    = string
          })
        l3_domain     = string
        ### Enable BGP ####
        bgp_policy = object({
          enabled     = optional(bool)
          description = optional(string)
          annotation  = optional(string)
          name_alias  = optional(string)
          })
        #### Enable OSPF ####
        ospf_policy = object({
          enabled     = optional(bool)
          description = optional(string)
          area_cost   = optional(number)
          area_id     = optional(string)
          area_type   = optional(string)
          })
        #### Logical Profiles ####
        logical_node_profiles = map(object({
          lprof_name    = string
          use_existing  = optional(bool)
          description   = string
          bgp_peers = map(object({
            peer_ip                         = string
            peer_asn                        = number
            addr_t_ctrl                     = optional(list(string))
            admin_state                     = optional(string)
            allowed_self_as_cnt             = optional(number)
            description                     = optional(string)
            annotation                      = optional(string)
            ctrl                            = optional(list(string))
            name_alias                      = optional(string)
            password                        = optional(string)
            peer_ctrl                       = optional(list(string))
            private_a_sctrl                 = optional(list(string))
            ttl                             = optional(number)
            weight                          = optional(number)
            local_asn                       = optional(number)
            local_asn_propagate             = optional(string)
            peer_prefix_policy              = optional(string)
            route_control_profiles          = map(object({
              direction = optional(string)
              target_dn = string
            }))
          }))
          nodes = map(object({
            pod         = number
            leaf_node   = number
            loopback_ip = string
          }))
          interface_profiles = map(object({
            intprof_name = string
            description  = string
            ospf_profile = object({
              enabled     = optional(bool)
              description = optional(string)
              auth_key    = optional(string)
              auth_key_id = optional(number)
              auth_type   = optional(string)
              ospf_policy = object({
                tenant_name = optional(string)
                policy_name = optional(string)
                })
            })
            floating_svis = map(object({
              pod         = number
              node        = number
              vlan_id     = number
              ip          = string ## Anchor Node IP
              description = optional(string)
              bgp_peers   = map(object({
                peer_ip                         = string # addr
                peer_asn                        = number # as_number
                addr_t_ctrl                     = optional(list(string)) # Ucast/Mcast Addr Type AF Control. (Multiple Comma-Delimited values are allowed. E.g., "af-mcast,af-ucast"). Apply "" to clear all the values. Allowed values: "af-mcast", "af-ucast". Default value: "af-ucast".
                admin_state                     = optional(string) # Allowed values are "disabled", "enabled", and default value is "enabled"
                allowed_self_as_cnt             = optional(number) # Default value: "3".
                description                     = optional(string)
                annotation                      = optional(string)
                ctrl                            = optional(list(string)) # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
                name_alias                      = optional(string)
                password                        = optional(string) # If password is set, the peer password will reset when terraform configuration is applied.
                peer_ctrl                       = optional(list(string)) # Allowed values: "bfd", "dis-conn-check".
                private_a_sctrl                 = optional(list(string)) # Allowed values: "remove-all", "remove-exclusive", "replace-as".
                ttl                             = optional(number) # Default value: "1".
                weight                          = optional(number) # Default value: "0".
                local_asn                       = optional(number)
                local_asn_propagate             = optional(string) # Allowed values: "dual-as", "no-prepend", "none", "replace-as". Default value: "none".
                peer_prefix_policy              = optional(string)
                route_control_profiles          = map(object({
                  direction = optional(string) # Allowed values are "export", "import", and default value is "import".
                  target_dn = string
                }))
              }))
              domains     = map(object({
                name              = string
                type              = string
                floating_ip       = optional(string)
                forged_transmit   = optional(string)
                mac_change        = optional(string)
                promiscuous_mode  = optional(string)
                }))
              }))
            paths = map(object({
              description     = string
              path_type       = string
              ip              = optional(string)
              vlan_id         = optional(number)
              interface_type  = string
              port = object({
                pod       = optional(number)
                node      = optional(number)
                port_name = optional(string)  ## Includes Direct Port Channel
              })
              vpc = object({
                pod         = optional(number)
                vpc_name    = optional(string)
                side_a = object({
                  node          = optional(number)
                  ip            = optional(string)
                  annotation    = optional(string)
                  ipv6_dad      = optional(string)
                  ll_addr       = optional(string)
                  description   = optional(string)
                  name_alias    = optional(string)
                })
                side_b = object({
                  node          = optional(number)
                  ip            = optional(string)
                  annotation    = optional(string)
                  ipv6_dad      = optional(string)
                  ll_addr       = optional(string)
                  description   = optional(string)
                  name_alias    = optional(string)
                })
              })
              annotation  = optional(string)
              autostate   = optional(string)
              encap_scope = optional(string)
              ipv6_dad    = optional(string)
              ll_addr     = optional(string)
              mac         = optional(string)
              mode        = optional(string)
              mtu         = optional(string)
              target_dscp = optional(string)
              bgp_peers   = map(object({
                peer_ip                         = string # addr
                peer_asn                        = number # as_number
                addr_t_ctrl                     = optional(list(string)) # Ucast/Mcast Addr Type AF Control. (Multiple Comma-Delimited values are allowed. E.g., "af-mcast,af-ucast"). Apply "" to clear all the values. Allowed values: "af-mcast", "af-ucast". Default value: "af-ucast".
                admin_state                     = optional(string) # Allowed values are "disabled", "enabled", and default value is "enabled"
                allowed_self_as_cnt             = optional(number) # Default value: "3".
                description                     = optional(string)
                annotation                      = optional(string)
                ctrl                            = optional(list(string)) # Allowed values: "allow-self-as", "as-override", "dis-peer-as-check", "nh-self", "send-com", "send-ext-com"
                name_alias                      = optional(string)
                password                        = optional(string) # If password is set, the peer password will reset when terraform configuration is applied.
                peer_ctrl                       = optional(list(string)) # Allowed values: "bfd", "dis-conn-check".
                private_a_sctrl                 = optional(list(string)) # Allowed values: "remove-all", "remove-exclusive", "replace-as".
                ttl                             = optional(number) # Default value: "1".
                weight                          = optional(number) # Default value: "0".
                local_asn                       = optional(number)
                local_asn_propagate             = optional(string) # Allowed values: "dual-as", "no-prepend", "none", "replace-as". Default value: "none".
                peer_prefix_policy              = optional(string)
                route_control_profiles          = map(object({
                  direction = optional(string) # Allowed values are "export", "import", and default value is "import".
                  target_dn = string
                }))
              }))
            }))
          }))
        }))
        #### External Endpoint Groups (ExEPG) ####
        external_epgs = map(object({
          extepg_name     = string
          use_existing    = optional(bool)
          description     = string
          preferred_group = string
          consumed_contracts = map(object({
            tenant_name   = optional(string)
            contract_name = string
          }))
          provided_contracts = map(object({
            tenant_name   = optional(string)
            contract_name = string
          }))
          contract_master_epgs = map(object({
            l3out_name = string
            extepg_name = string
          }))
          subnets = map(object({
            description = string
            aggregate   = string
            ip          = string
            scope       = list(string)
          }))
        }))
      }))
    })
    ### Contracts & Filters ###
    contracts = object({
      #### Standard Contracts ###
      standard = map(object({
        contract_name = string
        tenant_name   = optional(string)
        use_existing  = optional(bool)
        description   = optional(string)
        scope         = optional(string)
        subjects = map(object({
          subject_name  = string
          description   = optional(string)
          filters       = map(object({
            filter_name = string
            tenant_name = optional(string)
          }))
          service_graph = object({
            tenant_name = optional(string)
            template_name = optional(string)
            nodes = map(object({
              node_name     = string
              device = object({
                tenant_name = optional(string)
                device_name = string
              })
              annotation    = optional(string)
              description   = optional(string)
              context       = optional(string)
              name_alias    = optional(string)
              router_config = optional(string)
              consumer_interface = object({
                type                = string
                conn_name           = string
                cluster_interface   = string
                l3_dest             = optional(string)
                redirect_policy     = optional(string)
                service_epg_policy  = optional(string)
                annotation          = optional(string)
                description         = optional(string)
                name_alias          = optional(string)
                permit_log          = optional(string)
                bd = object({
                  tenant_name = optional(string)
                  bd_name     = optional(string)
                })
                extepg = object({
                  tenant_name = optional(string)
                  l3out_name  = optional(string)
                  extepg_name = optional(string)
                })
              })
              provider_interface = object({
                type                = string
                conn_name           = string
                cluster_interface   = string
                l3_dest             = optional(string)
                redirect_policy     = optional(string)
                service_epg_policy  = optional(string)
                annotation          = optional(string)
                description         = optional(string)
                name_alias          = optional(string)
                permit_log          = optional(string)
                bd = object({
                  tenant_name = optional(string)
                  bd_name     = optional(string)
                })
                extepg = object({
                  tenant_name = optional(string)
                  l3out_name  = optional(string)
                  extepg_name = optional(string)
                })
              })
            }))
          })
        }))
      }))
      #### Filters ####
      filters = map(object({
        filter_name   = string
        use_existing  = optional(bool)
        tenant_name   = optional(string)
        description   = string
        entries = map(object({
          name        = string
          description = string
          ether_t     = string
          d_from_port = string
          d_to_port   = string
          prot        = string
          s_from_port = string
          s_to_port   = string
          }))
      }))
    })
    ### Policies ###
    policies = object({
      service_redirect_policies = map(object({
        policy_name             = string
        name_alias              = optional(string)
        use_existing            = optional(bool)
        description             = optional(string)
        dest_type               = optional(string)
        min_threshold_percent   = optional(number)
        max_threshold_percent   = optional(number)
        hashing_algorithm       = optional(string)
        anycast_enabled         = optional(string)
        program_local_pod_only  = optional(string)
        resilient_hash_enabled  = optional(string)
        threshold_enable        = optional(string)
        threshold_down_action   = optional(string)
        ipsla_policy            = optional(string)
        destinations = map(object({
          ip            = string
          mac           = string
          annotation    = optional(string)
          description   = optional(string)
          dest_name     = optional(string)
          ip2           = optional(string)
          name_alias    = optional(string)
          pod_id        = optional(number)
          health_group  = optional(string)
        }))
      }))
    })
    ### Services ###
    services = object({
      l4-l7 = object({
        devices = map(object({
          device_name      = string
          active           = optional(string)
          context_aware    = optional(string)
          device_type      = optional(string) # Allowed values are "cloud", "physical", "virtual", and default value is "physical" NOTE: Resource needs capitalization
          function_type    = optional(string)
          is_copy          = optional(string)
          mode             = optional(string)
          promiscuous_mode = optional(string)
          service_type     = optional(string) # Allowed values are "ADC", "COPY", "FW", "NATIVELB", "OTHERS", and default value is "OTHERS NOTE: Resource needs capitalization
          trunking         = optional(string)
          domain = object({
            name = string
            type = string
          })
          concrete_devices = map(object({
            device_name         = string
            annotation          = optional(string)
            name_alias          = optional(string)
            vmm_controller_name = optional(string)
            vm_name             = optional(string)
            interfaces = map(object({
              interface_name  = string
              encap           = optional(string)
              vnic_name       = optional(string)
              pod             = optional(number)
              node            = optional(number)
              port            = optional(string)
            }))
          }))
          logical_interfaces = map(object({
            interface_name            = string
            annotation                = optional(string)
            encap                     = optional(string)
            enhanced_lag_policy_name  = optional(string)
          }))
        }))
        service_graph_templates = map(object({
          template_name                     = string
          annotation                        = optional(string)
          name_alias                        = optional(string)
          description                       = optional(string)
          l4_l7_service_graph_template_type = optional(string)
          ui_template_type                  = string
          term_prov_name                    = optional(string)
          term_cons_name                    = optional(string)
          function_nodes = map(object({
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
          }))
        }))
      })
    })
  })
}
