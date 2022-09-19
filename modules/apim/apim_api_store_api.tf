###API
resource "azurerm_api_management_api" "apim-api-store" {
  name                = "store-service-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Store Service Api"
  path                = "store/v1"
  protocols           = ["https"]
  service_url         = "http://${var.store_service_url}:8080/store/v1"
  description         = "Store Service Api"
}

##Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-store-api-file-upload" {
  operation_id        = "store-api-file-upload"
  api_name            = azurerm_api_management_api.apim-api-store.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "File Upload"
  method              = "POST"
  url_template        = "/{tenantCode}/files"
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

  response {
    status_code = 200
  }
}

###Policy
##Operational Policy
resource "azurerm_api_management_api_operation_policy" "policy-store-file-upload" {
  api_name            = azurerm_api_management_api.apim-api-store.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-store-api-file-upload.operation_id
  #depends_on          = [var.store_file_upload_depends_on]

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