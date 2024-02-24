//
//  InventoryReport.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct InventoryReport: Mappable {
    var total_inventory_first = 0
    var total_import = 0
    var total_export = 0
    var total_cancel = 0
    var total_inventory_now = 0
    var total_inventory_first_amount = 0
    var total_import_amount = 0
    var total_export_amount = 0
    var total_cancel_amount = 0
    var total_inventory_now_amount = 0

    init() {}

    init?(map:Map) {
    }

    mutating func mapping(map:Map){
        total_inventory_first <- map["total_inventory_first"]
        total_import <- map["total_import"]
        total_export <- map["total_export"]
        total_cancel <- map["total_cancel"]
        total_inventory_now <- map["total_inventory_now"]
        total_inventory_first_amount <- map["total_inventory_first_amount"]
        total_import_amount <- map["total_import_amount"]
        total_export_amount <- map["total_export_amount"]
        total_cancel_amount <- map["total_cancel_amount"]
        total_inventory_now_amount <- map["total_inventory_now_amount"]
    }
}
