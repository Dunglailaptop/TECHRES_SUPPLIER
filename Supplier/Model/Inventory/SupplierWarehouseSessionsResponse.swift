//
//  SupplierWarehouseSessionsResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierWarehouseSessionsResponse: Mappable {
    var limit = 0
    var data = [SupplierWarehouseSessions]()
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

struct SupplierWarehouseSessions: Mappable{
    var id = 0
    var number = 0
    var code = ""
    var amount = 0
    var supplier_id = 0
    var supplier_employee_name = ""
    var source_of_supply_name = ""
    var supplier_name = ""
    var discount_amount = 0
    var discount_percent = 0
    var discount_type = 0
    var vat = 0
    var vat_amount = 0
    var total_amount = 0
    var total_material = 0
    var payment_status = 0
    var type = 0
    var status = 0
    var is_include_vat = 0
    var payment_date = ""
    var delivery_date = ""
    var created_at = ""
    var updated_at = ""
    var note = ""
    var is_deleted = 0
    
    var date_string = ""
    var report_type = 0
          
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id                                             <- map["id"]
        number                                             <- map["number"]
        code                                             <- map["code"]
        amount                                             <- map["amount"]
        supplier_id                                             <- map["supplier_id"]
        supplier_employee_name                                             <- map["supplier_employee_name"]
        source_of_supply_name                                             <- map["source_of_supply_name"]
        supplier_name                                             <- map["supplier_name"]
        discount_amount                                             <- map["discount_amount"]
        discount_percent                                             <- map["discount_percent"]
        discount_type                                             <- map["discount_type"]
        vat                                             <- map["vat"]
        vat_amount                                             <- map["vat_amount"]
        total_amount                                             <- map["total_amount"]
        total_material                                             <- map["total_material"]
        payment_status                                             <- map["payment_status"]
        type                                             <- map["type"]
        status                                             <- map["status"]
        is_include_vat                                             <- map["is_include_vat"]
        payment_date                                             <- map["payment_date"]
        delivery_date                                             <- map["delivery_date"]
        created_at                                             <- map["created_at"]
        updated_at                                             <- map["updated_at"]
        note                                             <- map["note"]
        is_deleted                                             <- map["is_deleted"]
    }
    
}
