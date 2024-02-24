//
//  DetailDeliveringOrderViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class DetailDeliveringOrderViewController: BaseViewController {

    var viewModel = DetailDeliveringOrderViewModel()
    var router = DetailDeliveringOrderRouter()
    var dataDetail = SupplierOrders()
    var isTableViewInitialized = false
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_delivery_at: UILabel!
    @IBOutlet weak var lbl_restaurant_brand_name: UILabel!
    @IBOutlet weak var lbl_branch_name: UILabel!
    @IBOutlet weak var lbl_restaurant_name: UILabel!

    @IBOutlet weak var lbl_total_amount_reality: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!

    @IBOutlet weak var lbl_discount_percent: UILabel!
    @IBOutlet weak var lbl_discount_amount: UILabel!
    
    @IBOutlet weak var lbl_vat_percent: UILabel!
    @IBOutlet weak var lbl_vat_amount: UILabel!
    
    @IBOutlet weak var lbl_total_material: UILabel!
        
    @IBOutlet weak var height_table_view: NSLayoutConstraint!
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
        
        lbl_restaurant_name.text = dataDetail.restaurant_name
        lbl_restaurant_brand_name.text = dataDetail.restaurant_brand_name
        lbl_branch_name.text = dataDetail.branch_name
        lbl_total_amount_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.amount_reality)
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.total_amount)
        lbl_total_material.text = Utils.stringQuantityFormatWithNumber(amount: dataDetail.total_material)
        lbl_discount_percent.text = Utils.stringQuantityFormatWithNumberDouble(amount: dataDetail.discount_percent) + "%"
        lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.discount_amount)
        lbl_vat_percent.text = Utils.stringQuantityFormatWithNumberDouble(amount: dataDetail.vat) + "%"
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataDetail.vat_amount)
        
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
