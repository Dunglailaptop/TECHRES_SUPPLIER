//
//  DetailEmployee.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 20/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import ObjectMapper

struct DetailEmployee: Mappable {
    var data = DetailProfileEmployee()
 
    init?(map: Map) {
    }
    init?() {
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
    }
}

struct DetailProfileEmployee: Mappable{
    var id = 0
    var name = ""
    var avatar = ""
    var username = ""
    var gender = 0
    var phone = ""
    var birthday = ""
    var email = ""
    var employee_role_name = ""
    var identity_card = ""
    var address_full_text = ""
    var restaurant_name = ""
    var restaurant_brand_name = ""
    var branch_name = ""
    var city_id = 0
    var city_name = ""
    var district_id = 0
    var district_name = ""
    var ward_id = 0
    var ward_name = ""
    var street_name = ""
    var address = ""

    var supplier_employee_position = ""
    var supplier_id = 0
    var supplier_role_id = 0
   
    
    
    init?(map: Map) {
    }
    
    init(){}

    
    mutating func mapping(map: Map) {
        id  <- map["id"]
        name  <-  map["name"]
        avatar  <-  map["avatar"]
        username <- map["username"]
        gender  <-  map["gender"]
        phone   <- map["phone"]
        birthday  <-  map["birthday"]
        email  <-  map["email"]
        employee_role_name  <-  map["employee_role_name"]
        identity_card  <-  map["identity_card"]
        address_full_text  <-  map["address_full_text"]
        restaurant_name  <-  map["restaurant_name"]
        restaurant_brand_name  <-  map["restaurant_brand_name"]
        branch_name  <-  map["branch_name"]
        city_id <- map["city_id"]
        city_name <- map["city_name"]
        district_id <- map["district_id"]
        district_name <- map["district_name"]
        ward_id <- map["ward_id"]
        ward_name <- map["ward_name"]
        street_name <- map["street_name"]
        address <- map["address"]
        supplier_employee_position <- map["supplier_employee_position"]
        supplier_id <- map["supplier_id"]
        supplier_role_id <- map["supplier_role_id"]
    }
}
