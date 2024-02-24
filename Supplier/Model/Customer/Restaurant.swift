//
//  Restaurant.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct RestaurantModel: Mappable {
    var limit = 0
    var list = [Restaurant]()
    var total_record = 0
    
    init(){
        
    }
    
    init(map: Map){
        
    }
    
    mutating func mapping(map: Map){
        limit <- map["limit"]
        list <- map["list"]
        total_record <- map["total_record"]
    }
        
    
    
}
struct Restaurant: Mappable{
    var address = ""
    var contact_name = ""
    var contactor_avatar = ""
    var email = ""
    var id = -1
    var info = ""
    var is_done_setup = 0
    var is_main_contactor = 0
    var is_public = 0
    var logo = ""
    var name = ""
    var number_branches = 0
    var phone = ""
    var restaurant_balance = 0
    var restaurant_name = ""
    var status = 0
    var tax_number = ""
    var total_delivering = 0
    var total_done = 0
    var total_order = 0
    var total_return = 0
    var total_waiting = 0
    var logo_url = ""
    var image_logo_url = ""
    var type = 0 //set loại 
    init(id:Int){
        self.id = id
    }
    
    init(){
        
    }
    
    init(map:Map){
        
    }
    
    mutating func mapping(map: Map) {
         address <- map["address"]
         contact_name <- map["contact_name"]
         contactor_avatar <- map["contactor_avatar"]
         email <- map["email"]
         id <- map["id"]
         info <- map["info"]
         is_done_setup <- map["is_done_setup"]
         is_main_contactor <- map["is_main_contactor"]
        is_public <- map["is_public"]
         logo <- map["logo"]
         name <- map["name"]
         number_branches <- map["number_branches"]
         phone <- map["phone"]
         restaurant_balance <- map["restaurant_balance"]
         restaurant_name <- map["restaurant_name"]
         status <- map["status"]
         tax_number <- map["tax_number"]
         total_delivering <- map["total_delivering"]
         total_done <- map["total_done"]
         total_order <- map["total_order"]
         total_return <- map["total_return"]
         total_waiting <- map["total_waiting"]
        logo_url <- map["logo_url"]
        image_logo_url <- map["image_logo_url"]
    }
}
