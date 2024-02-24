//
//  CategoryReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct CategoryReport: Mappable {
    var total_record = 0
    var export_quantity:Float = 0.0
    var import_quantity:Float = 0.0
    var return_quantity:Float = 0.0
    var cancel_quantity:Float = 0.0
    var remaining_quantity:Float = 0.0
    var total_import_amount = 0
    var total_export_amount = 0
    var total_return_amount = 0
    var total_cancel_amount = 0
    var total_remaining_amount = 0
//    var list_data = []
    
    init() {}
    
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        total_record <- map["total_record"]
        export_quantity <- map["export_quantity"]
        import_quantity <- map["import_quantity"]
        return_quantity <- map["textFileGroupName"]
        cancel_quantity <- map["cancel_quantity"]
        remaining_quantity <- map["remaining_quantity"]
        total_import_amount <- map["total_import_amount"]
        total_export_amount <- map["total_export_amount"]
        total_return_amount <- map["total_return_amount"]
        total_cancel_amount <- map["total_cancel_amount"]
        total_remaining_amount <- map["total_remaining_amount"]
//        list_data <- map["list_data"]
    }
}
