//
//  DetailPendingOrderViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailPendingOrderViewController: BaseViewController {

    var viewModel = DetailPendingOrderViewModel()
    var router = DetailPendingOrderRouter()
    
    var dialogCancelPendingOrderViewController = DialogCancelPendingOrderViewController()
    var dialogAcceptPendingOrderViewController = DialogAcceptPendingOrderViewController()
    var dataDetail = SupplierOrdersRequest()
    var isTableViewInitialized = false

    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_create_at: UILabel!
    @IBOutlet weak var lbl_order_time: UILabel!
    @IBOutlet weak var lbl_expected_delivery_time: UILabel!
    @IBOutlet weak var lbl_restaurant_brand_name: UILabel!
    @IBOutlet weak var lbl_branch_name: UILabel!
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    
    @IBOutlet weak var lbl_discount_percent: UILabel!
    @IBOutlet weak var lbl_vat_percent: UILabel!
    
    @IBOutlet weak var lbl_discount_amount: UILabel!
    @IBOutlet weak var lbl_vat_amount: UILabel!
    
    @IBOutlet weak var lbl_quantity: UILabel!

    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height_table_view: NSLayoutConstraint!
    
    @IBOutlet weak var icon_check: UIImageView!
    @IBOutlet weak var icon_check02: UIImageView!
    
    @IBOutlet weak var icon_edit_discount: UIImageView!
    @IBOutlet weak var icon_edit_vat: UIImageView!
    
    @IBOutlet weak var actionCancelExportInnerBranch: UIButton!
    @IBOutlet weak var actionAcceptExportInnerBranch: UIButton!
    
    @IBOutlet weak var constraint_icon_edit_discount: NSLayoutConstraint!
    @IBOutlet weak var constraint_discount_percent: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        
        registerCell()
        bindTableViewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
//        let orderTime = dataDetail.updated_at.components(separatedBy: "/")
//        let deliveryTime = Utils.getCurrentDateString().components(separatedBy: "/")
    
//        let orderTimeIn = String(format: "%@%@%@", orderTime[2], orderTime[1], orderTime[0])
//        let deliveryTimeIn = String(format: "%@%@%@", deliveryTime[2], deliveryTime[1], deliveryTime[0])
        // MARK: Khi ngày đặt hàng là ngày tương lai thì để ngày giao hàng dự kiến là ngày đặt hàng, ngược lại thì ngày hiện tại
//        if(orderTimeIn > deliveryTimeIn){
//            lbl_expected_delivery_time.text = dataDetail.expected_delivery_time
//            viewModel.expected_delivery_time.accept(dataDetail.expected_delivery_time)
//        }else{
//            lbl_expected_delivery_time.text = Utils.getCurrentDateString()
//            viewModel.expected_delivery_time.accept(Utils.getCurrentDateString())
//        }
//        let dateString = dataDetail.expected_delivery_time
//        if let spaceIndex = dateString.firstIndex(of: " ") {
//            let dateSubstring = dateString[..<spaceIndex]
//            let formattedDate = String(dateSubstring)
            
        lbl_order_time.text = dataDetail.expected_delivery_time
        lbl_expected_delivery_time.text = dataDetail.expected_delivery_time
        viewModel.expected_delivery_time.accept(dataDetail.expected_delivery_time)
//        }
        
        getDetailSupplierOrdersRequest()
    }
    
    @IBAction func actionShowChooseInputDiscount(_ sender: Any) {
        if viewModel.discount_amount_display.value == 0 {
            self.presentModalDialogChooseInput()
        } else {
            viewModel.discount_amount.accept(0)
            viewModel.discount_amount_display.accept(0)
            viewModel.discount_percent.accept(0)
            lbl_discount_amount.text = "0"
            lbl_discount_percent.isHidden = true
            icon_edit_discount.isHidden = true
            icon_check.image = UIImage(named: "icon-uncheck-blue")
            
            var totalAmount:Double = 0.00
            let cloneDataArray = self.viewModel.dataArray.value
            cloneDataArray.enumerated().forEach { (index, value) in
                totalAmount += Double(cloneDataArray[index].retail_price) * cloneDataArray[index].supplier_quantity
            }
            let discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100
            let vatAmount = viewModel.vat_amount.value
            let discountAmount = viewModel.discount_amount_display.value
            
            if viewModel.discount_percent.value == 0 {
                let totalAfter = Int(totalAmount) - discountAmount + vatAmount
                lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
            } else {
                let totalAfter = Int(totalAmount) - discountPercent + vatAmount
                lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
            }
        }
    }
    
    @IBAction func actionShowChooseInputVAT(_ sender: Any) {
        if viewModel.vat_amount.value == 0 {
            viewModel.type_select_input_quantity.accept(1)
            self.presentModalInputQuantityViewController(number: Double(viewModel.vat.value), position: 1)
        }else{
            viewModel.vat.accept(0)
            viewModel.vat_amount.accept(0)
            lbl_vat_amount.text = "0"
            lbl_vat_percent.isHidden = true
            icon_edit_vat.isHidden = true
            icon_check02.image = UIImage(named: "icon-uncheck-blue")
            
            var totalAmount:Double = 0.00
            let cloneDataArray = self.viewModel.dataArray.value
            cloneDataArray.enumerated().forEach { (index, value) in
                totalAmount += Double(cloneDataArray[index].retail_price) * cloneDataArray[index].supplier_quantity
            }
            let discountAmount = viewModel.discount_amount_display.value
            let totalAfter = Int(totalAmount) - discountAmount // tổng sau giảm giá
            
            self.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAfter)
        }
    }
    
    @IBAction func actionShowEditDiscount(_ sender: Any) {
        if viewModel.discount_amount_display.value != 0 {
            self.presentModalDialogChooseInput()
        }
    }
    
    @IBAction func actionShowEditVAT(_ sender: Any) {
        if viewModel.vat_amount.value != 0 {
            self.presentModalInputQuantityViewController(number: Double(viewModel.vat.value), position: 1)
        }
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        self.presentModalDialogAcceptPendingOrder()
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.presentModalDialogCancelPendingOrder()
    }
    
    @IBAction func actionChooseDate(_ sender: Any) {
        showDateTimePicker()
    }
}
