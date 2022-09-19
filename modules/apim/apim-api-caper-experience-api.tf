###API
resource "azurerm_api_management_api" "apim-api-caper" {
  name                = "caper-experience-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Caper Experience API"
  path                = "caper/v1"
  protocols           = ["https"]
  service_url         = "http://${var.caper_exp_api_url}:3000/api-order/v1"
}

###Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-create-new-order" {
  operation_id        = "create-new-order"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Create New Order"
  method              = "POST"
  url_template        = "/{tenantCode}/order"
  description         = "Create New Order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }
  
}

resource "azurerm_api_management_api_operation" "apim-api-operation-get-pricebook-items" {
  operation_id        = "get-pricebook-items"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Pricebook Items"
  method              = "GET"
  url_template        = "/{tenantCode}/pricebook/items?posSiteId={posSiteId}"
  description         = "Retrieve pricebook items for a specified pos site ID"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  template_parameter {
    name        = "posSiteId"
    required    = true
    values      = []
    type        = "string"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-patch-order" {
  operation_id        = "patch-order"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Apply patch to an order"
  method              = "PATCH"
  url_template        = "/{tenantCode}/order/{uuid}"
  description         = "Apply patch to an order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  template_parameter {
    name        = "uuid"
    required    = true
    values      = []
    type        = "string"
  }  

}

resource "azurerm_api_management_api_operation" "apim-api-operation-swagger" {
  operation_id        = "swagger"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger"
  method              = "GET"
  url_template        = "/api-docs/"
  description         = "Retrieve Swagger Documentation"
}

resource "azurerm_api_management_api_operation" "apim-api-operation-swagger-resources" {
  operation_id        = "swagger-resource"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger Resource"
  method              = "GET"
  url_template        = "/api-docs/{resource}"
  description         = "Swagger Resource"

  template_parameter {
    name        = "resource"
    required    = true
    values      = []
    type        = "string"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-update-existing-order" {
  operation_id        = "update-existing-order"
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Update Existing Order"
  method              = "PUT"
  url_template        = "/{tenantCode}/order"
  description         = "Update Existing Order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }
}

###Policies
##API Policy
resource "azurerm_api_management_api_policy" "policy-caper-api" {
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group

  xml_content = <<XML
<policies>  
    <inbound>    
        <base />    
        <validate-jwt header-name="authorization" failed-validation-httpcode="401" failed-validation-error-message="Server is unavailable" require-expiration-time="false" require-signed-tokens="true">      
            <issuer-signing-keys>        
                <key>${var.jwt_secret}</key>        
                <key>${base64encode(var.jwt_secret)}</key>      
            </issuer-signing-keys>      
            <required-claims>        
                <claim name="roles" match="any">          
                    <value>CaperExpApi</value>        
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

##Operation Policy
resource "azurerm_api_management_api_operation_policy" "policy-caper-swagger" {
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-swagger.operation_id

  xml_content = <<XML
<policies>  
    <inbound></inbound>  
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

resource "azurerm_api_management_api_operation_policy" "policy-caper-swagger-resources" {
  api_name            = azurerm_api_management_api.apim-api-caper.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-swagger-resources.operation_id

  xml_content = <<XML
<policies>  
    <inbound></inbound>  
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



