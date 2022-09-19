###API
resource "azurerm_api_management_api" "apim-api-mastercard" {
  name                = "mastercard-experience-api"
  resource_group_name = var.resource_group
  api_management_name = azurerm_api_management.apim.name
  revision            = "1"
  display_name        = "Mastercard Experience API"
  path                = "mastercard/v1"
  protocols           = ["https"]
  service_url         = "http://${var.mastercard_experience_api_url}:3000/v1"
  description         = "Experience API"
}

##Operations
resource "azurerm_api_management_api_operation" "apim-api-operation-indicates-user-successful-exit" {
  operation_id        = "indicates-user-successful-exit"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Indicates a user's successful exit from a store"
  method              = "POST"
  url_template        = "/{tenantCode}/shopanywhere/exit"
  description         = "Indicates a user's successful exit from a store"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereExitPostRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-apply-cardinfo-patch" {
  operation_id        = "apply-cardinfo-patch"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Apply a patch to the card info using a jsonpatch payload which adds document sections on an ad-hoc basis"
  method              = "PATCH"
  url_template        = "/{tenantCode}/cardInfo/{id}"
  description         = "Apply a patch to the card info using a jsonpatch payload which adds document sections on an ad-hoc basis"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  template_parameter {
    name        = "id"
    required    = true
    values      = []
    type        = "string"
    description = "The id of the card to update"
  } 

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1CardInfoPatchRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-retrieves-list-of-orders" {
  operation_id        = "retrieves-list-of-orders"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Retrieves the list of orders belonging to the customer with the given Third Bridge User ID"
  method              = "GET"
  url_template        = "/{tenantCode}/orderHistory?thirdBridgeUserId={thirdBridgeUserId}"
  description         = "Retrieves the list of orders belonging to the customer with the given Third Bridge User ID"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  template_parameter {
    name        = "thirdBridgeUserId"
    required    = true
    values      = []
    type        = "string"
  } 

  request {
    query_parameter {
      name      = "page"
      type      = "integer"
      values    = []   
      required  = true   
    }
    query_parameter {
      name      = "pagenum"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "pagesize"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "offset"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "limit"
      type      = "integer"
      values    = []
      required  = true
    }
  }

  response {
    status_code = 200
    description = "OK 200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-create-new-order" {
  operation_id        = "mastercard-create-new-order"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "create new order"
  method              = "POST"
  url_template        = "/{tenantCode}/shopanywhere/order"
  description         = "create new order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereOrderPostRequest"
    }
  }

  response {
    status_code = 201
    description = "201 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-retrieves-list-of-card-info" {
  operation_id        = "mastercard-retrieves-list-of-card-info"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Retrieves the list of card info belonging to the customer with the given Third Bridge User ID"
  method              = "GET"
  url_template        = "/{tenantCode}/cardInfo?thirdBridgeUserId={thirdBridgeUserId}"
  description         = "Retrieves the list of card info belonging to the customer with the given Third Bridge User ID"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  } 

  template_parameter {
    name        = "thirdBridgeUserId"
    required    = true
    values      = []
    type        = "string"
  }

  request {
    query_parameter {
      name      = "page"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "pagenum"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "pagesize"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "offset"
      type      = "integer"
      values    = []
      required  = true
    }
    query_parameter {
      name      = "limit"
      type      = "integer"
      values    = []
      required  = true
    }
  }

  response {
    status_code = 200
    description = "OK 200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-authorize-user-entry" {
  operation_id        = "mastercard-authorize-user-entry"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Authorize user entry into a store"
  method              = "POST"
  url_template        = "/{tenantCode}/authorizeEntry"
  description         = "Authorize user entry into a store"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1AuthorizeEntryPostRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-apply-patch-to-order-info" {
  operation_id        = "mastercard-apply-patch-to-order-info"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Apply a patch to the order info using a jsonpatch payload which adds document sections on an ad-hoc basis"
  method              = "PATCH"
  url_template        = "/{tenantCode}/shopanywhere/order/{uuid}"
  description         = "Apply a patch to the order info using a jsonpatch payload which adds document sections on an ad-hoc basis"

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
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereOrderPatchRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-deletes-single-card-info" {
  operation_id        = "mastercard-deletes-single-card-info"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Deletes a single card info with the given id"
  method              = "DELETE"
  url_template        = "/{tenantCode}/cardInfo/{id}"
  description         = "Deletes a single card info with the given id"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  template_parameter {
    name        = "id"
    required    = true
    values      = []
    type        = "string"
  }

  response {
    status_code = 204
    description = "204 No Content"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-retrieves-card-info-for-given-id" {
  operation_id        = "mastercard-retrieves-card-info-for-given-id"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Retrieves a card info with the given id"
  method              = "GET"
  url_template        = "/{tenantCode}/cardInfo/{id}"
  description         = "Retrieves a card info with the given id"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  template_parameter {
    name        = "id"
    required    = true
    values      = []
    type        = "SecureString"
  }

  response {
    status_code = 200
    description = "OK 200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-posts-final-contents-of-cart" {
  operation_id        = "mastercard-posts-final-contents-of-cart"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Posts the final contents of the cart following the user's exit from the store"
  method              = "POST"
  url_template        = "/{tenantCode}/shopanywhere/cart"
  description         = "Posts the final contents of the cart following the user's exit from the store"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereCartPostRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-creates-new-method-of-payment" {
  operation_id        = "mastercard-creates-new-method-of-payment"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Creates a new method of payment in the NGRP system with the given information"
  method              = "POST"
  url_template        = "/{tenantCode}/cardInfo"
  description         = "Creates a new method of payment in the NGRP system with the given information"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1CardInfoPostRequest"
    }
  }

  response {
    status_code = 201
    description = "OK 201 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-update-existing-order" {
  operation_id        = "mastercard-update-existing-order"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Update existing order"
  method              = "PUT"
  url_template        = "/{tenantCode}/shopanywhere/order"
  description         = "Update existing order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereOrderPutRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
    representation {
      content_type    = "application/json"
    }
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-swagger-endpoint" {
  operation_id        = "mastercard-swagger-endpoint"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger Endpoint"
  method              = "GET"
  url_template        = "/api-docs/"
  description         = "Swagger Endpoint"
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-indicates-user-successful-entry" {
  operation_id        = "mastercard-indicates-user-successful-entry"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Indicates a user's successful entry into a store"
  method              = "POST"
  url_template        = "/{tenantCode}/shopanywhere/entry"
  description         = "Indicates a user's successful entry into a store"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  request {
    representation {
      content_type    = "application/json"
      #schema_id       = azurerm_api_management_api_schema.api-schema.id
      type_name       = "V1ShopanywhereEntryPostRequest"
    }
  }

  response {
    status_code = 200
    description = "200 response"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-swagger-resource-endpoint" {
  operation_id        = "mastercard-swagger-resource-endpoint"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Swagger Resource Endpoint"
  method              = "GET"
  url_template        = "/api-docs/{resource}"
  description         = "Swagger Resource Endpoint"

  template_parameter {
    name        = "resource"
    required    = true
    values      = []
    type        = "string"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-retrieves-details-for-given-order" {
  operation_id        = "mastercard-retrieves-details-for-given-order"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Retrieves details for a given order"
  method              = "GET"
  url_template        = "/{tenantCode}/orderDetails?orderId={orderId}"
  description         = "Retrieves details for a given order"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }

  template_parameter {
    name        = "orderId"
    required    = true
    values      = []
    type        = "string"
    description = "Id of the order for which details are being retrieved"
  }
}

resource "azurerm_api_management_api_operation" "apim-api-operation-mastercard-shelf-tag" {
  operation_id        = "mastercard-shelf-tag"
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  display_name        = "Shelf Tag"
  method              = "GET"
  url_template        = "/{tenantCode}/pricebook/prices"
  description         = "Shelf Tag"

  template_parameter {
    name        = "tenantCode"
    required    = true
    values      = []
    type        = "SecureString"
  }
}

###Poliies
##API Policy
resource "azurerm_api_management_api_policy" "policy-mastercard-api" {
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
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
                    <value>MastercardExpApi</value>          
                    <value>ThirdBridgeExpApi</value>        
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
resource "azurerm_api_management_api_operation_policy" "policy-mastercard-swagger-endpoint" {
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-mastercard-swagger-endpoint.operation_id

  xml_content = <<XML
<policies>  
    <inbound>    
        <set-backend-service base-url="http://${var.mastercard_experience_api_url}:3000/api-mastercard/v1" />  
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

resource "azurerm_api_management_api_operation_policy" "policy-mastercard-swagger-resource-endpoint" {
  api_name            = azurerm_api_management_api.apim-api-mastercard.name
  api_management_name = azurerm_api_management.apim.name
  resource_group_name = var.resource_group
  operation_id        = azurerm_api_management_api_operation.apim-api-operation-mastercard-swagger-resource-endpoint.operation_id

  xml_content = <<XML
<policies>  
    <inbound>    
        <set-backend-service base-url="http://${var.mastercard_experience_api_url}:3000/api-mastercard/v1" />  
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

