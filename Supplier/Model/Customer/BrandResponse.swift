//
//  BrandRestaurant.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//



import UIKit
import ObjectMapper


struct BrandResponse: Mappable{
    var limit = 0
    var list = [Brand]()
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
struct Brand: Mappable {
    var id = -1
    var status = 0
    var restaurant_id = 0
    var supplier_id = 0
    var name = ""
    var phone = ""
    var logo_url = ""
    var banner = ""
    var website = ""
    var facebook_page = ""
    var description = ""
    var service_restaurant_level_id = 0
    var service_restaurant_level_type = 0
    var service_change_each_bill_rice = 0
    
    init(){}
    
    init(id:Int, restaurant_id:Int,name:String){
        self.id = id
        self.restaurant_id = restaurant_id
        self.name = name
    }
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
         id <- map["id"]
        status <- map["status"]
        restaurant_id <- map["restaurant_id"]
        supplier_id <- map["supplier_id"]
        name <- map["name"]
        phone <- map["phone"]
        logo_url <- map["logo_url"]
        banner <- map["banner"]
        website <- map["website"]
        facebook_page <- map["facebook_page"]
        description <- map["description"]
        service_restaurant_level_id <- map["service_restaurant_level_id"]
        service_restaurant_level_type <- map["service_restaurant_level_type"]
        service_change_each_bill_rice <- map["service_change_each_bill_rice"]
    
    }
}
