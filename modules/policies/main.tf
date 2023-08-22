resource "azurerm_policy_definition" "policydefinition" {
  for_each              = var.policydefinition

  name                  = each.value.name
  display_name          = each.value.display_name
  description           = each.value.description
  policy_type           = each.value.policy_type
  mode                  = each.value.mode
  policy_rule           = file(each.value.policy_rule)
  parameters            = file(each.value.parameters)
  management_group_id   = var.mg_parent_id
}
# Data block to retrieve Azure Subscriptions
data "azurerm_subscription" "subs" {
  for_each              = var.subs
  subscription_id       = each.value.subid
}

resource "azurerm_policy_set_definition" "policyinitiatives" {
  name                  = var.policyinitiatives.name
  policy_type           = var.policyinitiatives.policy_type
  display_name          = var.policyinitiatives.display_name
  parameters            = file(var.policyinitiatives.parameters)
  management_group_id   = var.mg_parent_id

  dynamic "policy_definition_reference" {
    for_each = var.policyinitiatives.policy_references

    content {
      policy_definition_id = azurerm_policy_definition.policydefinition[policy_definition_reference.value.policy_definition_id].id
      parameter_values     = policy_definition_reference.value.parameter_values
    }
  }

}

resource "azurerm_subscription_policy_assignment" "custompolicysubsassignment" {
  for_each = var.custompolicysubsassignment

  name                  = each.value.name
  policy_definition_id  = azurerm_policy_definition.policydefinition[each.value.policy_definition_id].id
  subscription_id       = data.azurerm_subscription.subs[each.value.subscription_id].id
  parameters            = each.value.parameters
  display_name          = each.value.display_name_enable ? each.value.display_name : null
  description           = each.value.display_name_enable ? each.value.description : null

      dynamic "identity" {
        for_each = each.value.enable_identity ? [1] : []
        content {
        type     = "SystemAssigned"
        }
    }
  location = each.value.enable_identity ? each.value.location : null

  depends_on = [
    azurerm_policy_definition.policydefinition
  ]
}

resource "azurerm_subscription_policy_assignment" "policysubsassignment" {
  for_each = var.policysubsassignment

  name                 = each.value.name
  description          = each.value.description
  display_name         = each.value.display_name
  policy_definition_id = each.value.policy_definition_id
  subscription_id      = data.azurerm_subscription.subs[each.value.subscription_id].id

  parameters           = each.value.parameters

  
  depends_on = [
    azurerm_policy_definition.policydefinition
  ]
}

resource "azurerm_subscription_policy_assignment" "policyinisubsassignment" {
  for_each = var.policyinisubsassignment

  name                  = each.value.name
  policy_definition_id  = azurerm_policy_set_definition.policyinitiatives.id
  subscription_id       = data.azurerm_subscription.subs[each.value.subscription_id].id
  parameters            = each.value.parameters
  display_name          = each.value.display_name_enable ? each.value.display_name : null
  description           = each.value.display_name_enable ? each.value.description : null

  
  depends_on = [
    azurerm_policy_set_definition.policyinitiatives
  ]
}