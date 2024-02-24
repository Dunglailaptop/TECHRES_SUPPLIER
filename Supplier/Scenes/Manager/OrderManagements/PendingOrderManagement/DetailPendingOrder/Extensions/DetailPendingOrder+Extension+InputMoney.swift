//
//  DetailPendingOrder+Extension+InputMoney.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DetailPendingOrderViewController: InputMoneyDelegate {
    func presentModalInputMoneyViewController(current_money: Int, position: Int) {
            let dialogInputMoneyViewController = DialogInputMoneyViewController()
            dialogInputMoneyViewController.minMoney = 100
            dialogInputMoneyViewController.maxMoney = 100000000
            dialogInputMoneyViewController.isEnterZeroMoney = true
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
        var totalAmount:Double = 0.00
        cloneDataArray[position].retail_price = amount
        self.viewModel.dataArray.accept(cloneDataArray)
        
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].retail_price) * cloneDataArray[index].supplier_quantity
        }
        
        let discountAmount = viewModel.discount_amount_display.value
        let discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100
        let totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá
        let vatAmount = Int(totalChange) * Int(viewModel.vat.value) / 100 // vat
        
        if viewModel.discount_percent.value == 0 {
            let totalAfter = totalChange + vatAmount
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            viewModel.total_amount.accept(totalAfter)
        } else {
            let totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            viewModel.total_amount.accept(totalAfter)
        }
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
    }
}
