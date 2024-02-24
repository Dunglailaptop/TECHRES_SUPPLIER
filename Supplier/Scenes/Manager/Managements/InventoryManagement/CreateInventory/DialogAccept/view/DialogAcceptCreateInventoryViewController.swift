//
//  DialogAcceptCreateInventoryViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAcceptCreateInventoryViewController: BaseViewController {
    
    var viewModel = CreateInventoryViewModel()
    
    @IBOutlet weak var root_view: UIView!
    @IBOutlet weak var lbl_content: UILabel!
    var delegate: SupplierWarehouseSessionsDelegate?
    var id = 0
    var index = 0
    var isCheckSpam:Bool = false
    var diaglogContent = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_content.text = diaglogContent
    }

    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionApproved(_ sender: Any) {
        self.dismiss(animated: true)
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                }
        self.delegate?.callBackAcceptSupplierWarehouse(index: index)
    }
}
