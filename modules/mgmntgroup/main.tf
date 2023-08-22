
# Define a data source for the root management group
data "azurerm_management_group" "mg_root" {
  name = var.mg_root_name
}

# Define a resource for the parent management group
resource "azurerm_management_group" "mg_parent" {
  
  name                       = var.mg_parent_name
  parent_management_group_id = data.azurerm_management_group.mg_root.id
}

# Define a resource for each child management group
resource "azurerm_management_group" "mg_children" {
  for_each = var.mg_children

  name                       = each.value.name
  parent_management_group_id = azurerm_management_group.mg_parent.id

  # Set the subscription IDs associated with the child management group (if any)
  subscription_ids = length(each.value.subs_ids) > 0 ? each.value.subs_ids : []
}

# Define a resource for each child of a child management group
resource "azurerm_management_group" "mg_child_children" {
  for_each = var.mg_child_children

  name                       = each.value.name
  parent_management_group_id = azurerm_management_group.mg_children[each.value.parent_id].id

  # Set the subscription IDs associated with the child of a child management group (if any)
  subscription_ids = length(each.value.subs_ids) > 0 ? each.value.subs_ids : []
}
