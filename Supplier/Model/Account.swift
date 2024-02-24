//
//  Account.swift
//  Supplier
//
//  Created by kelvin on 12/07/2023.
//

import UIKit
import ObjectMapper

struct Account: Mappable {
    var id = 0
    var access_token=""
    var refresh_token = ""
    var expires_in = 0
    var branch_type = 0
    var avatar=""
    var branch_id=0
    var email=""
    var employee_id=0
    var employee_role=0
    var employee_role_id = 0
    var employee_role_name=""
    var employee_role_description = ""
    var name = ""
    var birthday = ""
    var phone_number=""
    var restaurant_name=""
    var restaurant_domain_name=""
    var restaurant_id=0
    var token_type=""
    var username=""
    var password=""
    var header = ""
    var branch_name = ""
    var permissions = [String]()
    var prefix = ""
    var role_name = ""
    var normalize_name = ""
    var isSelect = 0
    var gender = 0
    var working_session_id = 0
    var working_session_time = ""
    var working_session_name = ""
    var address = ""
    var employee_rank_id = 0
    var employee_rank_name = ""
    var restaurant_brand_id = 0
    var jwt_token = ""
    var phone = ""
    
    var status = 0
    var is_working = 0
    //========== Chat =========
    var node_id = ""
    var node_access_token = ""
    var currentChatId = ""
    //========== Supplier =====
    var supplier_employee_position = ""
    var identify_name = ""
    //=========
    var is_reset_pasword = 0
    
    init() {}
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map){
        id                                      <- map["id"]
        access_token                            <- map["access_token"]
        header                                  <- map["header"]
        refresh_token                           <- map["refresh_token"]
        avatar                                  <- map["avatar"]
        email                                   <- map["email"]
        name                                    <- map["name"]
        branch_id                               <- map["branch_id"]
        employee_id                             <- map["id"]
        employee_role                           <- map["employee_role"]
        employee_role_id                        <- map["employee_role_id"]
        employee_role_name                      <- map["supplier_role_name"]
        phone_number                            <- map["phone"]
        restaurant_id                           <- map["restaurant_id"]
        restaurant_name                         <- map["restaurant_name"]
        restaurant_domain_name                 <- map["restaurant_domain_name"]
        token_type                              <- map["token_type"]
        username                                <- map["username"]
        password                                <- map["password"]
        permissions                             <- map["permissions"]
        birthday                                <- map["birthday"]
        employee_role_description               <- map["employee_role_description"]
        expires_in                              <- map["expires_in"]
        branch_type                             <- map["branch_type"]
        branch_name                             <- map["branch_name"]
        prefix                                  <- map["prefix"]
        role_name                               <- map["role_name"]
        normalize_name                          <- map["normalize_name"]
        gender                                  <- map["gender"]
        working_session_id                      <- map["working_session_id"]
        working_session_time                    <- map["working_session_time"]
        working_session_name                    <- map["working_session_name"]
        address                                 <- map["address"]
        employee_rank_id                        <- map["employee_rank_id"]
        employee_rank_name                      <- map["employee_rank_name"]
        node_id                                 <- map["_id"]
        node_access_token                       <- map["node_access_token"]
        restaurant_brand_id                     <- map["restaurant_brand_id"]
        jwt_token <- map["jwt_token"]
        phone <- map["phone"]
        status <- map["status"] // Map status
        supplier_employee_position <- map["supplier_employee_position"]
        identify_name <- map["identify_name"]
        
        //reset password
        is_reset_pasword <- map["is_reset_pasword"]
    }
    
}
