//
//  DetailPendingOrder+Extension+InputQuantity.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DialogChooseInputViewController: InputQuantityDelegate{
    func presentModalInputQuantityViewController(number: Float) {
            let dialogInputQuantityViewController = DialogInputQuantityViewController()
            dialogInputQuantityViewController.maxQuantity = 100
            dialogInputQuantityViewController.current_quantity = number
            dialogInputQuantityViewController.lblTitle = "NHẬP PHẦN TRĂM GIẢM GIÁ"
            dialogInputQuantityViewController.delegate = self
            dialogInputQuantityViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputQuantityViewController)
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
    
    func callbackInputQuantity(number: Float, position: Int) {
        let totalAmount = viewModel.total_amount.value
        
        let discountAmount = totalAmount * Int(number) / 100
        
        if number == 0{
            self.viewModel.discount_amount.accept(discountAmount)
        }else{
            self.viewModel.discount_percent.accept(number)
            self.viewModel.discount_amount_display.accept(discountAmount)
        }
        self.txt_percent.text = String(Int(number))
    }
}
