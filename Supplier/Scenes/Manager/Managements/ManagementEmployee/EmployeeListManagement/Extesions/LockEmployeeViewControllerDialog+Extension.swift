//
//  LockEmployeeViewControllerDialog+Extension.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 18/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

extension EmployeeListManagementViewController: LockEmployeeDelegate {
    
    
    
    func callBackLockEmployee(position: Int, lockId:Int, type: Int,usernames:String,note_noty:String){
        viewModel.clearDataAndCallAPI()
        self.presentModalDialogChangePasswordEmployee(IdEmployeeResetPassword: lockId,type: type,username:usernames,note_noty: note_noty)
       
    }
    
    func presentModalDialogLockEmployee(position:Int, lockId:Int, type: Int) {
        let dialogLockEmployeeViewController = DialogLockEmployeeViewController()
        dialogLockEmployeeViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogLockEmployeeViewController.idLock = self.viewModel.dataArray.value[position].id
        dialogLockEmployeeViewController.txtname_employee = self.viewModel.dataArray.value[position].name
        dialogLockEmployeeViewController.position = position
        dialogLockEmployeeViewController.typeLockEmployee = type // Type phân biệt Khoá/Mở(khoá) tài khoản nhân viên
        dialogLockEmployeeViewController.delegate = self
        if(type == 1){
            dialogLockEmployeeViewController.lbl_text_warning_lock.text = "Bạn có muốn khóa tài khoản" // Type = 1: Khoá tài khoản nhân viên
            dialogLockEmployeeViewController.lb_notyAceess.text = "XÁC NHẬN KHOÁ TÀI KHOẢN"
        } else {
            dialogLockEmployeeViewController.lbl_text_warning_lock.text = "Bạn có muốn mở khóa tài khoản" // Type = 2: Mở khoá tài khoản nhân viên
            dialogLockEmployeeViewController.lb_notyAceess.text = "XÁC NHẬN MỞ KHOÁ TÀI KHOẢN"
            dLog(viewModel.dataArray.value[position].name)
        }
            let nav = UINavigationController(rootViewController: dialogLockEmployeeViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
   
            present(nav, animated: true, completion: nil)

    }

}
