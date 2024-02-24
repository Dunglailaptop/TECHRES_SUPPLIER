//
//  DetailReceiptBillDebtViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class AccountReceivableDetailViewController: BaseViewController {

    var viewModel = AccountReceivableDetailViewModel()
    var router = AccountReceivableDetailRouter()
    var debtReceivable = SupplierDebtReceivable()
    var from_date = ""
    var to_date = ""
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var height_view: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableView()
        dLog(debtReceivable)
        viewModel.debtReceivable.accept(debtReceivable)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDetailSupplierOrders()
        height_view.constant = 0
    }
    
    @IBAction func navigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionToSendPaymentRequest(_ sender: Any) {
        createPaymentRequest()
    }
    
}
