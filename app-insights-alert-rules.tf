# module "create_500_error_in_auth_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in auth service"
#   alert_description         = "This alert occurs when 500 error occurs in Auth service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='authservice'
# | where resultCode==500
# | where name !contains 'feature-test' 
#   QUERY  
# }

# module "create_500_error_in_customer_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in customer service"
#   alert_description         = "This alert occurs when 500 error occurs in customer service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='customerservice'
# | where resultCode==500
# | where name !contains 'feature-test'  
#   QUERY  
# }

# module "create_500_error_in_moneris_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in moneris service"
#   alert_description         = "This alert occurs when 500 error occurs in moneris service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='monerisservice'
# | where resultCode==500
# | where name !contains 'feature-test' 
#   QUERY  
# }

# module "create_500_error_in_orchestrator" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in orchestrator"
#   alert_description         = "This alert occurs when 500 error occurs in orchestrator"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='NGRP Orchestrator'
# | where resultCode==500
# | where name !contains 'feature-test'
#   QUERY  
# }

# module "create_500_error_in_pricebook_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in pricebook service"
#   alert_description         = "This alert occurs when 500 error occurs in pricebook service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='pricebook_service'
# | where resultCode==500
# | where name !contains 'feature-test' 
#   QUERY  
# }

# module "create_500_error_in_report_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in report service"
#   alert_description         = "This alert occurs when 500 error occurs in report service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='reportservice'
# | where resultCode==500
# | where name !contains 'feature-test'  
#   QUERY  
# }

# module "create_500_error_in_tax_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in tax service"
#   alert_description         = "This alert occurs when 500 error occurs in tax service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='taxservice'
# | where resultCode==500
# | where name !contains 'feature-test'
#   QUERY  
# }

# module "create_500_error_in_totalizer_service" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "500 error in totalizer service"
#   alert_description         = "This alert occurs when 500 error occurs in totalizer service"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   requests  | where cloud_RoleName =='totalizer_service'
# | where resultCode==500
# | where name !contains 'feature-test' 
#   QUERY  
# }

# module "create_missing_linked_itemlist_code_for_item" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "Missing linked itemlist code for item"
#   alert_description         = "This alert is triggered when linked item list is not found for given item"
#   alert_enabled             = true
#   alert_severity            = 3
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   traces | where message contains "Linked item list"  
#   QUERY  
# }

# module "create_order_report_failure" {
#   source                    = "./modules/appinsights_alerts_rule"  
#   resource_group            = var.resource_group
#   location                  = var.location
#   app_insights_id           = module.create_app_insights.app_insight_id
#   action_group_id           = module.create_app_insights.action_group_id
#   alert_name                = "Order Report Failure"
#   alert_description         = "A successfully completed order failed to report after several attempts."
#   alert_enabled             = true
#   alert_severity            = 1
#   alert_frequency           = 5
#   alert_time_window         = 5
#   alert_operator            = "GreaterThan"
#   alert_threshold           = 0
#   alert_query               = <<-QUERY
#   customEvents | where name == "Order Report Failure"  
#   QUERY  
# }