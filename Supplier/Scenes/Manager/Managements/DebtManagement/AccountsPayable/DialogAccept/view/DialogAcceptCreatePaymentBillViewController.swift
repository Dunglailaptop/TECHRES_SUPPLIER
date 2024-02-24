//
//  DialogAcceptCreatePaymentBillViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAcceptCreatePaymentBillViewController: BaseViewController {
    
    var viewModel = AccountsPayableViewModel()
    
    @IBOutlet weak var root_view: UIView!
    
    var delegate: SupplierDebtPaymentBillDelegate?
    var id = 0
    var isCheckSpam:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func actionApproved(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                    
                }
        self.delegate?.callBackAcceptSupplierDebtPaymentBill()
        dismiss(animated: true)
    }

}
