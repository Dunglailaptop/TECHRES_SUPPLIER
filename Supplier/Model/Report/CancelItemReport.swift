//
//  CancelItemReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct CancelItemReport: Mappable {
    var report_type = 0
    var date_string = ""
    
    var id = 0
    var supplier_id = 0
    var material_category_id = 0
    var material_category_name = ""
    var supplier_material_id = 0
    var supplier_material_name = ""
    var quantity = 0
    var total_amount = 0
    init() {}

    init?(map:Map) {
    }

    mutating func mapping(map:Map){
        id <- map["id"]
        supplier_id <- map["supplier_id"]
        material_category_id <- map["material_category_id"]
        material_category_name <- map["material_category_name"]
        supplier_material_id <- map["supplier_material_id"]
        supplier_material_name <- map["supplier_material_name"]
        quantity <- map["quantity"]
        total_amount <- map["total_amount"]
     
    }
}
