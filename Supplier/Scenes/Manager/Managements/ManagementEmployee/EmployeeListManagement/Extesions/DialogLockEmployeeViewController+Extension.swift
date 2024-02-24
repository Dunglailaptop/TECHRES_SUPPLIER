//
//  DialogLockEmployeeViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 18/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension DialogLockEmployeeViewController {
    func lockEmployee(){
        viewModel.lockEmployee().subscribe(onNext: { (response) in
            dLog(response.toJSON())
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                self.dismiss(animated: true)
                self.delegate?.callBackLockEmployee(position: self.position, lockId: self.idLock, type: 0, usernames: self.txtname_employee,note_noty: "Đã khóa tài khoản")
            }else{
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
         
        }).disposed(by: rxbag)
    }
    func unLockEmployee(){
        viewModel.unLockEmployee().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                self.dismiss(animated: true)
                self.delegate?.callBackLockEmployee(position: self.position, lockId: self.idLock, type: 0, usernames: self.txtname_employee,note_noty: "Đã mở khoá tài khoản")
            }else{
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
         
        }).disposed(by: rxbag)
    }
    
}
