//
//  MaterialMeasureUnit.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct MaterialMeasureUnit: Mappable {
    var id = 0
    var code = ""
    var name = ""
    var description = ""
    var status = 0
    var supplier_id = 0
    var material_unit_specifications:[MaterialUnitSpecification] = []
    var isSelect = DEACTIVE
    
    init() {}
    init?(map:Map) {
    }

    mutating func mapping(map:Map){
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
        description <- map["description"]
        status <- map["status"]
        supplier_id <- map["supplier_id"]
        material_unit_specifications <- map["material_unit_specifications"]
    }
}


struct MaterialUnitSpecification:Mappable{
    var id = 0
    var supplier_id = 0
    var name = ""
    var exchange_value = 0
    var material_unit_specification_exchange_name_id = 0
    var material_unit_specification_exchange_name = ""
    var isSelect = DEACTIVE
        init() {}
        init?(map:Map) {
        }

        mutating func mapping(map:Map){
            id <- map["id"]
            supplier_id <- map["supplier_id"]
            name <- map["name"]
            exchange_value <- map["exchange_value"]
            material_unit_specification_exchange_name_id <- map["material_unit_specification_exchange_name_id"]
            material_unit_specification_exchange_name <- map["material_unit_specification_exchange_name"]
        }
    
}


