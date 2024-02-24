//
//  SupplierOrdersResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierOrdersResponse: Mappable {
    var limit = 0
    var data = [SupplierOrders]()
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

struct SupplierOrders: Mappable{
    var id = 0
    var amount = 0
    var amount_reality = 0
    var branch_name = ""
    var code = ""
    var created_at = ""
    var delivery_at = ""
    var discount_amount = 0
    var discount_percent = 0.00
    var employee_cancel_full_name = ""
    var employee_complete_full_name = ""
    var employee_created_full_name = ""
    var payment_status = 0
    var reason = ""
    var received_at = ""
    var restaurant_brand_name = ""
    var restaurant_name = ""
    var restaurant_email = ""
    var restaurant_phone = ""
    var restaurant_logo = ""
    var restaurant_address = ""
    var restaurant_id = 0
    var restaurant_debt_amount = 0
    var status = 0
    var supplier_avatar = ""
    var supplier_name = ""
    var supplier_phone = ""
    var supplier_employee_cancel_full_name = ""
    var supplier_employee_created_full_name = ""
    var supplier_employee_delivering_avatar = ""
    var supplier_employee_delivering_name = ""
    var total_order = 0
    var total_amount = 0
    var total_amount_of_return_material_reality = 0
    var total_amount_reality = 0
    var total_material = 0
    var vat = 0.00
    var vat_amount = 0
    var supplier_order_detail = [SupplierOrderDetail]()
    
      
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id                                             <- map["id"]
        amount                                             <- map["amount"]
        amount_reality                                             <- map["amount_reality"]
        branch_name                                             <- map["branch_name"]
        code                                             <- map["code"]
        created_at                                             <- map["created_at"]
        delivery_at                                             <- map["delivery_at"]
        discount_amount                                             <- map["discount_amount"]
        discount_percent                                             <- map["discount_percent"]
        employee_cancel_full_name                                             <- map["employee_cancel_full_name"]
        employee_complete_full_name                                             <- map["employee_complete_full_name"]
        employee_created_full_name                                             <- map["employee_created_full_name"]
        payment_status                                             <- map["payment_status"]
        reason                                             <- map["reason"]
        received_at                                             <- map["received_at"]
        restaurant_brand_name                                             <- map["restaurant_brand_name"]
        restaurant_name                                             <- map["restaurant_name"]
        restaurant_email                                             <- map["restaurant_email"]
        restaurant_phone                                             <- map["restaurant_phone"]
        restaurant_logo                                             <- map["restaurant_logo"]
        restaurant_address                                             <- map["restaurant_address"]
        restaurant_id                                             <- map["restaurant_id"]
        restaurant_debt_amount                                             <- map["restaurant_debt_amount"]
        status                                             <- map["status"]
        supplier_avatar                                             <- map["supplier_avatar"]
        supplier_name                                             <- map["supplier_name"]
        supplier_phone                                             <- map["supplier_phone"]
        supplier_employee_cancel_full_name                                             <- map["supplier_employee_cancel_full_name"]
        supplier_employee_created_full_name                                             <- map["supplier_employee_created_full_name"]
        supplier_employee_delivering_avatar                                             <- map["supplier_employee_delivering_avatar"]
        supplier_employee_delivering_name                                             <- map["supplier_employee_delivering_name"]
        total_order                                             <- map["total_order"]
        total_amount                                             <- map["total_amount"]
        total_amount_of_return_material_reality                                             <- map["total_amount_of_return_material_reality"]
        total_amount_reality                                             <- map["total_amount_reality"]
        total_material                                             <- map["total_material"]
        vat                                             <- map["vat"]
        vat_amount                                             <- map["vat_amount"]
        supplier_order_detail                                             <- map["supplier_order_detail"]
    }
    
}

struct SupplierOrderDetail: Mappable {
    var id = 0
    var quantity = 0
    var supplier_material_id = 0
    var supplier_order_request_id = 0
    var supplier_material_name = ""
    var supplier_unit_name = ""
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        id                  <- map["id"]
        quantity                    <- map["quantity"]
        supplier_material_id                    <- map["supplier_material_id"]
        supplier_order_request_id                   <- map["supplier_order_request_id"]
        supplier_material_name                  <- map["supplier_material_name"]
        supplier_unit_name                  <- map["supplier_unit_name"]
    }
}
