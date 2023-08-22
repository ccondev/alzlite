
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