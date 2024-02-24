//
//  DebtReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct DebtReport: Mappable {
    var date_string = ""
    var report_type = 0
    
    
    var total_order = 0
    var total_order_amount = 0
    var total_order_paid = 0
    var order_paid_amount = 0
    var total_order_pending_payment = 0
    var order_pending_payment_amount = 0
    var total_warehouse_session = 0
    var warehouse_session_amount = 0
    var total_warehouse_session_paid = 0
    var warehouse_session_paid_amount = 0
    var total_warehouse_session_pending_payment = 0
    var warehouse_session_pending_payment_amount = 0
    var from_date = ""
    var to_date = ""
    
    
    init() {}
    
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        total_order <- map[""]
        total_order_amount <- map["total_order_amount"]
        total_order_paid <- map["total_order_paid"]
        order_paid_amount <- map["order_paid_amount"]
        total_order_pending_payment <- map["total_order_pending_payment"]
        order_pending_payment_amount <- map["order_pending_payment_amount"]
        total_warehouse_session <- map["total_warehouse_session"]
        warehouse_session_amount <- map["warehouse_session_amount"]
        total_warehouse_session_paid <- map["total_warehouse_session_paid"]
        warehouse_session_paid_amount <- map["warehouse_session_paid_amount"]
        total_warehouse_session_pending_payment <- map["total_warehouse_session_pending_payment"]
        warehouse_session_pending_payment_amount <- map["warehouse_session_pending_payment_amount"]
        from_date <- map["from_date"]
        to_date <- map["to_date"]
    }
}
