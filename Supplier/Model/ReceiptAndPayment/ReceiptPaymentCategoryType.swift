//
//  ReceiptPaymentCategoryType.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct ReceiptPaymentCategoryType: Mappable {
    var id = 0
    var name = ""
    var supplier_addition_fee_type = 0
    var is_system_auto_generate = 0
    var is_hidden = 0
    

    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        supplier_addition_fee_type <- map["supplier_addition_fee_type"]
        is_system_auto_generate <- map["is_system_auto_generate"]
        is_hidden <- map["is_hidden"]
        
    }
}
