//
//  EnterOTPViewController + Extension.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert
import ObjectMapper
extension EnterOTPViewController {
    func verifyCode() {
        viewModel.verifyCode().subscribe(onNext:{[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                viewModel.makeUpdatePasswordViewController()
            }else{
               
                OTP_text_field_view.initializeUI()
                OTP_text_field_view.isUserInteractionEnabled = false
                errorCounter -= 1
                var timeToUnEnableOPTEnterView = viewModel.timeToLockOPTEnterView.value
                timeToUnEnableOPTEnterView += 3*(5 - errorCounter)
                viewModel.timeToLockOPTEnterView.accept(timeToUnEnableOPTEnterView)
                JonAlert.show(
                    message: String(format: "Bạn còn %d lần nhập OTP", errorCounter),
                    andIcon: UIImage(named: Constants.WARNING_MESSAGE.ICON_WARNING),
                    duration: 2.0)
                if(errorCounter == 0){
                    viewModel.makeLoginViewController()
                }
                Toast.show(message: response.message ?? "", controller: self)
               
            }
        }).disposed(by: rxbag)
    }
    
    
    
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
                if let config = Mapper<Config>().map(JSONObject: response.data){
                    var obj_config = config
                    var basic_token = String(format: "%@:%@", self!.viewModel.sessionString.value, obj_config.api_key)
                    obj_config.api_key = basic_token
                    ManageCacheObject.setConfig(obj_config)
                    self!.errorCounter = 5
                    self!.forgotPassword()
                }
            }else {
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")


            }
            
        }).disposed(by: rxbag)
    }
    
    
    
    func forgotPassword(){
        viewModel.forgotPassword().subscribe(onNext: {[self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                setOTPCountDown()
            }else {
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
        }).disposed(by: rxbag)
    }
}
