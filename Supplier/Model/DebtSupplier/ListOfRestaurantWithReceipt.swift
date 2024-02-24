//
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct ListOfRestaurantWithReceipt: Mappable {
    var limit = 0
    var data = [RestaurantWithReceipt]()
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

struct RestaurantWithReceipt: Mappable{
    var restaurant_id = -1
    var brand_id = -1
    var branch_id = -1
    var restaurant_name = ""
    var restaurant_email = ""
    var restaurant_phone = ""
    var restaurant_logo = ""
    var restaurant_address = ""
    var total_order = 0
    var total_amount:Double = 0.0
  
    
      
    init?(map: Map) {
    }
    
    init(){}
    
    mutating func mapping(map: Map) {
        restaurant_id                                             <- map["restaurant_id"]
        restaurant_name                                             <- map["restaurant_name"]
        restaurant_email                                             <- map["restaurant_email"]
        restaurant_phone                                             <- map["restaurant_phone"]
        restaurant_logo                                             <- map["restaurant_logo"]
        restaurant_address                                             <- map["restaurant_address"]
        total_order                                             <- map["total_order"]
        total_amount                                             <- map["total_amount"]
      
    }
    
}
