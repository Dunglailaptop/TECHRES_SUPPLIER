//
//  SupplierOrdersRequestResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierOrdersRequestResponse: Mappable {
    var limit = 0
    var data = [SupplierOrdersRequest]()
    var total_amount = 0
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        data <- map["list"]
        total_amount <- map["total_amount"]
       
    }
}

struct SupplierOrdersRequest: Mappable{
    var id = 0
    var restaurant_id = 0
    var branch_name = ""
    var code = ""
    var created_at = ""
    var updated_at = ""
    var expected_delivery_time = ""
    var employee_created_full_name = ""
    var reason = ""
    var restaurant_brand_name = ""
    var restaurant_name = ""
    var restaurant_email = ""
    var status = 0
    var supplier_avatar = ""
    var supplier_name = ""
    var supplier_phone = ""
    var total_amount = 0
    var total_material = 0
    var quantity = 0
    var supplier_discount_percent = 0.0
    var supplier_vat = 0.0
    var supplier_order_request_detail = [SupplierOrderRequestDetail]()
    
      
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id                                             <- map["id"]
        restaurant_id                                             <- map["restaurant_id"]
        branch_name                                             <- map["branch_name"]
        code                                             <- map["code"]
        created_at                                             <- map["created_at"]
        updated_at                                             <- map["updated_at"]
        expected_delivery_time                                             <- map["expected_delivery_time"]
        employee_created_full_name                                             <- map["employee_created_full_name"]
        reason                                             <- map["reason"]
        restaurant_brand_name                                             <- map["restaurant_brand_name"]
        restaurant_name                                             <- map["restaurant_name"]
        restaurant_email                                             <- map["restaurant_email"]
        status                                             <- map["status"]
        supplier_avatar                                             <- map["supplier_avatar"]
        supplier_name                                             <- map["supplier_name"]
        supplier_phone                                             <- map["supplier_phone"]
        total_amount                                             <- map["total_amount"]
        total_material                                             <- map["total_material"]
        quantity                                             <- map["quantity"]
        supplier_discount_percent                                             <- map["supplier_discount_percent"]
        supplier_vat                                             <- map["supplier_vat"]
        supplier_order_request_detail                                             <- map["supplier_order_request_detail"]
    }
    
}

struct SupplierOrderRequestDetail: Mappable {
    var id = 0
    var quantity = 0.0
    var supplier_material_id = 0
    var supplier_order_request_id = 0
    var supplier_material_name = ""
    var supplier_unit_name = ""
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        quantity                    <- map["quantity"]
        supplier_material_id                    <- map["supplier_material_id"]
        supplier_order_request_id                   <- map["supplier_order_request_id"]
        supplier_material_name                  <- map["supplier_material_name"]
        supplier_unit_name                  <- map["supplier_unit_name"]
    }
}
