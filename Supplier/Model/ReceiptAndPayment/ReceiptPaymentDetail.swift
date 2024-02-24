////
////  Receipt.swift
////  TECHRES-SUPPLIER
////
////  Created by Pham Khanh Huy on 20/07/2023.
////  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
////
//
//import UIKit
//import ObjectMapper
//struct ReceiptPaymentDetail: Mappable {
//    var id = 0
//    var code = ""
//    var amount = 0
//    var created_at = ""
//    var type = 0
//    var note = ""
//    var status = 0
//    var object_type = 0
//    var supplier_employee_create_full_name = ""
//    var employee_cancel_full_name = ""
//    var supplier_addition_fee_reason_id = 0
//    var supplier_addition_fee_reason_name = ""
//    var fee_month = ""
//    var supplier_warehouse_session_ids:[Int] = []
//    var supplier_order_ids:[Int] = []
//    var supplier_warehouse_session_data:[WarehouseSession] = []
//
//    init() {}
//    init?(map:Map) {
//    }
//
//    mutating func mapping(map:Map){
//        id <- map["id"]
//        code <- map["code"]
//        amount <- map["amount"]
//        created_at <- map["created_at"]
//        type <- map["type"]
//        note <- map["note"]
//        status <- map["status"]
//        object_type <- map["object_type"]
//        supplier_employee_create_full_name <- map["supplier_employee_create_full_name"]
//        employee_cancel_full_name <- map["employee_cancel_full_name"]
//        supplier_addition_fee_reason_id <- map["supplier_addition_fee_reason_id"]
//        supplier_addition_fee_reason_name <- map["supplier_addition_fee_reason_name"]
//        fee_month <- map["fee_month"]
//        supplier_warehouse_session_ids <- map["supplier_warehouse_session_ids"]
//        supplier_order_ids <- map["supplier_order_ids"]
//        supplier_warehouse_session_data <- map["supplier_warehouse_session_data"]
//
//    }
//}
//
//
//struct WarehouseSession: Mappable {
//    var id = 0
//    var number = 0
//    var code = ""
//    var amount = 0.0
//    var total_amount = 0.0
//    var created_at = ""
//
//
//    init() {}
//    init?(map:Map) {
//    }
//
//    mutating func mapping(map:Map){
//        id <- map["id"]
//        number <- map["number"]
//        code <- map["code"]
//        amount <- map["amount"]
//        total_amount <- map["total_amount"]
//        created_at <- map["created_at"]
//    }
//}
//
