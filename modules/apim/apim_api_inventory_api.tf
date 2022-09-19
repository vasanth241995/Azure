###API
resource "azurerm_api_management_api" "apim-api-inventory" {
  name                = "inventory-service-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Inventory Service Api"
  path                = "inventory/v1"
  protocols           = ["http","https"]
  service_url         = "http://${var.inventory_service_url}:8080/inventory/v1"
  description         = "Inventory Service Api"
}

##Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-inventory-api-file-upload" {
  operation_id        = "inventory-api-file-upload"
  api_name            = azurerm_api_management_api.apim-api-inventory.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "File Upload"
  method              = "POST"
  url_template        = "/{tenantCode}/webhook/files"
  description         = "File Upload"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  request {
      query_parameter {
      name      = "Authorization"
      type      = "SecureString"
      values    = []   
      required  = true
    }
  }
}

###Policy
##Operational Policy
resource "azurerm_api_management_api_operation_policy" "policy-inventory-file-upload" {
  api_name            = azurerm_api_management_api.apim-api-inventory.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-inventory-api-file-upload.operation_id  

  xml_content = <<XML
<policies> 
    <inbound>   
        <base />   
        <set-header name="Authorization" exists-action="override">     
            <value>@("Bearer " + context.Request.OriginalUrl.Query.GetValueOrDefault("Authorization"))</value>   
        </set-header> 
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