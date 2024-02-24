//
//  NotificationResponse.swift
//  TECHRES-SUPPLIER
//
//  Created by Kelvin on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper


struct NotificationResponse: Mappable {
    var limit = 0
    var total_record = 0
    var list = [Notification]()
    
    init?(map: Map) {}
    init?(){}
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        total_record <- map["total_record"]
        list <- map["list"]
    }
    
}
