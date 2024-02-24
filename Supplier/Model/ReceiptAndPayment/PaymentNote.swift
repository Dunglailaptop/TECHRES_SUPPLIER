//
//  PaymentNote.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct PaymentNote: Mappable {
    var id = 0
    var code = ""
    var total_price_reality = 0
    var created_at = ""
    
    
    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        id <- map["id"]
        code <- map["code"]
        total_price_reality <- map["total_price_reality"]
        created_at <- map["created_at"]
        
    }
}
