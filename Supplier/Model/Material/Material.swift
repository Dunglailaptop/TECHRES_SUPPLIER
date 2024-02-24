//
//  Material.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 15/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct MaterialResponse:Mappable{
    var limit = 0
    var total_record = 0
    var data = [Material]()
    
    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        limit <- map["limit"]
        total_record <- map["total_record"]
        data <- map["list"]
    }
    
}



struct Material: Mappable {
    var id = 0
    var code = ""
    var avatar = ""
    var avatar_thumb = ""
    var name = ""
    var material_unit_id = 0
    var material_category_name = ""
    var material_unit_name = ""
    var material_unit_specification_id = 0
    var material_unit_specification_name = ""
    var material_unit_specification_exchange_value = 0
    var material_category_id = 0
    
    var price = 0
    var total_amount_from_quantity_import = 0
    var wholesale_price = 0
    var wholesale_price_quantity:Float = 0.0
    var retail_price = 0
    var out_stock_alert_quantity:Float = 0.0
    var wastage_rate:Float = 0.00
    var status = 0
    var description = ""
    var total_quantity_from_order:Float = 0.00
    var total_import_quantity = 0.00
    var remain_quantity:Float = 0.00
    var isSelected = 0
    
    
   

    
    init() {}
    init?(map:Map) {
    }

    mutating func mapping(map:Map){
        id <- map["id"]
        code <- map["code"]
        avatar <- map["avatar"]
        avatar_thumb <- map["avatar_thumb"]
        name <- map["name"]
        material_unit_id <- map["material_unit_id"]
        material_category_name <- map["material_category_name"]
        material_unit_name <- map["material_unit_name"]
        material_unit_specification_id <- map["material_unit_specification_id"]
        material_unit_specification_name <- map["material_unit_specification_name"]
        material_unit_specification_exchange_value <- map["material_unit_specification_exchange_value"]
        material_category_id <- map["material_category_id"]

        price <- map["price"]
        total_amount_from_quantity_import <- map["total_amount_from_quantity_import"]
        wholesale_price <- map["wholesale_price"]
        wholesale_price_quantity <- map["wholesale_price_quantity"]
        retail_price <- map["retail_price"]
        out_stock_alert_quantity <- map["out_stock_alert_quantity"]
        wastage_rate <- map["wastage_rate"]
        status <- map["status"]
        description <- map["description"]
        remain_quantity <- map["remain_quantity"]
        total_quantity_from_order <- map["total_quantity_from_order"]
        total_import_quantity <- map["total_import_quantity"]
        isSelected <- map["isSelected"]
    }
}
