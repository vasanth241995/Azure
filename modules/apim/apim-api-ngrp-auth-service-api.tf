###API
resource "azurerm_api_management_api" "apim-api-ngrp-auth-service" {
  name                = "ngrp-auth-service"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "NGRP Auth Service"
  path                = "auth/v1"
  protocols           = ["https"]
  service_url         = "http://${var.ngrp_orchestrator_url}:8080/auth/v1"
}

###Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-ngrp-auth-service-session" {
  operation_id        = "ngrp-auth-service-session"
  api_name            = azurerm_api_management_api.apim-api-ngrp-auth-service.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Session"
  method              = "POST"
  url_template        = "/{tenantCode}/session"
  description         = "Session"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-ngrp-auth-service-status" {
  operation_id        = "ngrp-auth-service-status"
  api_name            = azurerm_api_management_api.apim-api-ngrp-auth-service.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Status"
  method              = "GET"
  url_template        = "/v1/status"
  description         = "Status"

  response {
    status_code = 200
  }
}

###Policies
##API Policy
resource "azurerm_api_management_api_policy" "policy-auth-api" {
  api_name            = azurerm_api_management_api.apim-api-ngrp-auth-service.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group

  xml_content = <<XML
<policies>  
    <inbound>    
        <base />    
        <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Server Is Unavailable" require-expiration-time="false" require-signed-tokens="true">      
            <issuer-signing-keys>        
                <key>${var.jwt_secret}</key>        
                <key>${base64encode(var.jwt_secret)}</key>    
            </issuer-signing-keys>      
            <required-claims>        
                <claim name="actions" match="any">          
                    <value>vendor_get_user_token</value>        
                </claim>      
            </required-claims>    
        </validate-jwt>  
    </inbound>  
    <backend>    
        <base />  
    </backend>  
    <outbound>    
        <base />  
    </outbound>  
    <on-error>    
        <base />  
    </on-error>
</policies>
XML
}

