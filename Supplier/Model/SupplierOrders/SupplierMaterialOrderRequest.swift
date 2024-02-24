//
//  SupplierMaterialOrderRequest.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierMaterialOrderRequest: Mappable {
    var sort = 0
    var supplier_warehouse_session_detail_id = 0
    var supplier_material_id = 0
    var supplier_input_quantity = 0.00
    var supplier_input_unit_type = 0
    var supplier_input_price = 0
    var note = ""
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        sort                  <- map["sort"]
        supplier_warehouse_session_detail_id                    <- map["supplier_warehouse_session_detail_id"]
        supplier_material_id                    <- map["supplier_material_id"]
        supplier_input_quantity                   <- map["supplier_input_quantity"]
        supplier_input_unit_type                   <- map["supplier_input_unit_type"]
        supplier_input_price                   <- map["supplier_input_price"]
        note                   <- map["note"]
    }
}
