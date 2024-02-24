//
//  SupplierBusiness.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

struct SupplierBusiness:Mappable {
    var id = 0
    var  name = ""
    var  prefix = ""
    var  phone = ""
    var  address = ""
    var  website = ""
    var  description = ""
    var  email = ""
    var  status = 0
    var  contacts = ""
    var  normalize_name = ""
    var  tax_code = ""
    var  city_id = 0
    var  city_name = ""
    var  district_id = 0
    var  district_name = ""
    var  ward_id = 0
    var  ward_name = ""
    var avatar = ""
    var information = ""
    var cover_photo = ""
    var name_supplier_bussiness_type = ""
    var supplier_business_type_id = [Int]()
    var supplier_bussiness_types = [TypeBusiness]()
    
    init?(map: Map) {
        
    }
    
    init(){
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        prefix <- map["prefix"]
        phone <- map["phone"]
        address <- map["address"]
        website <- map["website"]
        description <- map["description"]
        email <- map["email"]
        status <- map["status"]
        contacts <- map["contacts"]
        normalize_name <- map["normalize_name"]
        tax_code <- map["tax_code"]
        city_id <- map["city_id"]
        city_name <- map["city_name"]
        district_id <- map["district_id"]
        district_name <- map["district_name"]
        ward_id <- map["ward_id"]
        ward_name <- map["ward_name"]
        avatar <- map["avatar"]
        information <- map["information"]
        cover_photo <- map["cover_photo"]
        name_supplier_bussiness_type <- map["name_supplier_bussiness_type"]
        supplier_business_type_id <- map["supplier_bussiness_type_id"]
        supplier_bussiness_types <- map["supplier_bussiness_types"]
    }
    
}
