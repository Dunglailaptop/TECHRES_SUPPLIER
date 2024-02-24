//
//  Supplier.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierModel: Mappable {
    var limit = 0
    var list = [Supplier]()
    var total_record = 0
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
        limit <- map["limit"]
        total_record <- map["total_record"]
    }
}


struct Supplier: Mappable {
  var id = 0
  var server_ip_address = ""
  var restaurant_name = ""
  var name = ""
  var brand_name = ""
  var email = ""
  var phone = ""
  var info = ""
  var tax_number = ""
  var address = ""
  var restaurant_balance =  0
  var is_done_setup = 0
  var is_public = 0
  var status = 0
  var total_supplier_order_request = 0
  var total_supplier_order = 0
  var logo = ""
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        server_ip_address <- map["server_ip_address"]
        restaurant_name <- map["restaurant_name"]
        name <- map["name"]
        brand_name <- map["brand_name"]
        email <- map["email"]
        phone <- map["phone"]
        info <- map["info"]
        tax_number <- map["tax_number"]
        address <- map["address"]
        restaurant_balance <- map["restaurant_balance"]
        is_done_setup <- map["is_done_setup"]
        is_public <- map["is_public"]
        status <- map["status"]
        total_supplier_order_request <- map["total_supplier_order_request"]
        total_supplier_order <- map["total_supplier_order"]
        logo <- map["logo"]
    }
}