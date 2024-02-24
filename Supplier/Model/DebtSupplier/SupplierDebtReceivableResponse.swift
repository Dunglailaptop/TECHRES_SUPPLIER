//
//  SupplierDebtReceivableResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 06/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct SupplierDebtReceivableResponse: Mappable {
    var limit = 0
    var data = [SupplierDebtReceivable]()
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

struct SupplierDebtReceivable: Mappable{
    var id = 0
    var restaurant_id = -1
    var restaurant_avatar = ""
    var restaurant_name = ""
    var restaurant_brand_id = -1
    var restaurant_material_order_request_id = 0
    var supplier_order_request_id = 0
    var restaurant_brand_name = ""
    var branch_id = -1
    var branch_name = ""
    var supplier_id = 0
    var supplier_name = ""
    var supplier_phone = ""
    var code = ""
    var amount = 0
    var amount_reality = 0
    var total_material:Float = 1.0
    var discount_amount = 0
    var discount_percent:Float = 0.0
    var total_amount = 201880
    var payment_status = 0
    var delivery_at = ""
    var status = 0
    var created_at = ""
    var updated_at = ""
    var vat_amount = 0
    var vat:Float = 0.0
    var supplier_employee_delivering_name = ""
    var supplier_employee_delivering_avatar = ""
    var reason = ""
    var employee_complete_id = 0
    var employee_complete_full_name = ""
    var employee_cancel_id = 0
    var supplier_employee_cancel_id = 0
    var employee_cancel_full_name = ""
    var supplier_employee_cancel_full_name = ""
    var employee_created_id = 0
    var supplier_employee_created_id = 0
    var employee_created_full_name = ""
    var supplier_employee_created_full_name = ""
    var total_amount_reality = 0
    var restaurant_debt_amount = 0
    var received_at = ""
    var supplier_order_detail:[SupplierOrdersDetailResponse] = []
    var isSelected = DEACTIVE
    var total_return = 0
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id <- map["id"]
        restaurant_id <- map["restaurant_id"]
        restaurant_avatar <- map["restaurant_avatar"]
        restaurant_name <- map["restaurant_name"]
        restaurant_brand_id <- map["restaurant_brand_id"]
        restaurant_material_order_request_id <- map["restaurant_material_order_request_id"]
        supplier_order_request_id <- map["supplier_order_request_id"]
        restaurant_brand_name <- map["restaurant_brand_name"]
        branch_id <- map["branch_id"]
        branch_name <- map["branch_name"]
        supplier_id <- map["supplier_id"]
        supplier_name <- map["supplier_name"]
        supplier_phone <- map["supplier_phone"]
        code <- map["code"]
        amount <- map["amount"]
        amount_reality <- map["amount_reality"]
        total_material <- map["total_material"]
        discount_amount <- map["discount_amount"]
        discount_percent <- map["discount_percent"]
        total_amount <- map["total_amount"]
        payment_status <- map["payment_status"]
        delivery_at <- map["delivery_at"]
        status <- map["status"]
        created_at <- map["created_at"]
        updated_at <- map["updated_at"]
        vat_amount <- map["vat_amount"]
        vat <- map["vat"]
        supplier_employee_delivering_name <- map["supplier_employee_delivering_name"]
        supplier_employee_delivering_avatar <- map["supplier_employee_delivering_avatar"]
        reason <- map["reason"]
        employee_complete_id <- map["employee_complete_id"]
        employee_complete_full_name <- map["employee_complete_full_name"]
        employee_cancel_id <- map["employee_cancel_id"]
        supplier_employee_cancel_id <- map["supplier_employee_cancel_id"]
        employee_cancel_full_name <- map["employee_cancel_full_name"]
        supplier_employee_cancel_full_name <- map["supplier_employee_cancel_full_name"]
        employee_created_id <- map["employee_created_id"]
        supplier_employee_created_id <- map["supplier_employee_created_id"]
        employee_created_full_name <- map["employee_created_full_name"]
        supplier_employee_created_full_name <- map["supplier_employee_created_full_name"]
        total_amount_reality <- map["total_amount_reality"]
        restaurant_debt_amount <- map["restaurant_debt_amount"]
        received_at <- map["received_at"]
        supplier_order_detail <- map["supplier_order_detail"]
    }
    
}

//
//struct SupplierDebtReceivableDetail: Mappable{
//    var id = 0
//    var supplier_material_id = 0
//    var supplier_material_name = ""
//    var supplier_unit_name = ""
//    var supplier_unit_specification_exchange_value = 0
//    var supplier_unit_specification_exchange_name = ""
//    var supplier_order_id = 0
//    var quantity:Float = 0.0
//    var total_quantity:Float = 0.0
//    var accept_quantity:Float = 0.0
//    var return_quantity:Float = 0.0
//    var remain_quantity:Float = 0.0
//
//    var response_quantity:Float = 0.0
//    var request_quantity:Float = 0.0
//    var price = 0.0
//    var total_price:Float = 0.0
//    var price_reality = 0
//    var total_price_reality = 0
//      
//    init?(map: Map) {
//    }
//    
//    init(){}
//
//    
//    mutating func mapping(map: Map) {
//        id <- map["id"]
//        supplier_material_id <- map["supplier_material_id"]
//        supplier_material_name <- map["supplier_material_id"]
//        supplier_unit_name <- map["supplier_unit_name"]
//        supplier_unit_specification_exchange_value <- map["supplier_unit_specification_exchange_value"]
//        supplier_unit_specification_exchange_name <- map["supplier_unit_specification_exchange_name"]
//        supplier_order_id <- map["supplier_order_id"]
//        quantity <- map["quantity"]
//        total_quantity <- map["total_quantity"]
//        accept_quantity <- map["accept_quantity"]
//        return_quantity <- map["return_quantity"]
//        remain_quantity <- map["remain_quantity"]
//        total_price <- map["total_price"]
//        response_quantity <- map["response_quantity"]
//        request_quantity <- map["request_quantity"]
//        price <- map["price"]
//        price_reality <- map["price_reality"]
//        total_price_reality <- map["total_price_reality"]
//    }
//    
//}
//
