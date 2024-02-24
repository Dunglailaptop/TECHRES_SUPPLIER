//
//  DetailSupplierOrderResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct DetailSupplierOrderResponse: Mappable {
    var id = 0
    var supplier_material_id = 0
    var supplier_order_request_id = 0
    var supplier_material_category_name = ""
    var supplier_material_name = ""
    var supplier_material_code = ""
    var supplier_unit_name = ""
    var supplier_unit_full_name = ""
    var supplier_unit_specification_exchange_value = 0
    var supplier_unit_specification_exchange_name = ""
    var restaurant_name = ""
    var restaurant_brand_name = ""
    var branch_name = ""
    var supplier_name = ""
    var created_at = ""
    var expected_delivery_time = ""
    var quantity:Double = 0.00
    var status = 0
    var retail_price = 0
    var total_amount = 0
    var supplier_quantity:Double = 0.00
    var supplier_total_amount = 0
    var is_supplier_update = 0
    var supplier_rate_quantity = 0
    var system_last_quantity:Double = 0.00
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id                          <- map["id"]
        supplier_material_id                          <- map["supplier_material_id"]
        supplier_order_request_id                          <- map["supplier_order_request_id"]
        supplier_material_category_name                            <- map["supplier_order_request_id"]
        supplier_material_name                         <- map["supplier_material_name"]
        supplier_material_code                         <- map["supplier_material_code"]
        supplier_unit_name                         <- map["supplier_unit_name"]
        supplier_unit_full_name                            <- map["supplier_unit_full_name"]
        supplier_unit_specification_exchange_value                         <- map["supplier_unit_specification_exchange_value"]
        supplier_unit_specification_exchange_name                          <- map["supplier_unit_specification_exchange_name"]
        restaurant_name                          <- map["restaurant_name"]
        restaurant_brand_name                          <- map["restaurant_brand_name"]
        branch_name                          <- map["branch_name"]
        supplier_name                          <- map["supplier_name"]
        created_at                          <- map["created_at"]
        expected_delivery_time                          <- map["expected_delivery_time"]
        quantity                           <- map["quantity"]
        status                         <- map["status"]
        retail_price                           <- map["retail_price"]
        total_amount                           <- map["total_amount"]
        supplier_quantity                          <- map["supplier_quantity"]
        supplier_total_amount                          <- map["supplier_total_amount"]
        is_supplier_update                         <- map["is_supplier_update"]
        supplier_rate_quantity                         <- map["supplier_rate_quantity"]
        system_last_quantity                           <- map["system_last_quantity"]
    }
}
