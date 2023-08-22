variable "rgs_wk01" {
  type = map(object({
    name        = string
    location    = string
    tags        = map(string)
  }))
  description   = "A map of objects defining resource groups to create"
}