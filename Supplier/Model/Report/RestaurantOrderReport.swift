//
//  RestaurantOrderReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct RestaurantOrderReportModel: Mappable {
    var restaurantOrders:[RestaurantOrderReport]?
    var total_amount = ""
    
    init() {}
    init?(map: Map) {
    }

    
    mutating func mapping(map: Map) {
        restaurantOrders <- map["data"]
        total_amount <- map["total_amount"]
    }
}
struct RestaurantOrderReport: Mappable {
    
    var id = 0
    var name = ""
    var phone = ""
    var address = ""
    var email = ""
    var info = ""
    var total_order = 0
    var total_order_delivered = 0
    var total_order_not_delivered = 0
    var total_amount = 0
    var total_vat = 0
    var total_discount = 0
    
    init() {}
    
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        id <- map["id"]
        name <- map["name"]
        phone <- map["phone"]
        address <- map["address"]
        email <- map["email"]
        info <- map["info"]
        total_order <- map["total_order"]
        total_order_delivered <- map["total_order_delivered"]
        total_order_not_delivered <- map["total_order_not_delivered"]
        total_amount <- map["total_amount"]
        total_vat <- map["total_vat"]
        total_discount <- map["total_discount"]
    }
}
