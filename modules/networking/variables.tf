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
  description   = "A map of objects defining subnets to create."
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
