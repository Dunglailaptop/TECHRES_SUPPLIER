//
//  DialogChangePasswordEmployeeViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import JonAlert
import RxCocoa
import ObjectMapper

extension DialogChangePasswordEmployeeViewController {
    func ResetEmployee(){
        viewModel.resetPassword().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataResponse = Mapper<Account>().map(JSONObject: response.data) {
                    self.delegate?.callBackResetPasswordEmployee(Employee: dataResponse)
                    dLog(dataResponse)
//                    self.dismiss(animated: true)
                }
        
            }else{
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
         
        }).disposed(by: rxbag)
    }
}


