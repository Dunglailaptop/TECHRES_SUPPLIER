//
//  Setting.swift
//  Techres-Seemt
//
//  Created by Macbook-M1-007 on 09/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct Setting: Mappable {
    var is_working_offline: Int = 0
    var branch_type: Int = 0
    var is_enable_tms: Int = 0
    var branch_type_name: String = ""
    var open_time: String?
    var close_Time: String = ""
    var hour_to_take_report: Int = 3
    var api_prefix_path_for_branch_type: String = ""
    var service_restaurant_level_id = 0
    var min_distance_checkin: Double = 0
    var is_enable_booking: Int = 0
    var lat: String = "0.0"
    var lng: String = "0.0"
    
      
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        is_working_offline              <- map["is_working_offline"]
        branch_type       <- map["branch_type"]
        is_enable_tms       <- map["is_enable_tms"]
        branch_type_name       <- map["branch_type_name"]
        open_time       <- map["open_time"]
        close_Time              <- map["close_Time"]
        hour_to_take_report              <- map["hour_to_take_report"]
        api_prefix_path_for_branch_type       <- map["api_prefix_path_for_branch_type"]
        service_restaurant_level_id <- map["service_restaurant_level_id"]
        lat       <- map["lat"]
        lng       <- map["lng"]
        min_distance_checkin       <- map["min_distance_checkin"]
        is_enable_booking <- map["is_enable_booking"]
    }
}
