//
//  SupplierOrdersResquest.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct ListMaterialResquest: Mappable {
    var supplier_material_id = 0
    var quantity:Double = 0.00
    var supplier_order_detail_id = 0
    var price_reality:Double = 0.00
    var sort = 1
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        supplier_material_id                  <- map["supplier_material_id"]
        quantity                    <- map["quantity"]
        supplier_order_detail_id                    <- map["supplier_order_detail_id"]
        price_reality                   <- map["price_reality"]
        sort                   <- map["sort"]
    }
}
