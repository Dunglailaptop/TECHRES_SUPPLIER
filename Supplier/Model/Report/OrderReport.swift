//
//  OrderReportswift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023
//  Copyright © 2023 OVERATE-VNTECH All rights reserved
//

import UIKit
import ObjectMapper
struct OrderReport: Mappable {
    var report_type = 0
    var date_string = ""
    var total_amount = ""
    var data:[OrderReportData] = []
    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        total_amount <- map["total_amount"]
        data <- map["data"]
    }
}
struct OrderReportData: Mappable {
    var total_order = 0
    var report_time = ""
    var total_amount = 0
    var order_delivered = 0
    var order_delivered_amount = 0
    var order_not_delivered = 0
    var order_not_delivered_amount = 0
    var order_cancel = 0
    var order_cancel_amount = 0
    var total_return = 0
    var total_return_amount = 0
    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        total_order <- map["total_order"]
        report_time <- map["report_time"]
        total_amount <- map["total_amount"]
        order_delivered <- map["order_delivered"]
        order_delivered_amount <- map["order_delivered_amount"]
        order_not_delivered <- map["order_not_delivered"]
        order_not_delivered_amount <- map["order_not_delivered_amount"]
        order_cancel <- map["order_cancel"]
        order_cancel_amount <- map["order_cancel_amount"]
        total_return <- map["total_return"]
        total_return_amount <- map["total_return_amount"]
    }
}
