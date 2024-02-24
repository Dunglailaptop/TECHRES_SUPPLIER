//
//  MaterialWarehouseSessionsResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 04/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct MaterialWarehouseSessionsResponse: Mappable {
    var limit = 0
    var data = [MaterialWarehouseSessions]()
    var total_amount = 0
    var total_record = 0
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        data <- map["list"]
        total_amount <- map["total_amount"]
        total_record <- map["total_record"]
       
    }
}

struct MaterialWarehouseSessions: Mappable {
    var id = 0
    var supplier_material_id = 0
    var supplier_material_name = ""
    var unit_name = ""
    var note = ""
    var supplier_input_price = 0
    var total_price = 0
    var quantity = 0.00
    var supplier_quantity = 0.00
    var supplier_input_quantity = 0.00
    var system_last_quantity = 0.00
    var supplier_input_unit_name = ""
    var material_category_name = ""
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id                              <- map["id"]
        supplier_material_id                              <- map["supplier_material_id"]
        supplier_material_name             <- map["supplier_material_name"]
        unit_name                        <- map["unit_name"]
        note                            <- map["note"]
        supplier_input_price               <- map["supplier_input_price"]
        total_price                      <- map["total_price"]
        quantity                         <- map["quantity"]
        supplier_quantity                 <- map["supplier_quantity"]
        supplier_quantity                 <- map["supplier_quantity"]
        supplier_input_quantity            <- map["supplier_input_quantity"]
        system_last_quantity               <- map["system_last_quantity"]
        supplier_input_unit_name           <- map["supplier_input_unit_name"]
        material_category_name             <- map["material_category_name"]
    }
}
