//
//  MaterialPriceList.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper


struct MaterialPriceListModel: Mappable {
    var data = [MaterialPriceList]()

    
    init?() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
    }
    
}


struct MaterialPriceList: Mappable {
       var id = 0
       var code = ""
       var name = ""
       var prefix = ""
       var description = ""
       var status = 0
       var supplier_id = 0
       var restaurant_material_copy_id = 0
       var material_category_id = 0
       var material_unit_id = 0
       var material_unit_specification_id = 0
       var normalize_name = ""
       var avatar = ""
       var avatar_thumb = 0
       var material_category_name = ""
       var price = 0
       var wholesale_price = 0
       var retail_price = 0
       var wholesale_price_quantity = 0
       var out_stock_alert_quantity = 0
       var material_unit_name = ""
       var material_unit_full_name = ""
       var material_unit_specification_name = ""
       var material_unit_specification_exchange_name = ""
       var material_unit_specification_exchange_value = 0
       var remain_quantity = 0
       var created_at = ""
       var updated_at = ""
       var wastage_rate = 0
       var is_update = 0
       var check_update = 0

    init?() {
        
    }
    
    init?(map: Map) {
        
    }

    mutating func mapping(map: Map) {
         id <- map["id"]
         code <- map["code"]
         name <- map["name"]
         prefix <- map["prefix"]
         description <- map["description"]
         status <- map["status"]
         supplier_id <- map["supplier_id"]
         restaurant_material_copy_id <- map["restaurant_material_copy_id"]
         material_category_id <- map["material_category_id"]
         material_unit_id <- map["material_unit_id"]
         material_unit_specification_id <- map["material_unit_specification_id"]
         normalize_name <- map["normalize_name"]
         avatar <- map["avatar"]
         avatar_thumb <- map["avatar_thumb"]
         material_category_name <- map["material_category_name"]
         price <- map["price"]
         wholesale_price <- map["wholesale_price"]
         retail_price <- map["retail_price"]
         wholesale_price_quantity <- map["wholesale_price_quantity"]
         out_stock_alert_quantity <- map["out_stock_alert_quantity"]
         material_unit_name <- map["material_unit_name"]
         material_unit_full_name <- map["material_unit_full_name"]
         material_unit_specification_name <- map["material_unit_specification_name"]
         material_unit_specification_exchange_name <- map["material_unit_specification_exchange_name"]
         material_unit_specification_exchange_value <- map["material_unit_specification_exchange_value"]
         remain_quantity <- map["remain_quantity"]
         created_at <- map["created_at"]
         updated_at <- map["updated_at"]
         wastage_rate <- map["wastage_rate"]
         is_update <- map["is_update"]
         check_update <- map["check_update"]
    }
}
