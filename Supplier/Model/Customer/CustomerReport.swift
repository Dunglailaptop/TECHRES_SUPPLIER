//
//  RestaurantReport.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
 

struct CustomerReport: Mappable {
   var id = 0
    var  name = ""
    var  phone = ""
    var  address = ""
    var  email = ""
    var  total_order = 0
    var  total_order_amount = 0
    var  waitting_payment = 0
    var  waitting_payment_amount = 0
    var  done = 0
    var  done_amount = 0
    var  canceled = 0
    var  contactors = 0
    
    init() {
        
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
           id <- map["id"]
           name <- map["name"]
           phone <- map["phone"]
           address <- map["address"]
           email <- map["email"]
           total_order <- map["total_order"]
           total_order_amount <- map["total_order_amount"]
           waitting_payment <- map["waitting_payment"]
           waitting_payment_amount <- map["waitting_payment_amount"]
           done <- map["done"]
           done_amount <- map["done_amount"]
           canceled <- map["canceled"]
           contactors <- map["contactors"]
    }
}
