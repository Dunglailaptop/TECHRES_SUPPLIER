//
//  SupplierRole.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierRoleModel: Mappable {
    var data = SupplierRole()
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
    }
}

struct SupplierRole: Mappable{
    var id = 0
    var code = ""
    var name = ""
    var description = ""
    var status = 0
    var created_at = ""
    var updated_at = ""
   var isSelected = DEACTIVE
    
    
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id <- map["id"]
        code <- map["code"]
        name <- map["name"]
        description <- map["description"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
    }
}
