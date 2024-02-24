//
//  DialogAccessUpdateProfileBusinessViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 15/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAccessUpdateProfileBusinessViewController: UIViewController {

    var Delegate: UpdateSettingBusiness?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        Delegate?.callUpdateBusiness()
    }
}
