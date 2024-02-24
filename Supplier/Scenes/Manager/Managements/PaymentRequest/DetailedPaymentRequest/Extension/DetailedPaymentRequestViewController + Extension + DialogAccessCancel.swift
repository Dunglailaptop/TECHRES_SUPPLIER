//
//  DetailedPaymentRequestViewController + Extension + DialogAccessCancel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 28/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DetailedPaymentRequestViewController:DialogAccessCancelSupplierDetailedPayment  {
    func prensentDialogConfirm(id:Int, status:Int){
        let dialogConfirm = DialogAccessCancelDetailedPaymentViewController()
        dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirm.noteid = id
        dialogConfirm.status = status
        dialogConfirm.delegate = self
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
    
    func callBackCancelDetailedPayment(id:Int,status:Int) {
        viewModel.noteId.accept(id)
        viewModel.status.accept(status)
        getSupplierDebtPaymentUpdate()
        dismiss(animated: true)
    }
}
