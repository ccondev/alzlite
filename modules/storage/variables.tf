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