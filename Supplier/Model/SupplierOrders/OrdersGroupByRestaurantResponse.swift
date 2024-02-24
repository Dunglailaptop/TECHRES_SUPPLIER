//
//  OrdersGroupByRestaurantResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct OrdersGroupByRestaurantResponse: Mappable {
    var limit = 0
    var data = [OrdersGroupByRestaurant]()
    var total_amount = 0
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        data <- map["list"]
        total_amount <- map["total_amount"]
    }
}

struct OrdersGroupByRestaurant: Mappable {
    var restaurant_id = 0
    var total_amount = 0.00
    var total_order = 0
    var restaurant_name = ""
    var restaurant_phone = ""
    var restaurant_logo = ""
    var restaurant_address = ""
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        restaurant_id                  <- map["restaurant_id"]
        total_amount                    <- map["total_amount"]
        total_order                    <- map["total_order"]
        restaurant_name                   <- map["restaurant_name"]
        restaurant_phone                  <- map["restaurant_phone"]
        restaurant_logo                  <- map["restaurant_logo"]
        restaurant_address                  <- map["restaurant_address"]
    }
}
