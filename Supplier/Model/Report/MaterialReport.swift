//
//  MaterialReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
struct MaterialReport: Mappable {
    var report_type = 0
    var date_string = ""
     
    var total_record = 0
    var export_quantity = 0
    var import_quantity = 0
    var return_quantity = 0
    var cancel_quantity = 0
    var remaining_quantity = 0.0
    var total_import_amount = 0
    var total_export_amount = 0
    var total_return_amount = 0
    var total_cancel_amount = 0
    var total_remaining_amount = 0
    var data:[MaterialReportData] = []
    
    init() {}
    
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        total_record <- map["total_record"]
        export_quantity <- map["export_quantity"]
        import_quantity <- map["import_quantity"]
        return_quantity <- map["return_quantity"]
        cancel_quantity <- map["cancel_quantity"]
        remaining_quantity <- map["remaining_quantity"]
        total_import_amount <- map["total_import_amount"]
        total_export_amount <- map["total_export_amount"]
        total_return_amount <- map["total_return_amount"]
        total_cancel_amount <- map["total_cancel_amount"]
        total_remaining_amount <- map["total_remaining_amount"]
        data <- map["data"]
    }
}

struct MaterialReportData: Mappable {
    var supplier_material_id = 0
    var supplier_id = 0
    var material_category_id = 0
    var material_category_name = ""
    var supplier_material_name = ""
    var supplier_material_code = ""
    var unit_full_name = ""
    var total_import = 0
    var total_export = 0
    var total_return = 0
    var total_cancel = 0
    var quantity_export = 0
    var quantity_import = 0
    var quantity_return = 0
    var quantity_cancel = 0
    var quantity_remaining = 0
    var total_remaining = 0
    
    init() {}
    
    init?(map:Map) {
    }
    
    mutating func mapping(map:Map){
        supplier_material_id <- map["supplier_material_id"]
        supplier_id <- map["supplier_id"]
        material_category_id <- map["material_category_id"]
        material_category_name <- map["material_category_name"]
        supplier_material_name <- map["supplier_material_name"]
        supplier_material_code <- map["supplier_material_code"]
        unit_full_name <- map["unit_full_name"]
        total_import <- map["total_import"]
        total_export <- map["total_export"]
        total_return <- map["total_return"]
        total_cancel <- map["total_cancel"]
        quantity_export <- map["quantity_export"]
        quantity_import <- map["quantity_import"]
        quantity_return <- map["quantity_return"]
        quantity_cancel <- map["quantity_cancel"]
        quantity_remaining <- map["quantity_remaining"]
        total_remaining <- map["total_remaining"]
    }
}


