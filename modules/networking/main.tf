# Create one or more Azure virtual networks
resource "azurerm_virtual_network" "vnets" {
    for_each = var.vnets

    name                 = each.value.name
    location             = each.value.location
    resource_group_name  = each.value.resource_group_name
    address_space        = each.value.address_space

}

# Create one or more subnets within the virtual networks
resource "azurerm_subnet" "subnets" {
    for_each = var.subnets

    name                 = each.value.name
    resource_group_name  = each.value.resource_group_name
    virtual_network_name = azurerm_virtual_network.vnets[each.value.virtual_network_name].name
    address_prefixes     = each.value.address_prefixes
}

# This resource creates a network security group for the Virtual Network Subnets
resource "azurerm_network_security_group" "nsg_subnets" {
  count               = var.nsg_subnets.nsg.enable ? 1 : 0 # Create the resource only if enabled is true

  name                = var.nsg_subnets.nsg.name
  location            = var.nsg_subnets.nsg.location
  resource_group_name = var.nsg_subnets.nsg.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_associations" {
  for_each = var.nsg_associations

  subnet_id                 = azurerm_subnet.subnets[each.value.subnet_id].id
  network_security_group_id = azurerm_network_security_group.nsg_subnets[0].id
}
