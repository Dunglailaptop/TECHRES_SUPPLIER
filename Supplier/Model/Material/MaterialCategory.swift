//
//  MaterialCategory.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct MaterialCategory:Mappable {
    var code = ""
    var description = ""
    var id = 0
    var material_category_type_parent_id = 0
    var material_category_type_parent_name = ""
    var name = ""
    var normalize_name = ""
    var status = 0
    var isSelect = DEACTIVE
    init() {}
    init?(map:Map) {
    }

    mutating func mapping(map:Map){
        code <- map["code"]
        description <- map["description"]
        id <- map["id"]
        material_category_type_parent_id <- map["material_category_type_parent_id"]
        material_category_type_parent_name <- map["material_category_type_parent_name"]
        name <- map["name"]
        normalize_name <- map["normalize_name"]
        status <- map["status"]
    }
}
