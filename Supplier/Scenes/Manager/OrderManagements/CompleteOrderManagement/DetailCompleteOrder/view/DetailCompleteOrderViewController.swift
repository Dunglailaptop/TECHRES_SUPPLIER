//
//  DetailCompleteOrderViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class DetailCompleteOrderViewController: BaseViewController {

    var viewModel = DetailCompleteOrderViewModel()
    var router = DetailCompleteOrderRouter()
    var dataDetail = SupplierOrders()
    var isTableViewInitialized = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_delivery_at: UILabel! // thời gian đặt
    @IBOutlet weak var lbl_received_at: UILabel! // thời gian nhận
    
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    @IBOutlet weak var lbl_restaurant_brand_name: UILabel!
    @IBOutlet weak var lbl_branch_name: UILabel!
    @IBOutlet weak var lbl_employee_complete: UILabel! // nv nhận
    @IBOutlet weak var lbl_employee_delivering: UILabel! // nv giao
    
    @IBOutlet weak var lbl_total_amount_reality: UILabel! // THANH TOÁN
    
    @IBOutlet weak var lbl_amount: UILabel! // số tiền
    @IBOutlet weak var lbl_total_amount_of_return_material_reality: UILabel! // trả hàng
    @IBOutlet weak var lbl_amount_reality: UILabel! // tổng tiền
    
    @IBOutlet weak var lbl_discount_percent: UILabel! // % giảm giá
    @IBOutlet weak var lbl_vat_percent: UILabel! // % vat
    
    @IBOutlet weak var lbl_discount_amount: UILabel! // tiền giảm giá
    @IBOutlet weak var lbl_vat_amount: UILabel! // tiền vat
    
    @IBOutlet weak var lbl_total_material: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        
        viewModel.dataDetail.accept(dataDetail)
        
        registerCell()
        bindTableView()
        
        lbl_code.text = String(dataDetail.code)
        
        let dateTimeString = dataDetail.delivery_at
        if let index = dateTimeString.firstIndex(of: " ") {
            let dateSubstring = dateTimeString[..<index]
            let dateString = String(dateSubstring)
            lbl_delivery_at.text = dateString
        }
        
        lbl_received_at.text = dataDetail.received_at
        lbl_restaurant_name.text = dataDetail.restaurant_name
        lbl_restaurant_brand_name.text = dataDetail.restaurant_brand_name
        lbl_branch_name.text = dataDetail.branch_name
        lbl_employee_complete.text = dataDetail.employee_complete_full_name
        lbl_employee_delivering.text = dataDetail.supplier_employee_delivering_name
        
        lbl_total_amount_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.total_amount_reality)
        lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.amount)
        lbl_amount_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.amount_reality)
        lbl_total_material.text = Utils.stringQuantityFormatWithNumber(amount: dataDetail.total_material)
        lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.discount_amount)
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.vat_amount)
        lbl_total_amount_of_return_material_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.total_amount_of_return_material_reality)
        lbl_discount_percent.text = Utils.stringQuantityFormatWithNumberDouble(amount: dataDetail.discount_percent) + "%"
        lbl_vat_percent.text = Utils.stringQuantityFormatWithNumberDouble(amount: dataDetail.vat) + "%"
        
        lbl_vat_percent.isHidden = dataDetail.vat == 0 ? true : false
        lbl_discount_percent.isHidden = dataDetail.discount_percent == 0 ? true : false
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        getDetailSupplierOrders()
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
}
