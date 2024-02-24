//
//  UnitSpecification.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct UnitSpecification: Mappable {
    var id = 0
    var status = 0
    var name = ""
    var supplier_id = 0
    var exchange_value = 0
    var material_unit_specification_exchange_name_id = 0
    var material_unit_specification_exchange_name =  ""
    var created_at = ""
    var supplier_material_unit_id =  0
    var assign_to_unit_id = 0 //dùng cho API Tạo quy cách quy đổi
    var isSelected = DEACTIVE
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        status <- map["status"]
        name <- map["name"]
        supplier_id <- map["supplier_id"]
        exchange_value <- map["exchange_value"]
        material_unit_specification_exchange_name_id <- map["material_unit_specification_exchange_name_id"]
        material_unit_specification_exchange_name <- map["material_unit_specification_exchange_name"]
        created_at <- map["created_at"]
        supplier_material_unit_id <- map[""]
     
    }
    
}

