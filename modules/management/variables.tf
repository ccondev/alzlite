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