//
//  SupplierDebtPaymentRequest.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierDebtPaymentRequest: Mappable {
    
    var restaurant_id = 0
    var branch_id = 0
    var status = 0
    var from_date = ""
    var to_date = ""
    var supplier_order_ids = [Int]()
    var insert_supplier_order_ids = [Int]()
    var delete_supplier_order_ids = [Int]()
    
      
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        restaurant_id                                             <- map["restaurant_id"]
        branch_id                                             <- map["branch_id"]
        status                                             <- map["status"]
        from_date                                             <- map["from_date"]
        to_date                                             <- map["to_date"]
        supplier_order_ids                                             <- map["supplier_order_ids"]
        insert_supplier_order_ids                                             <- map["insert_supplier_order_ids"]
        delete_supplier_order_ids                                             <- map["delete_supplier_order_ids"]
    }
}
