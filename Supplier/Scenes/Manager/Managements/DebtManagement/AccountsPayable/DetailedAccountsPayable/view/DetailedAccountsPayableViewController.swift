//
//  DetailedAccountsPayableViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedAccountsPayableViewController: BaseViewController {

    var viewModel = DetailedAccountsPayableViewModel()
    var router = DetailedAccountsPayableRouter()
    var warehouseReceipt = WarehouseReceipt()
    var from_date = ""
    var to_date = ""
    
    
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_created_date: UILabel!
    @IBOutlet weak var lbl_employee_create: UILabel!
    @IBOutlet weak var lbl_note: UILabel!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_total_payment: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_discount_percent: UILabel!
    @IBOutlet weak var lbl_discount_amount: UILabel!
    @IBOutlet weak var lbl_vat_percent: UILabel!
    @IBOutlet weak var lbl_vat_amount: UILabel!
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var height_of_table_view: NSLayoutConstraint!
    
    @IBOutlet weak var btn_view: UIView!
    @IBOutlet weak var height_of_btn_view: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        height_of_btn_view.constant = 0
        btn_view.isHidden = true
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableView()
        mapData(receipt: warehouseReceipt)
        viewModel.warehouseReceipt.accept(warehouseReceipt)
        getDetailSupplierWarehouseSessions()
//        getDetailSupplierOrders()
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionToSendPaymentRequest(_ sender: Any) {
        createPayment()
    }
    
    private func mapData(receipt: WarehouseReceipt){
        lbl_code.text = receipt.code
        lbl_created_date.text = receipt.created_at
        lbl_employee_create.text = receipt.supplier_employee_name
        lbl_note.text = receipt.note
        lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: receipt.total_amount)
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: receipt.amount)
        lbl_discount_percent.text = String(format: "%.1f%%", receipt.discount_percent)
        lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: receipt.discount_amount)
        lbl_vat_percent.text = String(format: "%.1f%%", receipt.vat)
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: receipt.vat_amount)
    }
}
