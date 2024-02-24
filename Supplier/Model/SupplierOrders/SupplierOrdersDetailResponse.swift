//
//  SupplierOrdersDetailResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierOrdersDetailResponse: Mappable {
    
    var id = 0
    var status = 0
    var supplier_material_category_name = ""
    var supplier_material_name = ""
    var supplier_material_code = ""
    var supplier_unit_name = ""
    var supplier_unit_full_name = ""
    var supplier_unit_specification_exchange_value = 0
    var supplier_unit_specification_exchange_name = ""
    var supplier_order_id = 0
    var created_at = ""
    var total_quantity = 0.0
    var accept_quantity = 0.0
    var return_quantity = 0.0
    var request_quantity = 0.0
    var total_quantity_before = 0.0
    var response_quantity = 0.0
    var price_reality = 0
    var total_price_reality = 0
    var supplier_rate_quantity = 0.0
    var material_unit_conversion_rate = 0.0
    var restaurant_material_id = 0
    var restaurant_material_name = ""
    var material_category_type_parent_id = 0
    var number_count_on_supplier = 0
    var remain_quantity = 0.0
    var total_price = 0
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id                                      <- map["id"]
        status                                     <- map["status"]
        supplier_material_category_name                         <- map["supplier_material_category_name"]
        supplier_material_name                         <- map["supplier_material_name"]
        supplier_material_code                         <- map["supplier_material_code"]
        supplier_unit_name                            <- map["supplier_unit_name"]
        supplier_unit_full_name                         <- map["supplier_unit_full_name"]
        supplier_unit_specification_exchange_value                          <- map["supplier_unit_specification_exchange_value"]
        supplier_unit_specification_exchange_name                          <- map["supplier_unit_specification_exchange_name"]
        supplier_order_id                       <- map["supplier_order_id"]
        created_at                          <- map["created_at"]
        total_quantity                          <- map["total_quantity"]
        accept_quantity                          <- map["accept_quantity"]
        return_quantity                          <- map["return_quantity"]
        request_quantity                           <- map["request_quantity"]
        total_quantity_before                         <- map["total_quantity_before"]
        response_quantity                           <- map["response_quantity"]
        price_reality                           <- map["price_reality"]
        total_price_reality                          <- map["total_price_reality"]
        supplier_rate_quantity                          <- map["supplier_rate_quantity"]
        material_unit_conversion_rate                         <- map["material_unit_conversion_rate"]
        restaurant_material_id                         <- map["restaurant_material_id"]
        restaurant_material_name                           <- map["restaurant_material_name"]
        material_category_type_parent_id                           <- map["material_category_type_parent_id"]
        number_count_on_supplier                           <- map["number_count_on_supplier"]
        remain_quantity <- map["remain_quantity"]
        total_price <- map["total_price"]
    }
}
