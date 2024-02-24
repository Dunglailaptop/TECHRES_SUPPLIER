//
//  AccountViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit
import LocalAuthentication

extension AccountViewController: DialogConfirmDelegate{
    
     func prensentDialogConfirm(){
         let dialogConfirm = DialogConfirmViewController()
         dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
         dialogConfirm.dialog_type = dialogConfirm.CONFIRM_DIALOG
         dialogConfirm.dialogWidth = 300
         dialogConfirm.dialogHeight = 180
         dialogConfirm.dialogConfirmDelegate = self
         dialogConfirm.dialog_title =  "THÔNG BÁO"
         dialogConfirm.dialog_content = "BẠN CÓ MUỐN ĐĂNG XUẤT"
         let nav = UINavigationController(rootViewController: dialogConfirm)
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
     
     func callBackToConfirm() {
         viewModel.makeLoginViewController()
     }
     
}
extension AccountViewController {
    
    @IBAction func action_switch_setting(_ sender: Any) {
        setLogin(switch_setting_login: switch_setting_account)
    }
    
    private func setLogin(switch_setting_login: UISwitch){
        switch_setting_login.isOn == true ? ManageCacheObject.setBiometric(String(ACTIVE)) : ManageCacheObject.setBiometric(String(DEACTIVE))
        beginFaceID(switch_setting_login: switch_setting_login)
     }
     
    private func beginFaceID(switch_setting_login: UISwitch) {

        guard #available(iOS 8.0, *) else {return print("Not supported")}
        var context = LAContext()
        var err: NSError?
        
        if(Int(ManageCacheObject.getBiometric()) == ACTIVE){
            guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &err) else {
                if context.biometryType == .faceID{
                    if #available(iOS 13.0, *){
                        let alert = UIAlertController(title: "ORDER muốn truy cập Face id của thiết bị", message: nil, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Từ chối", style: .cancel){ _ in
                            ManageCacheObject.setBiometric(String(DEACTIVE))
                            switch_setting_login.setOn(false, animated: true)
                        }
                        let settingAction = UIAlertAction(title: "Mở Cài Đặt", style: .default){ UIAlertAction in
                            if let url = URL(string: UIApplication.openSettingsURLString){
                                UIApplication.shared.open(url,options: [:],completionHandler: { _ in
                                })
                            }
                        }
                        alert.addAction(cancelAction)
                        alert.addAction(settingAction)
                        self.present(alert, animated: true,completion: nil)
                    }else {}
                }else {
                    if #available(iOS 13, *){
                        let alert = UIAlertController(title: "ORDER muốn truy cập camera của thiết bị", message: nil, preferredStyle: .alert)
                        let cancelAction = UIAlertAction(title: "Từ chối", style: .cancel, handler: { _ in
                            dLog("Không được truy cập vào camera")
                        })
                        let settingAction = UIAlertAction(title: "Mở cài dặt", style: .default, handler: { _ in
                            dLog("được phép truy cập")
                        })
                        alert.addAction(cancelAction)
                        alert.addAction(settingAction)
                        self.present(alert, animated: true,completion: nil)
                    }else {}
                    
                }
                return
            }
         }

      }
     
     
}
