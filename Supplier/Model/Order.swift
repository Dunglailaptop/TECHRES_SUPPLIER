//
//  Order.swift
//  Supplier
//
//  Created by kelvin on 12/07/2023.
//

import UIKit
import ObjectMapper

struct OrderData: Mappable {
    var orders: [Order]?
    
    init?(map: Map) {
    }

    
    mutating func mapping(map: Map) {
        orders <- map["list"]
    }
}
struct OrderResponse:Mappable{
    var limit: Int?
    var data = [OrderData]()
    var total_record:Int?
      
    init?(map: Map) {
    }

    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        data <- map["data"]
        total_record <- map["total_record"]
    }
    
}

struct Order: Mappable {
    var id: Int!
    var amount = 0
    var payment_day = ""
    var table_name = ""
    var employee_name   = ""
    var total_amount   = 0
    var total_discount_amount   = 0
    var discount_percent   = 0
    var discount_amount   = 0
    var vat_amount   = 0
    
    
     init?(map: Map) {
    }
    init?() {
    }

    mutating func mapping(map: Map) {
        id <- map["id"]
        amount <- map["amount"]
        payment_day <- map["payment_day"]
        table_name <- map["table_name"]
        employee_name <- map["employee_name"]
        total_amount <- map["total_amount"]
        total_discount_amount <- map["total_discount_amount"]
        discount_percent <- map["discount_percent"]
        discount_amount <- map["discount_amount"]
        vat_amount <- map["vat_amount"]
    }
}
