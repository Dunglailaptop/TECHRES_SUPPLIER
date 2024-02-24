//
//  EmployeeData.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct EmployeeData: Mappable {
    var total_record = 0
    var employees = [Account]()
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        total_record              <- map["total_record"]
        employees       <- map["list"]
       
        
    }
}
