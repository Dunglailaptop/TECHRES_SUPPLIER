//
//  DialogAccessChangePasswordEmployeeViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAccessChangePasswordEmployeeViewController: UIViewController {

    @IBOutlet weak var lbl_username: UILabel!
    
    @IBOutlet weak var lbl_newpassword: UILabel!
    
    var viewModel = EmployeeListManagementViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public var data:Account? = nil {
        didSet{
            lbl_username.text = data?.username
            lbl_newpassword.text = data?.password
        }
    }

    @IBAction func btn_access_resetPassword(_ sender: Any) {
        dismiss(animated: true)
    }
}
