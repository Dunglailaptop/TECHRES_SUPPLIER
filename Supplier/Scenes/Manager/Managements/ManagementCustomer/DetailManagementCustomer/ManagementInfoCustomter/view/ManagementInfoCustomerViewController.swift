//
//  ManagementInfoCustomerViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ManagementInfoCustomerViewController: BaseViewController {
    
    var viewModel = ManagementInfoCustomerViewModel()
    var router = ManagementInfoCustomerRouter()
    var restaurantId = 0
    
    @IBOutlet weak var lbl_total_count: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_waittingPayment_count: UILabel!
    @IBOutlet weak var lbl_waittingPayment_amount: UILabel!
    @IBOutlet weak var lbl_successPayment_count: UILabel!
    @IBOutlet weak var lbl_successPayment_amount: UILabel!
    @IBOutlet weak var lbl_canceled_count: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.restaurant_id.accept(restaurantId)
        self.getDetailCustomer()
    }
}
