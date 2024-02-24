//
//  DetailPendingOrderInventory+Extension+InputQuantity.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DialogChooseInputInventoryViewController: InputQuantityDelegate{
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
        let cloneDataArray = self.viewModel.dataArray.value
        var totalAmount:Double = 0.00
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].price) * cloneDataArray[index].total_import_quantity
        }
        
        let discountAmount = totalAmount * Double(number) / 100
        let totalAfter = totalAmount - discountAmount
        self.viewModel.total_amount.accept(Int(totalAfter))
        
        if number == 0{
            self.viewModel.discount_amount.accept(Int(discountAmount))
        }else{
            self.viewModel.discount_percent.accept(Int(number))
            self.viewModel.discount_amount_display.accept(Int(discountAmount))
        }
        self.txt_percent.text = String(Int(number)) + "%"
    }
}
