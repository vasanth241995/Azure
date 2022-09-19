###API
resource "azurerm_api_management_api" "apim-api-order" {
  name                = "order-experience-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Order Experience API"
  path                = "order/v1"
  protocols           = ["https"]
  service_url         = "http://${var.caper_exp_api_url}:3000/order/v1"
}

###Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-create-new-order" {
  operation_id        = "api-order-create-new-order"
  api_name            = azurerm_api_management_api.apim-api-order.name
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

  response {
    status_code = 200
  }  
}

resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-patch-order" {
  operation_id        = "api-order-patch-order"
  api_name            = azurerm_api_management_api.apim-api-order.name
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

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-get-pricebook-items" {
  operation_id        = "api-order-get-pricebook-items"
  api_name            = azurerm_api_management_api.apim-api-order.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Pricebook Items"
  method              = "GET"
  url_template        = "/{tenantCode}/pricebook/items?posSiteId={posSiteId}"
  description         = "Retrieves dump of most recent pricebook for a given posSiteId"

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

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-update-existing-order" {
  operation_id        = "api-order-update-existing-order"
  api_name            = azurerm_api_management_api.apim-api-order.name
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

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-swagger-resources" {
  operation_id        = "api-order-swagger-resource"
  api_name            = azurerm_api_management_api.apim-api-order.name
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
    type        = "SecureString"
  }

  response {
    status_code = 200
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-api-order-swagger" {
  operation_id        = "api-order-swagger"
  api_name            = azurerm_api_management_api.apim-api-order.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger"
  method              = "GET"
  url_template        = "/api-docs/"
  description         = "Retrieve Swagger Documentation"

  response {
    status_code = 200
  }
}

###Policies
##API Policy
resource "azurerm_api_management_api_policy" "policy-order-api" {
  api_name            = azurerm_api_management_api.apim-api-order.name
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
                <claim name="roles" match="any">         
                    <value>OrderExpApi</value>         
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
resource "azurerm_api_management_api_operation_policy" "policy-order-swagger" {
  api_name            = azurerm_api_management_api.apim-api-order.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-api-order-swagger.operation_id

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

resource "azurerm_api_management_api_operation_policy" "policy-order-swagger-resources" {
  api_name            = azurerm_api_management_api.apim-api-order.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-api-order-swagger-resources.operation_id

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
