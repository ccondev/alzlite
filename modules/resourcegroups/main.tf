# Create a resource group in subscription 1 using the azurerm.sub1 provider
resource "azurerm_resource_group" "rgs_wk01" {
    for_each = var.rgs_wk01
    
    name          = each.value.name
    location      = each.value.location
    tags          = each.value.tags
}