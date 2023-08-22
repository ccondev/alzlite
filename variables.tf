variable "mg_root_name" {
  type        = string
  description = "value"
  sensitive = true
}

variable "mg_parent_name" {
  type        = string
  description = "value"
}

variable "mg_children" {
  type = map(object({
    name        = string
    parent_id   = string
    subs_ids    = list(string)
  }))
  description   = "A map of objects defining management groups to create"
}

variable "mg_child_children" {
  type = map(object({
    name        = string
    parent_id   = string
    subs_ids    = list(string)
  }))
  description   = "A map of objects defining management groups to create"
}

variable "policydefinition" {
  type = map(object({
    name                  = string
    policy_type           = string
    mode                  = string
    description           = string
    display_name          = string
    policy_rule           = string
    parameters            = string
  }))
  description = "Map of policy assigments to be created."
}
variable "subs" {
  type = map(object({
    subid                 = string
  }))
  description = "Map of mgmntgroups names."
}

variable "policyinitiatives" {
  type = object({
    name                  = string
    policy_type           = string
    display_name          = string
    parameters            = string
    policy_references = map(object({
      policy_definition_id  = string
      parameter_values      = string
    }))
  })
}
variable "custompolicysubsassignment" {
  type = map(object({
    name                  = string
    policy_definition_id  = string
    subscription_id       = string
    parameters            = string
    enable_identity       = bool
    location              = string
    display_name_enable   = bool
    display_name          = string
    description           = string
  }))
  description = "Map of policy assigments to be created."
}
variable "policysubsassignment" {
  type = map(object({
    name                  = string
    description           = string
    display_name          = string
    policy_definition_id  = string
    parameters            = string
    subscription_id       = string
  }))
  description = "Map of policy assigments to be created."
}


variable "policyinisubsassignment" {
  type = map(object({
    name                  = string
    subscription_id       = string
    parameters            = string
    enable_identity       = bool
    location              = string
    display_name_enable   = bool
    display_name          = string
    description           = string
  }))
  description = "Map of policy initiative assigments to be created."
}

variable "rgs_wk01" {
  type = map(object({
    name        = string
    location    = string
    tags        = map(string)
  }))
  description   = "A map of objects defining resource groups to create"
}

variable "vnets" {
  type = map(object({
    name                   = string
    location               = string
    resource_group_name    = string
    address_space          = list(string)
    enable_ddos_protection = bool
  }))
  description   = "A map of objects defining Vnets to create."
}
variable "subnets" {
  type = map(object({
    name                  = string
    resource_group_name   = string
    virtual_network_name  = string
    address_prefixes      = list(string)
  }))
  description   = "A map of objects defining subnets to create"
}

variable "nsg_subnets" {
  type = map(object({
    enable                = bool
    name                  = string
    location              = string
    resource_group_name   = string
  }))
  description   = "A map of objects defining nsg to create."
}

variable "nsg_associations" {
  type = map(object({
    subnet_id           = string
  }))
  description   = "A map of objects defining subnets associations to create."
}


variable "laworkspace" {
  type = map(object({
    enable               = bool
    name                 = string
    location             = string
    resource_group_name  = string
    sku                  = string
    retention_in_days    = number
  }))
  description   = "Properties for the Log Analytics workspace."
}
variable "laworkspace_diagnostics" {
  type = map(object({
    name                = string
    enabled_log = list(object({
      category = string
      retention_policy = object({
        enabled = bool
        days    = number
      })
    }))
    metric = list(object({
      category = string
      enabled  = bool
      retention_policy = object({
        enabled = bool
        days    = number
      })
    }))
  }))
  description = "Map of AAD diagnostic settings."
}

variable "aa_wk" {
  type = map(object({
    enable               = bool
    name                 = string
    location             = string
    resource_group_name  = string
    sku_name             = string
  }))
  description   = "Properties for the Automation Account."
}

variable "st_wk" {
  type = map(object({
    enable                   = bool
    name                     = string
    location                 = string
    resource_group_name      = string
    account_tier             = string
    account_replication_type = string
  }))
  description   = "Properties for the Storage Account."
}
