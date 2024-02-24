//
//  ReceiptPaymentCategory.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper


struct ReceiptPaymentCategory: Mappable {
    var id = 0
    var name = ""
    var description = ""
    var supplier_addition_fee_type = 0
    var supplier_addition_fee_reason_category_id = 0
    var supplier_addition_fee_reason_category_name = ""
    var is_system_auto_generate = 0
    var is_hidden = 0

    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        description <- map["description"]
        supplier_addition_fee_type <- map["supplier_addition_fee_type"]
        supplier_addition_fee_reason_category_id <- map["supplier_addition_fee_reason_category_id"]
        supplier_addition_fee_reason_category_name <- map["supplier_addition_fee_reason_category_name"]
        is_system_auto_generate <- map["is_system_auto_generate"]
        is_hidden <- map["is_hidden"]
    }
}

