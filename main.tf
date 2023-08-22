module "mgmntgroup" {
  source                = "./modules/mgmntgroup"
  mg_root_name          = var.mg_root_name
  mg_parent_name        = var.mg_parent_name
  mg_children           = var.mg_children
  mg_child_children     = var.mg_child_children
  
}

module "policies" {
  source                      = "./modules/policies"

  mg_parent_id                = module.mgmntgroup.mg_parent_id
  policydefinition            = var.policydefinition
  subs                        = var.subs
  policyinitiatives           = var.policyinitiatives
  custompolicysubsassignment  = var.custompolicysubsassignment
  policysubsassignment        = var.policysubsassignment
  policyinisubsassignment     = var.policyinisubsassignment


  depends_on                  = [module.mgmntgroup]

}

module "resourcegroups"     {
  source                = "./modules/resourcegroups"

  rgs_wk01              = var.rgs_wk01

  depends_on            = [module.policies]

}


module "networking" {
  source                = "./modules/networking"

  vnets                 = var.vnets
  subnets               = var.subnets
  nsg_subnets           = var.nsg_subnets
  nsg_associations      = var.nsg_associations

  depends_on            = [module.resourcegroups]

}

module "management" {
  source                  = "./modules/management"

  laworkspace             = var.laworkspace
  laworkspace_diagnostics = var.laworkspace_diagnostics
  aa_wk                   = var.aa_wk


  depends_on            = [module.resourcegroups]
}

module "storage" {
  source                  = "./modules/storage"

  st_wk                   = var.st_wk

  depends_on            = [module.resourcegroups]

}
