###API
resource "azurerm_api_management_api" "apim-api-pdi" {
  name                = "pdi-experience-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "PDI Experience API"
  path                = "pdi/v1"
  protocols           = ["https"]
  service_url         = "http://${var.pdi_experience_api_url}:3000/api-pdi/v1"
}

###Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-retrieve-report" {
  operation_id        = "pdi-experience-api-retrieve-report"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Retrieve Report"
  method              = "GET"
  url_template        = "/{tenantCode}/report?reportDate={reportDate}&reportName={reportName}&storeId={storeId}"
  description         = "Retrieve Report"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  template_parameter {
    name        = "reportDate"
    required    = true
    values      = []
    type        = "string"
    description = "Business of report desired formated in mm/dd/yyyy"
  } 

  template_parameter {
    name        = "reportName"
    required    = true
    values      = []
    type        = "string"
    description = "Name of report to use. Currently only supports NAXML-3.6"
  }

  template_parameter {
    name        = "storeId"
    required    = true
    values      = []
    type        = "string"
    description = "store id to generate the report against"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-journal-summary" {
  operation_id        = "pdi-experience-api-journal-summary"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Journal Summary"
  method              = "GET"
  url_template        = "/{tenantCode}/report/journals"
  description         = "Retrieve Journal Summary"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    query_parameter {
      name        = "storeId"
      required    = true
      values      = []
      type        = "string"
      description = "storeId for the journal you are pulling"
    }

    query_parameter {
      name        = "reportName"
      required    = true
      values      = []
      type        = "string"
      description = "type of report being run including the schema of the returned file. "
    }

    query_parameter {
      name        = "toDate"
      required    = false
      values      = []
      type        = "string"
      description = "zonedDateTime to the cut off of the journal. Not fully supported. NOT REQUIRED"
    } 

    query_parameter {
      name        = "fromDate"
      required    = false
      values      = []
      type        = "string"
      description = "zonedDateTime of the start of the journal. Not fully supported. NOT REQUIRED"
    }  
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-post-v1-pricebook-upload" {
  operation_id        = "pdi-experience-api-post-v1-pricebook-upload"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Pricebook Upload"
  method              = "POST"
  url_template        = "/{tenantCode}/pricebook/{posSiteId}"
  description         = "Pricebook Upload"

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
    description = "Store Id for which the pricebook is being uploaded"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-swagger" {
  operation_id        = "pdi-experience-api-swagger"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger"
  method              = "GET"
  url_template        = "/api-docs/"
  description         = "Swagger"
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-swagger-resources" {
  operation_id        = "pdi-experience-api-swagger-resources"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger Resources"
  method              = "GET"
  url_template        = "/api-docs/{resource}"
  description         = "Swagger Resources"

  template_parameter {
    name        = "resource"
    required    = true
    values      = []
    type        = "string"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-authorization" {
  operation_id        = "pdi-experience-api-authorization"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Authorization"
  method              = "POST"
  url_template        = "/{tenantCode}/authservice/session"
  description         = "Authorization"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-pdi-experience-api-pricebook-download" {
  operation_id        = "pdi-experience-api-pricebook-download"
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Pricebook Download"
  method              = "GET"
  url_template        = "/{tenantCode}/pricebook?posSiteId={posSiteId}"
  description         = "Pricebook Download"

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
    type        = "SecureString"
  } 
}

###Policies
##API Policy
resource "azurerm_api_management_api_policy" "policy-pdi-api" {
  api_name            = azurerm_api_management_api.apim-api-pdi.name
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
                    <value>StoreAdmin</value>        
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
resource "azurerm_api_management_api_operation_policy" "policy-pdi-swagger" {
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-pdi-experience-api-swagger.operation_id

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

resource "azurerm_api_management_api_operation_policy" "policy-pdi-swagger-resources" {
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-pdi-experience-api-swagger-resources.operation_id

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

resource "azurerm_api_management_api_operation_policy" "policy-pdi-swagger-authorization" {
  api_name            = azurerm_api_management_api.apim-api-pdi.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-pdi-experience-api-authorization.operation_id

  xml_content = <<XML
<policies>  
    <inbound>    
        <set-backend-service base-url="http://${var.ngrp_orchestrator_url}:8080/auth/v1" />    
        <rewrite-uri template="/{tenantCode}/session" />    
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