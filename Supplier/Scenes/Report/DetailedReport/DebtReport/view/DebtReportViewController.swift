//
//  OrderReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
class DebtReportViewController: UIViewController {
    var viewModel = DebtReportViewModel()
    var router = DebtReportRouter()
    
    @IBOutlet weak var lbl_Barchart: UILabel!
    @IBOutlet weak var lbl_table: UILabel!
    

    
    @IBOutlet weak var view_Barchart: UIView!
    @IBOutlet weak var view_table: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
      historyViewController()
    }
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func action_ViewControllerHistory(_ sender: Any) {
       
        historyViewController()
    }
    
    
    @IBAction func action_ViewControllerNew(_ sender: Any) {
     newViewController()
    }
    
    
    
    
}
