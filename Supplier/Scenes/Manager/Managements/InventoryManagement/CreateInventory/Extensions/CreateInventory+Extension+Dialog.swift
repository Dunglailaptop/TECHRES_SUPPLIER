//
//  TotalAmountOrderManagementViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

//MARK: Mở dialog xác nhận tạo phiếu
extension CreateInventoryViewController: SupplierWarehouseSessionsDelegate {
    
    func callBackAcceptSupplierWarehouse(index: Int) {
        if viewModel.type_dialog.value == 0 {
            self.handleDeleteMaterialAction(index: index)
        }else if viewModel.type_dialog.value == 1 {
            viewModel.type.accept(Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.IN) // nhập
            // Truyền mảng nguyên liệu vào
            var materialsRequest = viewModel.material_datas.value
            let materials = viewModel.dataArray.value

            materials.enumerated().forEach { (index, value) in
                var materialRequest = SupplierMaterialOrderRequest()
                materialRequest?.supplier_material_id = value.id
                materialRequest?.supplier_input_quantity = value.total_import_quantity
                materialRequest?.supplier_input_unit_type = 1
                materialRequest?.supplier_input_price = value.price
                materialsRequest.append(materialRequest!)
            }
            viewModel.material_datas.accept(materialsRequest)
            if btnCreateType == Constants.SUPPLIER_CREATE_INVENTORY_TYPE.IMPORT{
                self.createSupplierWarehouseSessions()
            }else{
                self.createCancelSupplierWarehouseSessions()
            }
        }else{
            NotificationCenter.default
                        .post(name:NSNotification.Name("backCreateInventory"),
                         object: nil,
                         userInfo: nil)
            viewModel.makePopViewController()
        }
    }
    
    func presentModalDialogAcceptSupplierWarehouse(index: Int) {
        
        let dialogAcceptCreateInventoryViewController = DialogAcceptCreateInventoryViewController()
        
        dialogAcceptCreateInventoryViewController.view.backgroundColor = ColorUtils.blackTransparent()
        if viewModel.type_dialog.value == 0 {
            dialogAcceptCreateInventoryViewController.diaglogContent = "Bạn muốn xoá mặt hàng này?"
        }else if viewModel.type_dialog.value == 1{
            dialogAcceptCreateInventoryViewController.diaglogContent = "Xác nhận tạo phiếu"
        }else{
            dialogAcceptCreateInventoryViewController.diaglogContent = "Toàn bộ thông tin bạn vừa thay đổi sẽ bị mất. Bạn có muốn thoát không?"
        }
        dialogAcceptCreateInventoryViewController.index = index
        dialogAcceptCreateInventoryViewController.delegate = self
        let nav = UINavigationController(rootViewController: dialogAcceptCreateInventoryViewController)
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

// MARK: Mở dialog chọn hình thức giảm giá
extension CreateInventoryViewController: ChooseInputMoneyDelegate {
    
    func presentModalDialogChooseInput() {
        
        let dialogChooseInputInventoryViewController = DialogChooseInputInventoryViewController()
        dialogChooseInputInventoryViewController.viewModel = viewModel
        dialogChooseInputInventoryViewController.delegate = self
        dialogChooseInputInventoryViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: dialogChooseInputInventoryViewController)
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
            totalAmount += Double(cloneDataArray[index].price) * cloneDataArray[index].total_import_quantity
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
        lbl_discount_percent.text = "0%"
        lbl_discount_amount.text = "0"
        lbl_discount_percent.isHidden = true
        viewModel.discount_amount.accept(0)
        viewModel.discount_amount_display.accept(0)
        viewModel.discount_percent.accept(0)
        
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalAfter = 0
        
        let cloneDataArray = self.viewModel.dataArray.value
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].price) * Double(cloneDataArray[index].total_import_quantity)
        }
        vatAmount = Int(totalAmount) * Int(viewModel.vat_percent.value) / 100 // vat
        totalAfter = Int(totalAmount) + vatAmount
        
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
    }
}

//MARK: Mở dialog chọn nguyên liệu
extension CreateInventoryViewController: SupplierRequestMaterialDelegate {
    
    func presentModalDialogChooseMaterial() {
        let materialInventoryViewController = MaterialInventoryViewController()
        materialInventoryViewController.dataSelected = viewModel.dataArray.value
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
        viewModel.dataArray.accept(dataMaterial)
        let discountAmount = viewModel.discount_amount.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        var heightTableView: CGFloat = 0
        
        self.dataArrayMaterial = dataMaterial
        dataMaterial.enumerated().forEach { (index, value) in
            totalAmount += Double(value.price) * value.total_import_quantity
            heightTableView += Utils.getHeightTextContentInView(textString: value.name, maxWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - CGFloat(248), theRest: 32, fontSize: 14, fontName: "Roboto-Regular")
        }
        if viewModel.discount_percent.value == 0 {
            totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = totalChange + vatAmount
            
            viewModel.total_amount.accept(Int(totalAfter))
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
        } else {
            discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100 // tính giảm giá theo %
            totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            
            viewModel.total_amount.accept(Int(totalAfter))
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
        }
        viewModel.total_price.accept(Int(totalAmount))
        lbl_total_price.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAmount))
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
        lbl_total_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
        lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataMaterial.count)
        Utils.isHideAllView(isHide: dataMaterial.isEmpty ? false : true, view: root_view_empty_data)
        height_table_view.constant = dataMaterial.isEmpty == true ? 200 : heightTableView
    }
}