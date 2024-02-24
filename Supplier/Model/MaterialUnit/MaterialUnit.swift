//
//  MaterialUnit.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct MaterialUnit: Mappable {
    var id = 0
    var code = ""
    var name = ""
    var description = ""
    var status = 0
    var supplier_id = 0
   
    var created_at = ""
    var material_unit_specifications:[UnitSpecification] = []
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
        description <- map["description"]
        status <- map["status"]
        supplier_id <- map["supplier_id"]
        created_at <- map["created_at"]
        material_unit_specifications <- map["material_unit_specifications"]
     
    }
    
}
