//
//  ForgotPasswordViewController + Extension.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 01/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert
import ObjectMapper
extension ForgotPasswordViewController{
    
    
    func getSession(){
        viewModel.getSession().subscribe(onNext: {[weak self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                self!.viewModel.sessionString.accept(response.data as! String)
                self!.getConfig()
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
            
        }).disposed(by: rxbag)
    }
    
    
    func getConfig(){
        viewModel.getConfig().subscribe(onNext: {[weak self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response.toJSON())
                if let config = Mapper<Config>().map(JSONObject: response.data){
                    var obj_config = config
                    var basic_token = String(format: "%@:%@", self!.viewModel.sessionString.value, obj_config.api_key)
                    obj_config.api_key = basic_token
                    ManageCacheObject.setConfig(obj_config)
                    // call api login here...
                    self!.forgotPassword()
                }
            }else {
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self!)


            }
            
        }).disposed(by: rxbag)
    }
    
    
    
    func forgotPassword(){
        viewModel.forgotPassword().subscribe(onNext: {[weak self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                self!.viewModel.makeEnterOTPViewController()
            }else {
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self!)

            }
        }).disposed(by: rxbag)
    }
}
