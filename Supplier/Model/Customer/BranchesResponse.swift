//
//  RestaurantDetail.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct BranchesResponse: Mappable{
    var limit = 0
    var list = [Branches]()
    var total_record = 0
    
    init() {}
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        limit <- map["limit"]
        list <- map["list"]
        total_record <- map["total_record"]
    }
}
struct Branches: Mappable {
   var id = -1
    var restaurant_id = 0
    var restaurant_brand_id = 0
    var name = ""
    var street_name = ""
    var country_name = ""
    var country_id = 0
    var city_id = 0
    var district_id = 0
    var ward_id = 0
    var address_full_text = ""
    var address_note = ""
    var phone_number = ""
    var  lat = ""
    var lng = ""
    var enable_checkin = ""
    var  qr_code_checkin = ""
    var  image_logo_url = ""
    var  banner_image_url = ""
    
    init() {}
    
    init(id:Int, restaurant_id:Int,restaurant_brand_id:Int,name:String) {
        self.id = id
        self.restaurant_id = restaurant_id
        self.restaurant_brand_id = restaurant_brand_id
        self.name = name
    }
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         id <- map["id"]
          restaurant_id <- map["restaurant_id"]
          restaurant_brand_id <- map["restaurant_brand_id"]
          name <- map["name"]
          street_name <- map["street_name"]
         country_name <- map["country_name"]
          country_id <- map["country_id"]
          city_id <- map["city_id"]
         district_id <- map["district_id"]
          ward_id <- map["ward_id"]
         address_full_text <- map["address_full_text"]
         address_note <- map["address_note"]
          phone_number <- map["phone_number"]
          lat <- map["lat"]
         lng <- map["lng"]
         enable_checkin <- map["enable_checkin"]
          qr_code_checkin <- map["qr_code_checkin"]
          image_logo_url <- map["image_logo_url"]
          banner_image_url <- map["banner_image_url"]
    }
}
