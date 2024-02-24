//
//  InventoryManagementViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class InventoryManagementViewController: UIViewController {
    
    var viewModel = InventoryManagementViewModel()
    var router = InventoryManagementRouter()
    
    @IBOutlet weak var view_receipt_bill: UIView!
    @IBOutlet weak var lbl_receipt_bill: UILabel!
    
    @IBOutlet weak var view_payment_bill: UIView!
    @IBOutlet weak var lbl_payment_bill: UILabel!
    
    @IBOutlet weak var icon_create: UIImageView!
    @IBOutlet weak var btn_create: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationButton),
            name: NSNotification.Name("showCreateInventory"),
            object: nil)
        
        viewModel.bind(view: self, router: router)
        firstSetup()
        
    }

    @objc private func notificationButton(notification: NSNotification){
        icon_create.isHidden = false
        btn_create.isEnabled = true
    }

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    func firstSetup(){
        let importInventoryViewController = ImportInventoryViewController(nibName: "ImportInventoryViewController", bundle: Bundle.main)
        addTopCustomViewController(importInventoryViewController, addTopCustom: 125)
		
        let exportInventoryViewController = ExportInventoryViewController(nibName: "ExportInventoryViewController", bundle: Bundle.main)
        exportInventoryViewController.remove()
 
    }
    
    @IBAction func actionReceiptBill(_ sender: Any) {
        view_receipt_bill.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_receipt_bill.textColor = UIColor(hex: "1462B0")

        view_payment_bill.backgroundColor = UIColor(hex: "F1F2F5")
        lbl_payment_bill.textColor = UIColor(hex: "7D7E81")

        let importInventoryViewController = ImportInventoryViewController(nibName: "ImportInventoryViewController", bundle: Bundle.main)
        addTopCustomViewController(importInventoryViewController, addTopCustom: 125)

        let exportInventoryViewController = ExportInventoryViewController(nibName: "ExportInventoryViewController", bundle: Bundle.main)
        exportInventoryViewController.remove()
        
        icon_create.isHidden = false
        btn_create.isEnabled = true
        viewModel.btn_create_type.accept(Constants.SUPPLIER_CREATE_INVENTORY_TYPE.IMPORT)
    }
    
    @IBAction func actionPaymentBill(_ sender: Any) {
        view_payment_bill.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_payment_bill.textColor = UIColor(hex: "1462B0")

        view_receipt_bill.backgroundColor = UIColor(hex: "F1F2F5")
        lbl_receipt_bill.textColor = UIColor(hex: "7D7E81")

        let importInventoryViewController = ImportInventoryViewController(nibName: "ImportInventoryViewController", bundle: Bundle.main)
        importInventoryViewController.remove()

        let exportInventoryViewController = ExportInventoryViewController(nibName: "ExportInventoryViewController", bundle: Bundle.main)
        addTopCustomViewController(exportInventoryViewController, addTopCustom: 125)
        
        icon_create.isHidden = true
        btn_create.isEnabled = false
        viewModel.btn_create_type.accept(Constants.SUPPLIER_CREATE_INVENTORY_TYPE.CANCEL)
        dLog(viewModel.btn_create_type.value)
    }
    
    @IBAction func actionCreateWarehouseSessions(_ sender: Any) {
        viewModel.makeCreateInventoryViewController()
    }
}
