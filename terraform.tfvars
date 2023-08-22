# Referenced in management groups module
# This creates a hierarchy of management groups with the following structure:
#
# Root Management Group
# └── Mg-Contoso
#     ├── Mg-Platform
#     |   ├── Mg-Connectivity
#     |   ├── Mg-Identity
#     |   └── Mg-Management
#     ├── Mg-Landingzones
#     |   └── Mg-Online
#     ├── Mg-Decomissioned
#     └── Mg-Sandbox
#
# Note: In this project, we assume that the root management group already exists in Azure

# The name of the root management group
mg_root_name = ""YOUR_MG_ROOT_ID""

# The name of the parent management group
mg_parent_name = "Mg-Contoso"

# The child management groups
mg_children = {
    "mg_platform" = {
        name        = "Mg-Platform"
        parent_id   = "Mg-Contoso"
        subs_ids    = []
    },
    "mg_landingzones" = {
        name        = "Mg-Landingzones"
        parent_id   = "Mg-Contoso"
        subs_ids    = []
    },
    "mg_decomissioned" = {
        name        = "Mg-Decomissioned"
        parent_id   = "Mg-Contoso"
        subs_ids    = []
    },
    "mg_sandbox" = {
        name        = "Mg-Sandbox"
        parent_id   = "Mg-Contoso"
        subs_ids    = []
    }
}

# The child management groups of the child management groups
mg_child_children = {
    "mg_connectivity" = {
        name        = "Mg-Connectivity"
        parent_id   = "mg_platform"
        subs_ids    = []
    },
    "mg_identity" = {
        name        = "Mg-Identity"
        parent_id   = "mg_platform"
        subs_ids    = []
    },
    "mg_management" = {
        name        = "Mg-Management"
        parent_id   = "mg_platform"
        subs_ids    = []
    },
    "mg_online" = {
        name        = "Mg-Online"
        parent_id   = "mg_landingzones"
        subs_ids    = ["YOUR_SUBSCRIPTION_ID"]
    }
}

# Referenced in policies module

 policydefinition = {
    policy1 = {
      name                       = "pol-neu-01-denyRDP-CustomDef"
      policy_type                = "Custom"
      mode                       = "Indexed"
      description                = "Esta política niega cualquier regla de seguridad de red que permita el acceso RDP desde Internet."
      display_name               = "Acceso por RDP desde Internet debería ser bloqueado"
      policy_rule                = "./modules/lib/policies/DenyRDP.json"
      parameters                 = "./modules/lib/parameters/DenyRDP.json"
    },
    policy2 = {
      name                       = "pol-neu-02-nomRG-CustomDef"
      policy_type                = "Custom"
      mode                       = "All"
      description                = "Esta política describe las reglas de nomenclatura para los grupos de recursos. "
      display_name               = "Reglas de nomenclatura para los grupos de recursos."
      policy_rule                = "./modules/lib/policies/NomRG.json"
      parameters                 = "./modules/lib/parameters/NomRG.json"
    },
    policy3 = {
      name                       = "pol-neu-03-inhrTagsSubscription-CustomDef"
      policy_type                = "Custom"
      mode                       = "Indexed"
      description                = "Hablita la herencia de las etiquetas que estén puestas en la subscripción."
      display_name               = "Heredar etiquetas desde la subscripción"
      policy_rule                = "./modules/lib/policies/InhrTagSubscription.json"
      parameters                 = "./modules/lib/parameters/InhrTagSubscription.json"
    }
}
subs = {
  sub1 = {
    subid  = "YOUR_SUBSCRIPTION_ID"
  }
}


policyinitiatives = {
    
      name                 = "Contoso nomenclature rules"
      policy_type          = "Custom"
      display_name         = "Contoso nomenclature rules"

      parameters           = "./modules/lib/parameters/Param_Initiative_1.json"

      policy_references = {
        "nomRg_policy" = {
          policy_definition_id              = "policy2"
          parameter_values                  = <<VALUE
          {
            "effect": {
            "value": "[parameters('Effect')]"
            },
            "resourceGroupPattern": {
            "value": "[parameters('ResourceGroupPattern')]"
            }
          }
          VALUE
        }
      } 
    }

 custompolicysubsassignment = {
    assigment1 = {
      name                 = "pol-neu-03-denyRDP"
      policy_definition_id = "policy1"
      subscription_id      = "sub1"
      display_name_enable  = false
      display_name         = ""
      description          = ""
      enable_identity      = false
      location             = "northeurope"
      parameters           = <<PARAMETERS
      {  
      }
      PARAMETERS
    },
    assigment2 = {
      name                 = "pol-neu-05-inhrTagsSubscription"
      policy_definition_id = "policy3"
      subscription_id      = "sub1"
      display_name_enable  = false
      display_name         = ""
      description          = ""
      enable_identity      = true
      location             = "northeurope"
      parameters           = <<PARAMETERS
      {
          "tagNames": {
              "value": ["ctx-businessunit", "ctx-environment"]
          }       
      }
      PARAMETERS
    },
  }

  policysubsassignment = {
    assigment1 = {
      name                 = "pol-neu-04-sqltls"
      description          = "Establecer la versión de TLS en 1.2 o posterior mejora la seguridad, ya que garantiza que solo se puede acceder a Azure SQL Database desde clientes que usen TLS 1.2 o posterior. No se recomienda usar versiones de TLS inferiores a 1.2 porque tienen vulnerabilidades de seguridad bien documentadas."
      display_name         = "Azure SQL Database debe ejecutar TLS versión 1.2 o posterior"
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/32e6bbec-16b6-44c2-be37-c5b672d103cf"
      parameters           = <<PARAMETERS
        {
        }
      PARAMETERS
      subscription_id      = "sub1"
    },
    assigment2 = {
      name                 = "pol-neu-05-reslocallow"
      description          = "Esta directiva le permite restringir las ubicaciones que su organización puede especificar al implementar los recursos."
      display_name         = "Ubicaciones permitidas para desplegar recursos."
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c"
      parameters           = <<PARAMETERS
      {
          "listOfAllowedLocations": {
              "value": [ "westeurope","northeurope" ]
          }
      }
      PARAMETERS
      subscription_id      = "sub1"
    }
    assigment3 = {
      name                 = "pol-neu-06-rglocallow"
      description          = "Esta directiva le permite restringir las ubicaciones que su organización puede especificar al implementar los grupos de recursos."
      display_name         = "Ubicaciones permitidas para desplegar grupos de recursos."
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988"
      parameters           = <<PARAMETERS
      {
          "listOfAllowedLocations": {
              "value": [ "westeurope","northeurope" ]
          }
      }
      PARAMETERS
      subscription_id      = "sub1"
    }
  }

policyinisubsassignment = {
    assigment1 = {
      name                 = "Contosonomenclaturerules"
      subscription_id      = "sub1"
      display_name_enable  = false
      display_name         = ""
      description          = ""
      enable_identity      = false
      location             = "northeurope"
      parameters           = <<PARAMETERS
        {
          "Effect": {
            "value": "Deny"
          },
          "ResourceGroupPattern": {
            "value": "rg-*"
          }
        }
        PARAMETERS
    }
}

# Referenced in resource group module
# The resource groups for wk01
  rgs_wk01 = {
      "rg1" = {
        name        = "rg-wk01-networking-001"
        location    = "northeurope"
        tags        = {
          ctx-projectcode        = "Verne Tech - Lite Landing Zone",
          ctx-porpuse            = "Grupo de recursos para las redes de la carga de trabajo 1",
          ctx-costcenter         = "Internal",
          ctx-criticality        = "low",
          ctx-dataclassification = "internal",
          ctx-owner              = "Verne",
          ctx-startdate          = "28/06/2023",
          ctx-team               = "Verne",
          ctx-workloadname       = "Carga de trabajo 1"
        }
      },
      "rg2" = {
        name        = "rg-wk01-management-001"
        location    = "northeurope"
        tags        = {
          ctx-projectcode        = "Verne Technology group - Lite Landing Zone",
          ctx-porpuse            = "Grupo de recursos para la administración de la carga de trabajo 1",
          ctx-costcenter         = "Internal",
          ctx-criticality        = "low",
          ctx-dataclassification = "internal",
          ctx-owner              = "Verne",
          ctx-startdate          = "28/06/2023",
          ctx-team               = "Verne",
          ctx-workloadname       = "Carga de trabajo 1"
        }
      },
      "rg3" = {
        name        = "rg-wk01-workload-001"
        location    = "northeurope"
        tags        = {
          ctx-projectcode        = "Verne Technology group - Lite Landing Zone",
          ctx-porpuse            = "Grupo de recursos para almacenar los recursos relacionados con la carga de trabajo 1",
          ctx-costcenter         = "Internal",
          ctx-criticality        = "low",
          ctx-dataclassification = "internal",
          ctx-owner              = "Verne",
          ctx-startdate          = "28/06/2023",
          ctx-team               = "Verne",
          ctx-workloadname       = "Carga de trabajo 1"
        }
      }
  }

# The following block specifies one virtual network to be created by the networking module
# Each virtual network has a name, location, resource group, IP address space, and whether or not to enable DDOS protection
  vnets = {
      "wk01_vnet" = {
        name                  = "vnet-neu-wk01-01"
        location              = "northeurope"
        resource_group_name   = "rg-wk01-networking-001"
        address_space         = ["10.11.0.0/16"]
        enable_ddos_protection  = false
      }
  }

# The following block specifies the subnets to be created in the virtual networks defined above
# Each subnet has a name, resource group, virtual network, and IP address range
  subnets = {
    "wk01_subnet_1" = {
        name                  = "snet-neu-wk01-default"
        resource_group_name   = "rg-wk01-networking-001"
        virtual_network_name  = "wk01_vnet"
        address_prefixes      = ["10.11.0.0/24"]
    },
    "wk01_subnet_2" = {
        name                  = "snet-neu-wk01-front"
        resource_group_name   = "rg-wk01-networking-001"
        virtual_network_name  = "wk01_vnet"
        address_prefixes      = ["10.11.1.0/24"]
    },
    "wk01_subnet_3" = {
        name                  = "snet-neu-wk01-back"
        resource_group_name   = "rg-wk01-networking-001"
        virtual_network_name  = "wk01_vnet"
        address_prefixes      = ["10.11.2.0/24"] 
    }
  }

# # This block creates a network security group for the Virtual Network Subnets
   nsg_subnets = {
    nsg = {
      enable                   = true
      name                     = "nsg-neu-wk01-01"
      location                 = "northeurope"
      resource_group_name      = "rg-wk01-networking-001"
    }
  }

   nsg_associations = {
    association1 = {
      subnet_id                = "wk01_subnet_1"
    }
    association2 = {
      subnet_id                = "wk01_subnet_2"
    }
    association3 = {
      subnet_id                = "wk01_subnet_3"
    }
  }

# # This block creates a Log Analytics workspace
# # It enables the workspace and specifies a name, location, resource group, SKU, and retention policy
# # The retention policy specifies the number of days to retain data
   laworkspace = {
    resource = {
      enable                = true
      name                  = "log-neu-wk01-01"
      location              = "northeurope"
      resource_group_name   = "rg-wk01-management-001"
      sku                   = "PerGB2018"
      retention_in_days     = 30
    }
  }

# This block configures diagnostic settings for the Log Analytics workspace
# It specifies two log categories (AuditLogs and AllMetrics) and their respective retention policies
  laworkspace_diagnostics = {
    setting1 = {
      name                = "diagnosticSettings"
      enabled_log = [
        {
          category = "Audit"
          retention_policy = {
            enabled = true
            days    = 7
          }
        }
      ]
      metric = [
        {
          category = "AllMetrics"
          enabled  = true
          retention_policy = {
            enabled = true
            days    = 7
          }
        }
      ]
    }
  }

# # This block creates a Azure Automation account
# # It enables the Automation and specifies a name, location, resource group, SKU
   aa_wk = {
    aa1 = {
      enable                = true
      name                  = "aa-neu-wk01-01"
      location              = "northeurope"
      resource_group_name   = "rg-wk01-management-001"
      sku_name              = "Basic"
    }
  }

# # This block creates a Azure Storage account
# # It enables the Automation and specifies a name, location, resource group, SKU
   st_wk = {
    st1 = {
      enable                   = true
      name                     = "stneuwk0101"
      location                 = "northeurope"
      resource_group_name      = "rg-wk01-workload-001"
      account_tier             = "Standard"
      account_replication_type = "LRS"
    }
  }
