//
//  RevenueCostProfitReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct RevenueCostProfitReport:Mappable{
    var report_type = 0
    var date_string = ""
    
    
    var total_revenue = 0
    var total_cost = 0
    var total_profit = 0
    var profit_percent:Float = 0.0
    var data:[RevenueCostProfitData] = []
    
    
    init() {}
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map){
        total_revenue <- map["total_revenue"]
        total_cost <- map["total_cost"]
        total_profit <- map["total_profit"]
        profit_percent <- map["profit_percent"]
        data <- map["data"]
    }
}

struct RevenueCostProfitData:Mappable{
    var report_time = ""
    var supplier_revenue = 0
    var supplier_cost = 0
    var supplier_profit = 0
    
    init() {}
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map){
        report_time <- map["report_time"]
        supplier_revenue <- map["supplier_revenue"]
        supplier_cost <- map["supplier_cost"]
        supplier_profit <- map["supplier_profit"]
      
    }
}



