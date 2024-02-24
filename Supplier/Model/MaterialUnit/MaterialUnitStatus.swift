//
//  MaterialUnitStatus.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct MaterialUnitStatus: Mappable{
    var id = 0
    var code = ""
    var name = ""
    var description = ""
    var status = 0
    var material_category_id = 0
    var material_category_name = ""
    var material_unit_id = 0
    var material_unit_specification_id = 0
//           material_unit: [
//               {
//                   id: 11
//                   code: KET
//                   name: Két
//                   description: mô tả cho két
//                   status: 1
//                   supplier_id: 172
//                   created_at: 24/09/2021 21:13
//                   updated_at: 28/07/2023 10:20
//                   material_unit_specifications: [
//                       {
//                           id: 15
//                           status: 1
//                           name: 1 két
//                           supplier_id: 172
//                           exchange_value: 20
//                           material_unit_specification_exchange_name_id: 55
//                           material_unit_specification_exchange_name: Bao
//                           is_deleted: 0
//                           created_at: 24/09/2021 21:11:19
//                           updated_at: 09/11/2021 17:44:36
//                           supplier_material_unit_id: 11
//                       }
//                   ]
//               }
//           ]
    
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
        material_category_id <- map["material_category_id"]
        material_category_name <- map["material_category_name"]
        material_unit_id <- map["material_unit_id"]
        material_unit_specification_id <- map["material_unit_specification_id"]
    }
        
}
