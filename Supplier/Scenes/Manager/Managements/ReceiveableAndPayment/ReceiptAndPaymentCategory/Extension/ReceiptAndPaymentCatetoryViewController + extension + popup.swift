//
//  ReceiptAndPaymentCatetoryViewController + extension + popup.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 16/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
extension ReceiptAndPaymentCatetoryViewController: DialogConfirmDelegate,ReceiptAndPaymentCatetoryDelegate{
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
    
    
    
    func callBackToShowDialogConfirm(content:String) {
        self.prensentDialogConfirm(content: content)
    }
     
     func callBackToConfirm() {
         viewModel.closure.value()
     }
}
