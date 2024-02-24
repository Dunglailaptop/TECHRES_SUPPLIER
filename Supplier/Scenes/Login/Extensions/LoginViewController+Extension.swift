//
//  LoginViewController+Extension.swift
//  Seemt
//
//  Created by Kelvin on 07/04/2023.
//

import UIKit
import RxSwift
import RxRelay
import ObjectMapper

extension LoginViewController {
    
    func getSessions(){
        viewModel.getSessions().subscribe(onNext: { (response) in
            dLog(response.toJSON())
          
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response)
                self.sessions_str = response.data as! String
               
                // call api getConfig here...
                self.getConfig()
            }else{
               
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
          
          
        }).disposed(by: rxbag)
        
    }
    
        func getConfig(){
            viewModel.getConfig().subscribe(onNext: { (response) in
                dLog(response.toJSON())
              
                if(response.code == RRHTTPStatusCode.ok.rawValue){
                    if let config  = Mapper<Config>().map(JSONObject: response.data){
                        var obj_config = config
                        let basic_token = String(format: "%@:%@", self.sessions_str, obj_config.api_key)
                        obj_config.api_key = basic_token
                        ManageCacheObject.setConfig(obj_config)
                        
                        self.login()
                    }
                }else{
                    Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
                }
              
              
            }).disposed(by: rxbag)
            
        }
    func regisDevice(){
        
        viewModel.registerDeviceUDID().subscribe(onNext: { (response) in
            dLog(response.toJSON())
          
            if(response.code == RRHTTPStatusCode.ok.rawValue){
              
            }
          
          
        }).disposed(by: rxbag)
    }
    func login(){
        // Get data from Server
        viewModel.login().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog("Login Success...")
                dLog(response.toJSON())
                if let account  = Mapper<Account>().map(JSONObject: response.data){
                    ManageCacheObject.saveCurrentUser(account)
                    ManageCacheObject.setUsername(account.phone)
                    
                    ManageCacheObject.setPassword(self.text_field_password.text!)
                    
                    self.loadMainView()
                    
                    // lấy cấu hình của nhà cung cấp trước khi bắt đầu gọi các api logic khác
//                    self.getSetting()
                    
                    // đăng ký token để nhận notification trước khi login hệ thống
                    self.regisDevice()
                }
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
//                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
         
        }).disposed(by: rxbag)
    }
    //MARK: -- getSetting
    func getSetting(){
        // Get data from Server
        viewModel.setting().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog("Get Setting Success...")
                if let setting  = Mapper<Setting>().map(JSONObject: response.data){
                    dLog(setting.toJSON())
                    ManageCacheObject.setSetting(setting)
                    self.loadMainView()
                }
            }else{
                dLog(response.data)
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
         
        }).disposed(by: rxbag)
    }
    
}
