//
//  Notification.swift
//  TECHRES-SUPPLIER
//
//  Created by Kelvin on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct Notification: Mappable {

    var _id = ""
    var employee_id = 0
    var name = ""
    var avatar  = ""
    var title = ""
    var content = ""
    var value = 0
    var type = ""
    var action_type = 0
    var is_viewed = 0
    var created_at = ""
    
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        _id              <- map["_id"]
        employee_id      <- map["employee_id"]
        name             <- map["name"]
        avatar           <- map["avatar"]
        title            <- map["title"]
        content          <- map["content"]
        value            <- map["value"]
        type             <- map["type"]
        action_type      <- map["action_type"]
        is_viewed        <- map["is_viewed"]
        created_at       <- map["created_at"]
    }
    
}
