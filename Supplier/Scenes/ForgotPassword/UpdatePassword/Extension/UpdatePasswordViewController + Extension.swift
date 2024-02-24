//
//  UpdatePasswordViewController + Extension.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 03/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import JonAlert
import RxSwift
import ObjectMapper
extension UpdatePasswordViewController{
    
    func getSession(){
        viewModel.getSession().subscribe(onNext: {[weak self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                self!.viewModel.sessionString.accept(response.data as! String)
                self!.getConfig()
            }else{
                JonAlert.showError(message: response.message ?? Constants.ERROR_MESSAGE.CALL_API_ERROR,duration: 2.0)
            }
            
        }).disposed(by: rxbag)
    }
    
    
    func getConfig(){
        viewModel.getConfig().subscribe(onNext: {[weak self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let config = Mapper<Config>().map(JSONObject: response.data){
                    var obj_config = config
                    let basic_token = String(format: "%@:%@", self!.viewModel.sessionString.value, obj_config.api_key)
                    obj_config.api_key = basic_token
                    ManageCacheObject.setConfig(obj_config)
                    // call api login here...
                    self!.updatePassword()
                }
            }else {
                JonAlert.showError(message: response.message ?? Constants.ERROR_MESSAGE.CALL_API_ERROR,duration: 2.0)
            }
            
        }).disposed(by: rxbag)
    }
    
    
    func updatePassword(){
        viewModel.updatePassword().subscribe(onNext: {[weak self] (res) in
            if (res.code == RRHTTPStatusCode.ok.rawValue){
                self!.viewModel.makeLoginViewController()
                JonAlert.showSuccess(message: "Cập nhật mật khẩu mới thành công", duration: 2.0)
            }else{
                dLog(res.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
        }).disposed(by: rxbag)
    }
}

