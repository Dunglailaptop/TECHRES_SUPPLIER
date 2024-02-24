//
//  ManagerViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 09/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher

class ManagerViewController: BaseViewController {
    
    @IBOutlet weak var view_order: UIView!
    @IBOutlet weak var lbl_order: UILabel!
    
    @IBOutlet weak var view_management: UIView!
    @IBOutlet weak var lbl_management: UILabel!
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        firstSetup()
        
    }

    func firstSetup(){
        
        let orderManagementsViewController = OrderManagementsViewController(nibName: "OrderManagementsViewController", bundle: Bundle.main)
        addTopCustomViewController(orderManagementsViewController, addTopCustom: 67)
        
        let managementViewController = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
        managementViewController.remove()

    }
    
    @IBAction func actionOrder(_ sender: Any) {
        
        view_order.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_order.textColor = UIColor(hex: "1462B0")
        
        view_management.backgroundColor = UIColor(hex: "F1F2F5")
        lbl_management.textColor = UIColor(hex: "7D7E81")
       
        let orderManagementsViewController = OrderManagementsViewController(nibName: "OrderManagementsViewController", bundle: Bundle.main)
        addTopCustomViewController(orderManagementsViewController, addTopCustom: 67)

        let managementViewController = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
        managementViewController.remove()
    }
    
    @IBAction func actionManagements(_ sender: Any) {
        
        view_order.backgroundColor = UIColor(hex: "F1F2F5")
        lbl_order.textColor = UIColor(hex: "7D7E81")
        
        view_management.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_management.textColor = UIColor(hex: "1462B0")
        
        let managementViewController = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
        addTopCustomViewController(managementViewController, addTopCustom: 67)
        
        let orderManagementsViewController = OrderManagementsViewController(nibName: "OrderManagementsViewController", bundle: Bundle.main)
        orderManagementsViewController.remove()
    }
}
