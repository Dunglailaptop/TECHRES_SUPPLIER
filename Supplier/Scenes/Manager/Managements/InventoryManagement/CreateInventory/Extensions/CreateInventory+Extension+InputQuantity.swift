//
//  DetailPendingOrder+Extension+InputQuantity.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension CreateInventoryViewController: InputQuantityDelegate{
    func presentModalInputQuantityViewController(number: Float, position: Int) {
            let dialogInputQuantityViewController = DialogInputQuantityViewController()
            dialogInputQuantityViewController.maxQuantity = 100
            dialogInputQuantityViewController.position = position
            dialogInputQuantityViewController.current_quantity = number
            dialogInputQuantityViewController.is_sell_by_weight = 1
            dialogInputQuantityViewController.delegate = self
            if viewModel.type_select_input_quantity.value == 1 {
                dialogInputQuantityViewController.lblTitle = "NHẬP PHẦN TRĂM VAT"
                dialogInputQuantityViewController.is_sell_by_weight = 0
                dialogInputQuantityViewController.maxQuantity = 100
            } else {
                dialogInputQuantityViewController.lblTitle = "NHẬP SỐ LƯỢNG"
                dialogInputQuantityViewController.is_sell_by_weight = 1
                dialogInputQuantityViewController.maxQuantity = 9999
            }       
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
        // MARK: type = 1 CHỌN % VAT
        if viewModel.type_select_input_quantity.value == 1 {
            self.icon_check02.image = UIImage(named: number == 0 ? "icon-uncheck-blue" : "icon-check-blue")
            self.lbl_vat_percent.isHidden = number == 0 ? true : false
            self.icon_edit_vat.isHidden = number == 0 ? true : false
            
            let cloneDataArray = self.viewModel.dataArray.value
            let discountAmount = viewModel.discount_amount_display.value
            // biến tính toán
            var totalAmount:Double = 0.00
            var vatAmount = 0
            var totalChange = 0
            var totalAfter = 0
            var discountPercent = 0
            
            cloneDataArray.enumerated().forEach { (index, value) in
                totalAmount += Double(cloneDataArray[index].price) * cloneDataArray[index].total_import_quantity
            }
            if viewModel.discount_percent.value == 0 {
                totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
                vatAmount = Int(totalChange) * Int(number) / 100 // vat
                totalAfter = totalChange + vatAmount
                
                lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            } else {
                discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100 // tính giảm giá theo %
                totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
                vatAmount = Int(totalChange) * Int(number) / 100 // vat
                totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
                
                lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
                lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
            }
            
            self.viewModel.vat_percent.accept(number)
            self.viewModel.vat_amount.accept(vatAmount)
            
            self.lbl_vat_percent.text = String(Int(number)) + "%"
            self.lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
        } // MARK: type = 2 CHỌN SỐ LƯỢNG GIAO CỦA NGUYÊN LIỆU
        else {
            var cloneDataArray = self.viewModel.dataArray.value
            let discountAmount = viewModel.discount_amount_display.value
            // biến tính toán
            var totalAmount:Double = 0.00
            var vatAmount = 0
            var totalChange = 0
            var totalAfter = 0
            var discountPercent = 0
            
            cloneDataArray[position].total_import_quantity = Double(number)
            self.viewModel.dataArray.accept(cloneDataArray)
            
            cloneDataArray.enumerated().forEach { (index, value) in
                totalAmount += Double(cloneDataArray[index].price) * Double(cloneDataArray[index].total_import_quantity)
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
}
