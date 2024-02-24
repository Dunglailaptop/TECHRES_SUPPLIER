//
//  DialogConfrimAccessViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 07/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogConfrimAccessViewController: BaseViewController {

    var viewModel = DetailEmployeeViewModel()
   
    @IBOutlet weak var lbl_not: UILabel!
    var Delegate: DialogConfrimCreateEmployee?
    
    var check = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }


    @IBAction func btn_cancel(_ sender: Any) {
       dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        dismiss(animated: true)
        Delegate?.callBackDialogConfrimCreateEmployeePopup(check: 0)
    }
    
}
