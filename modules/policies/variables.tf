variable "mg_parent_id" {
  description = "The ID of parent management group"
  type        = string
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