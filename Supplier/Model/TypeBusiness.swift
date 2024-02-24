//
//  TypeBusiness.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 13/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct TypeBusiness: Mappable {
    var createdAt = ""
    var updatedAt = ""
    var id = 0
    var name = ""
    var description = ""
    var hidden = ""
    var isSelected = DEACTIVE
    
    init(){
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         createdAt <- map["createdAt"]
         updatedAt <- map["updatedAt"]
         id <- map["id"]
         name <- map["name"]
        description <- map["description"]
         hidden  <- map["hidden"]
    }
}
