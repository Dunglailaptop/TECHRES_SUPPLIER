//
//  WarehouseReceipt.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 02/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct WarehouseReceiptResponse:Mappable{
    var limit = 0
    var total_record = 0
    var data = [WarehouseReceipt]()
    var total_amount = 0
    
    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        limit <- map["limit"]
        total_record <- map["total_record"]
        data <- map["list"]
        total_amount <- map["total_amount"]
    }
    
}

struct WarehouseReceipt:Mappable{
    var id = 0
    var number = 0
    var code = ""
    var amount:Double = 0.0
    var supplier_id = 0
    var supplier_employee_id = 0
    var supplier_employee_name = ""
    var supplier_order_id = 0
    var source_of_supply_name = ""
    var discount_amount:Double = 0.0
    var discount_percent:Float = 0.0
    var discount_type = 0
    var vat:Float = 0.0
    var vat_amount:Double = 0.0
    var total_amount:Double = 0.0
    var total_material = 0
    var payment_status = 0
    var payment_date = ""
    var type = 0
    var status =  2
    var delivery_date = ""
    var is_include_vat = 0
    var note = ""
    var created_at = ""
    var isSelected = DEACTIVE

    init() {}
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        id <- map["id"]
        number <- map["number"]
        code <- map["code"]
        amount <- map["amount"]
        supplier_id <- map["supplier_id"]
        supplier_employee_id <- map["supplier_employee_id"]
        supplier_employee_name <- map["supplier_employee_name"]
        supplier_order_id <- map["supplier_order_id"]
        source_of_supply_name <- map["source_of_supply_name"]
        discount_amount <- map["discount_amount"]
        discount_percent <- map["discount_percent"]
        discount_type <- map["discount_type"]
        vat <- map["vat"]
        vat_amount <- map["vat_amount"]
        total_amount <- map["total_amount"]
        total_material <- map["total_material"]
        payment_status <- map["payment_status"]
        payment_date <- map["payment_date"]
        type <- map["type"]
        status <- map["status"]
        delivery_date <- map["delivery_date"]
        is_include_vat <- map["is_include_vat"]
        note <- map["note"]
        created_at <- map["created_at"]
    }
}


