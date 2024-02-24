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
extension DetailPendingInventoryViewController: SupplierOrdersDelegate {
    func getMaterial(){
        // Truyền mảng nguyên liệu vào
        var materialsRequest = viewModel.material_datas.value
        let materials = viewModel.dataArray.value

        materials.enumerated().forEach { (index, value) in
            var materialRequest = SupplierMaterialOrderRequest()
            materialRequest?.supplier_material_id = value.supplier_material_id
            materialRequest?.supplier_input_quantity = value.supplier_input_quantity
            materialRequest?.supplier_input_unit_type = 1
            materialRequest?.supplier_input_price = value.supplier_input_price
            materialRequest?.supplier_warehouse_session_detail_id = idDetail
            materialsRequest.append(materialRequest!)
        }
        viewModel.material_datas.accept(materialsRequest)
    }
    
    func callBackCancelSupplierOrders(cancel_reason:String) {
        viewModel.reason.accept(cancel_reason)
        viewModel.status_order.accept(Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.CANCELLED)// cancel
        viewModel.type_dialog.accept(0)
        self.updateSupplierOrdersRequest()
    }
    
    func callBackAcceptSupplierOrders(index: Int) {
        if viewModel.type_dialog.value == 0{
            self.getMaterial()
            self.updateSupplierOrdersRequest()
        }else if viewModel.type_dialog.value == 1 {
            self.getMaterial()
            viewModel.status_order.accept(Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.COMPLETED)// Confirm
            self.updateSupplierOrdersRequest()
        }else{
            self.handleDeleteMaterialAction(index: index)
        }
    }
    
    func presentModalDialogAcceptPendingOrder(index: Int) {
        
        let dialogAcceptViewController = DialogAcceptPendingInventoryViewController()
        
        dialogAcceptViewController.view.backgroundColor = ColorUtils.blackTransparent()
        if viewModel.type_dialog.value == 0{
            dialogAcceptViewController.dialogContent = "Xác nhận lưu phiếu nhập kho"
        }else if viewModel.type_dialog.value == 1 {
            dialogAcceptViewController.dialogContent = "Xác nhận phiếu nhập kho"
        }else{
            dialogAcceptViewController.dialogContent = "Bạn muốn xoá mặt hàng này?"
        }
        dialogAcceptViewController.index = index
        dialogAcceptViewController.delegate = self
        let nav = UINavigationController(rootViewController: dialogAcceptViewController)
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
        let dialogCancelViewController = DialogCancelPendingInventoryViewController()
        
        dialogCancelViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogCancelViewController.delegate = self
            let nav = UINavigationController(rootViewController: dialogCancelViewController)
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

extension DetailPendingInventoryViewController: ChooseInputMoneyDelegate {
    
    func presentModalDialogChooseInput() {
        
        let dialogChooseInputViewController = DialogChooseInputImportViewController()
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
        
        let discountAmount = viewModel.discount_amount.value
        let cloneDataArray = self.viewModel.dataArray.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].supplier_input_price) * cloneDataArray[index].supplier_input_quantity
        }
        if percent == 0 {
            totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = totalChange + vatAmount
            
            viewModel.discount_amount.accept(amount)
            viewModel.discount_amount_display.accept(amount)
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
        } else {
            discountPercent = Int(totalAmount) * Int(percent) / 100 // tính giảm giá theo %
            totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            
            viewModel.discount_percent.accept(Int(percent))
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
        }
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
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
            totalAmount += Double(cloneDataArray[index].supplier_input_price) * cloneDataArray[index].supplier_input_quantity
        }
        let vatAmount = Int(totalAmount) * Int(viewModel.vat_percent.value) / 100 // vat
        let totalAfter = Int(totalAmount) + vatAmount
        
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
    }
}

//MARK: Mở dialog chọn nguyên liệu
extension DetailPendingInventoryViewController: SupplierRequestMaterialDelegate {
    
    func presentModalDialogChooseMaterial() {
        let materialInventoryViewController = MaterialInventoryViewController()
        materialInventoryViewController.dataSelectedMaterial = viewModel.dataArray.value
        materialInventoryViewController.requestSupplierMarerialDelegate = self
        materialInventoryViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: materialInventoryViewController)
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
    
    func callBackToAcceptRequestSupplierMaterial(dataMaterial: [Material]) {
        var materialRequest:[MaterialWarehouseSessions] = []
        let discountAmount = viewModel.discount_amount.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
        dataMaterial.enumerated().forEach{( index, value ) in
            var item = MaterialWarehouseSessions()
            item?.supplier_material_id = value.id
            item?.supplier_material_name = value.name
            item?.unit_name = value.material_unit_name
            item?.quantity = Double(value.remain_quantity)
            item?.supplier_input_quantity = value.total_import_quantity
            item?.supplier_input_price = value.price
            item?.total_price = value.total_amount_from_quantity_import
            materialRequest.append(item!)
            totalAmount += Double(dataMaterial[index].price) * dataMaterial[index].total_import_quantity
        }
        viewModel.dataArray.accept(materialRequest)
        
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
        lbl_total_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
        lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: materialRequest.count)
        Utils.isHideAllView(isHide: materialRequest.isEmpty ? false : true, view: root_view_empty_data)
        height_table_view.constant = materialRequest.isEmpty == true ? 200 : CGFloat(materialRequest.count * 65) // tính height table
        Utils.isHideAllView(isHide: false, view: view_btn_update) // mở nút lưu lại
    }
}
