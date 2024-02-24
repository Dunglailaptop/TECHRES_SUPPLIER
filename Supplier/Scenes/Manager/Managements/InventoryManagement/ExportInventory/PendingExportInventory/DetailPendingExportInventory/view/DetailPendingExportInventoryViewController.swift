//
//  DetailPendingExportInventoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailPendingExportInventoryViewController: BaseViewController {

    var viewModel = DetailPendingExportInventoryViewModel()
    var router = DetailPendingExportInventoryRouter()
    
    var dataDetail = SupplierOrdersRequest()
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
    
    @IBOutlet weak var height_table_view: NSLayoutConstraint!
    
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
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
}
