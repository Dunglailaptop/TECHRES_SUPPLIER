//
//  ItemsManagementViewController + Extension + popup.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension ItemsManagementViewController: DialogConfirmDelegate{
    func prensentDialogConfirm(content:String){
         let dialogConfirm = DialogConfirmViewController()
         dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
         dialogConfirm.dialog_type = dialogConfirm.CONFIRM_DIALOG
         dialogConfirm.dialogWidth = 300
         dialogConfirm.dialogHeight = 180
         dialogConfirm.dialogConfirmDelegate = self
         dialogConfirm.dialog_title = "THÔNG BÁO"
         dialogConfirm.dialog_content = content
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
         viewModel.closure.value()
     }
    
    
    func prensentDialogNotify(content:String,materialStatus:[MaterialStatus]){
        let dialog = DialogShowUsingItemViewController()
        dialog.content = content
        dialog.dataArray.accept(materialStatus)
        dialog.view.backgroundColor = ColorUtils.blackTransparent()

        let nav = UINavigationController(rootViewController: dialog)
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
