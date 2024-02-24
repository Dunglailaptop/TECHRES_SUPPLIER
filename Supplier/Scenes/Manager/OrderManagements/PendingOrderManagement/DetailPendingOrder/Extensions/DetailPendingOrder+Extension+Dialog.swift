//
//  DetailPendingOrderViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

//MARK: Handler dialog cancel
extension DetailPendingOrderViewController: SupplierOrdersDelegate {
    func callBackCancelSupplierOrders(cancel_reason:String) {
        viewModel.reason.accept(cancel_reason)
        viewModel.status_order.accept(Constants.SUPPLIER_ORDERS_REQUEST_STATUS.CANCELLED) // cancel
        self.changeStatusSupplierOrdersRequest()
    }
    
    func callBackAcceptSupplierOrders(index: Int) {
        viewModel.status_order.accept(Constants.SUPPLIER_ORDERS_STATUS.WAITTING_RESTAURANT_CONFIRM)// Confirm
        viewModel.supplier_order_request_id.accept(dataDetail.id)
        // Truyền mảng nguyên liệu vào
        var materialsRequest = viewModel.list_material.value
        let materials = viewModel.dataArray.value

        materials.enumerated().forEach { (index, value) in
            var materialRequest = ListMaterialResquest()
            
            materialRequest?.quantity = value.supplier_quantity
            materialRequest?.supplier_material_id = value.supplier_material_id
            materialRequest?.price_reality = Double(value.retail_price)
            materialsRequest.append(materialRequest!)
        }
        viewModel.list_material.accept(materialsRequest)
        
        self.confirmSupplierOrdersRequest()
    }
    
    func presentModalDialogAcceptPendingOrder() {
        
        let dialogAcceptPendingOrderViewController = DialogAcceptPendingOrderViewController()
        
        dialogAcceptPendingOrderViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogAcceptPendingOrderViewController.delegate = self
        let nav = UINavigationController(rootViewController: dialogAcceptPendingOrderViewController)
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

    
    func presentModalDialogCancelPendingOrder() {
        let dialogCancelPendingOrderViewController = DialogCancelPendingOrderViewController()
        
        dialogCancelPendingOrderViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogCancelPendingOrderViewController.delegate = self
            let nav = UINavigationController(rootViewController: dialogCancelPendingOrderViewController)
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

extension DetailPendingOrderViewController: ChooseInputMoneyDelegate {
    
    func presentModalDialogChooseInput() {
        
        let dialogChooseInputViewController = DialogChooseInputViewController()
        dialogChooseInputViewController.viewModel = viewModel
        dialogChooseInputViewController.delegate = self
        dialogChooseInputViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: dialogChooseInputViewController)
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
    
    func callBackChooseInputMoney(amount: Int, percent: Float) {
        icon_check.image = UIImage(named: amount == 0 ? "icon-uncheck-blue" : "icon-check-blue")
        lbl_discount_percent.isHidden = percent == 0 ? true : false
        icon_edit_discount.isHidden = percent == 0 && amount == 0 ? true : false
        constraint_icon_edit_discount.constant = percent == 0 ? 0 : 16
        constraint_discount_percent.constant = percent == 0 ? 0 : 8
        lbl_discount_percent.text = String(Int(percent)) + "%"
        lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: amount)
        
        var totalAmount:Double = 0.00
        let cloneDataArray = self.viewModel.dataArray.value
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].retail_price) * cloneDataArray[index].supplier_quantity
        }
        
        let discountAmount = viewModel.discount_amount_display.value
        let discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100
        let totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá
        let vatAmount = Int(totalChange) * Int(viewModel.vat.value) / 100 // vat
        
        if percent == 0 {
            let totalAfter = totalChange + vatAmount
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
            lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
            viewModel.discount_amount.accept(amount)
            viewModel.discount_amount_display.accept(amount)
        } else {
            let totalAfter = Int(totalAmount) - discountPercent + vatAmount
            lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
            viewModel.discount_percent.accept(percent)
        }
    }
    
    func callBackCancelChooseInputMoney() {
        icon_check.image = UIImage(named: "icon-uncheck-blue")
        lbl_discount_percent.text = "0"
        lbl_discount_amount.text = "0"
        lbl_discount_percent.isHidden = true
        icon_edit_discount.isHidden = true

        viewModel.discount_amount.accept(0)
        viewModel.discount_amount_display.accept(0)
        viewModel.discount_percent.accept(0)
        
        var totalAmount:Double = 0.00
        let cloneDataArray = self.viewModel.dataArray.value
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].retail_price) * cloneDataArray[index].supplier_quantity
        }
        let vatAmount = Int(totalAmount) * Int(viewModel.vat.value) / 100 // vat
        let totalAfter = Int(totalAmount) + vatAmount
        
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
    }
}
