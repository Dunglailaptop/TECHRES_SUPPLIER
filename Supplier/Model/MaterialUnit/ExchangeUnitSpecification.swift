//
//  ExchangeUnitSpecification.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper



//đơn vị quy đổi
struct ExchangeUnitSpecification: Mappable {
    var id = 0
    var name = ""

    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
     
    }
    
}
