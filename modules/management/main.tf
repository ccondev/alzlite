# Define an Azure Log Analytics workspace
resource "azurerm_log_analytics_workspace" "laworkspace" {
  # Create the resource only if it is enabled
  count               = var.laworkspace.resource.enable ? 1 : 0
  name                = var.laworkspace.resource.name
  location            = var.laworkspace.resource.location
  resource_group_name = var.laworkspace.resource.resource_group_name
  sku                 = var.laworkspace.resource.sku
  retention_in_days   = var.laworkspace.resource.retention_in_days
}

# Configure diagnostic settings for the Log Analytics workspace
resource "azurerm_monitor_diagnostic_setting" "laworkspace_diagnostics" {
  # Create the resource only if it is enabled
  count                      = var.laworkspace.resource.enable ? 1 : 0
  name                       = var.laworkspace_diagnostics.setting1.name
  # Get the Log Analytics workspace ID from the previously created resource
  target_resource_id         = azurerm_log_analytics_workspace.laworkspace[count.index].id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.laworkspace[count.index].id

  # Create diagnostic settings for each log category specified in the variables
  dynamic "enabled_log" {
    for_each = var.laworkspace_diagnostics.setting1.enabled_log
    content {
      category = enabled_log.value.category
      retention_policy {
        enabled = enabled_log.value.retention_policy.enabled
        days    = enabled_log.value.retention_policy.days
      }
    }
  }
  
  # Create diagnostic settings for each metric category specified in the variables
  dynamic "metric" {
    for_each = var.laworkspace_diagnostics.setting1.metric
    content {
      category = metric.value.category
      enabled  = metric.value.enabled
      retention_policy {
        enabled = metric.value.retention_policy.enabled
        days    = metric.value.retention_policy.days
      }
    }
  }
    depends_on = [
    azurerm_log_analytics_workspace.laworkspace
  ]
}

resource "azurerm_automation_account" "aa" {
  count               = var.aa_wk.aa1.enable ? 1 : 0
  
  location            = var.aa_wk.aa1.location
  name                = var.aa_wk.aa1.name
  resource_group_name = var.aa_wk.aa1.resource_group_name
  sku_name            = var.aa_wk.aa1.sku_name

  identity {
    type = "SystemAssigned"
  }
}