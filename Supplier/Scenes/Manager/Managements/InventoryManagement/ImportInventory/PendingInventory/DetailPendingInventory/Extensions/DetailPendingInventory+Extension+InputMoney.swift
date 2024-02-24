//
//  DetailPendingOrder+Extension+InputMoney.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DetailPendingInventoryViewController: InputMoneyDelegate {
    func presentModalInputMoneyViewController(current_money: Int, position: Int) {
            let dialogInputMoneyViewController = DialogInputMoneyViewController()
            dialogInputMoneyViewController.minMoney = 100
            dialogInputMoneyViewController.maxMoney = 100000000
            dialogInputMoneyViewController.position = position
            dialogInputMoneyViewController.current_money = current_money
            dialogInputMoneyViewController.delegate = self
            dialogInputMoneyViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputMoneyViewController)
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
    
    func callBackInputMoney(amount: Int, position: Int) {
        var cloneDataArray = self.viewModel.dataArray.value
        let discountAmount = viewModel.discount_amount_display.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
        cloneDataArray[position].supplier_input_price = amount
        self.viewModel.dataArray.accept(cloneDataArray)
        
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].supplier_input_price) * Double(cloneDataArray[index].supplier_input_quantity)
        }
        
        if viewModel.discount_percent.value == 0 {
            totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = totalChange + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
        } else {
            discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100 // tính giảm giá theo %
            totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
        }
        
        lbl_total_price.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAmount))
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
    }
}
