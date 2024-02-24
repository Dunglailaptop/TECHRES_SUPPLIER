//
//  DetailPendingInventoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

class DetailPendingInventoryViewController: BaseViewController {

    var viewModel = DetailPendingInventoryViewModel()
    var router = DetailPendingInventoryRouter()
    
    var dataDetail = SupplierOrdersRequest()
    var dataArrayMaterial = [Material]()
    var idDetail = 0
    var isTableViewInitialized = false

    @IBOutlet weak var lbl_code: UILabel! // mã phiếu
    @IBOutlet weak var lbl_create_at: UILabel! // thời gian tạo
    @IBOutlet weak var lbl_supplier_employee_name: UILabel! // nv tạo
    @IBOutlet weak var lbl_note: UILabel! // ghi chú
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var lbl_total_amount: UILabel! // thanh toán
    @IBOutlet weak var lbl_total_price: UILabel! // tổng tiền

    @IBOutlet weak var lbl_discount_percent: UILabel! // % giảm giá
    @IBOutlet weak var lbl_discount_amount: UILabel! // tiền giảm giá
    
    @IBOutlet weak var lbl_vat_percent: UILabel! // % vat
    @IBOutlet weak var lbl_vat_amount: UILabel! // tiền vat
    
    @IBOutlet weak var lbl_total_quantity: UILabel! // tổng mặt hàng
    
    @IBOutlet weak var icon_check: UIImageView!
    @IBOutlet weak var icon_check02: UIImageView!
    
    @IBOutlet weak var icon_edit_discount: UIImageView!
    @IBOutlet weak var icon_edit_vat: UIImageView!
    
    @IBOutlet weak var constraint_icon_edit_discount: NSLayoutConstraint!
    @IBOutlet weak var constraint_discount_percent: NSLayoutConstraint!
    
    @IBOutlet weak var height_table_view: NSLayoutConstraint!
    
    @IBOutlet weak var root_view_empty_data: UIView!
    @IBOutlet weak var view_btn_update: UIView! // view nút lưu lại
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        
        registerCell()
        bindTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        getDetailSupplierWarehouseSessions()
        getSupplierWarehouseSessionsDetail()
    }
    
    @IBAction func actionShowChooseInputDiscount(_ sender: Any) {
        if viewModel.discount_amount.value == 0 {
            self.presentModalDialogChooseInput()
        } else {
            viewModel.discount_amount.accept(0)
            viewModel.discount_percent.accept(0)
            lbl_discount_amount.text = "0"
            lbl_discount_percent.isHidden = true
            icon_edit_discount.isHidden = true
            icon_check.image = UIImage(named: "icon-uncheck-blue")
            self.calculateAmount()
        }
    }
    
    @IBAction func actionShowChooseInputVAT(_ sender: Any) {
        if viewModel.vat_amount.value == 0 {
            viewModel.type_select_input_quantity.accept(1)
            self.presentModalInputQuantityViewController(number: Float(viewModel.vat_percent.value), position: 0)
        }else{
            viewModel.vat_percent.accept(0)
            viewModel.vat_amount.accept(0)
            lbl_vat_amount.text = "0"
            lbl_vat_percent.isHidden = true
            icon_edit_vat.isHidden = true
            icon_check02.image = UIImage(named: "icon-uncheck-blue")
            self.calculateAmount()
        }
    }
    
    @IBAction func actionShowEditDiscount(_ sender: Any) {
        if viewModel.discount_amount.value != 0 {
            self.presentModalDialogChooseInput()
        }
    }
    
    @IBAction func actionShowEditVAT(_ sender: Any) {
        if viewModel.vat_amount.value != 0 {
            viewModel.type_select_input_quantity.accept(1)
            self.presentModalInputQuantityViewController(number: Float(viewModel.vat_percent.value), position: 1)
        }
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionChooseMaterial(_ sender: Any) {
        self.presentModalDialogChooseMaterial()
    }
    
    @IBAction func actionUpdate(_ sender: Any) {
        viewModel.type_dialog.accept(0)
        self.presentModalDialogAcceptPendingOrder(index: 0)
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        viewModel.type_dialog.accept(1)
        self.presentModalDialogAcceptPendingOrder(index: 0)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.presentModalDialogCancelPendingOrder()
    }
    
    public func calculateAmount() {
        let discountAmount = viewModel.discount_amount.value
        let cloneDataArray = self.viewModel.dataArray.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
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
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
    }
}
