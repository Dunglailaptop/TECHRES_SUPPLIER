//
//  SupplierDebtPaymentResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierDebtPaymentResponse: Mappable {
    var limit = 0
    var data = [SupplierDebtPayment]()
    var total_amount = 0
    var total_record = 0
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        data <- map["list"]
        total_amount <- map["total_amount"]
        total_record <- map["total_record"]
       
    }
}

struct SupplierDebtPayment: Mappable{
    var id = 0
    var status = 0
    var restaurant_id = 0
    var restaurant_brand_id = 0
    var branch_id = 0
    var supplier_id = 0
    var restaurant_name = ""
    var restaurant_logo = ""
    var restaurant_phone = ""
    var restaurant_brand_name = ""
    var branch_name = ""
    var supplier_name = ""
    var total_amount = 0
    var from_date = ""
    var to_date = ""
    var created_at = ""
    var updated_at = ""
    var reason = ""
    var is_deleted = 0
    var isSelected = 0
    var supplier_order_ids = [Int]()
    
    var report_type = 0
    var date_string = ""
    var code = ""
      
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id                                             <- map["id"]
        status                                             <- map["status"]
        restaurant_id                                             <- map["restaurant_id"]
        restaurant_brand_id                                             <- map["restaurant_brand_id"]
        branch_id                                             <- map["branch_id"]
        supplier_id                                             <- map["supplier_id"]
        restaurant_id                                             <- map["restaurant_id"]
        reason                                             <- map["reason"]
        restaurant_brand_name                                             <- map["restaurant_brand_name"]
        restaurant_name                                             <- map["restaurant_name"]
        restaurant_phone                                             <- map["restaurant_phone"]
        supplier_name                                             <- map["supplier_name"]
        branch_name                                             <- map["branch_name"]
        total_amount                                             <- map["total_amount"]
        from_date                                             <- map["from_date"]
        to_date                                             <- map["to_date"]
        created_at                                             <- map["created_at"]
        updated_at                                             <- map["updated_at"]
        is_deleted                                             <- map["is_deleted"]
        isSelected                                             <- map["isSelected"]
        supplier_order_ids                                             <- map["supplier_order_ids"]
        code <- map["code"]
    }
    
}
