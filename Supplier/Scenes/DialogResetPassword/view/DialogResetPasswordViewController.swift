//
//  DialogResetPasswordViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 13/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogResetPasswordViewController: BaseViewController {

    @IBOutlet weak var lbl_button: UILabel!
   
    @IBOutlet weak var lbl_noty: UILabel!
    
    @IBOutlet weak var lbl_note: UILabel!
    
    @IBOutlet weak var note_descript: UILabel!
    var type = 0
    
    var viewModel = DialogResetPasswordViewModel()
    var router = DialogResetPasswordRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess(_:)), name: NSNotification.Name("success"), object: nil)

    }

    @objc func loginSuccess(_ notification: UNUserNotificationCenter) {
        view.reloadInputViews()
       lbl_note.text = "Đổi Mật Khẩu Thành Công"
        note_descript.text = "Vui Lòng Đăng Nhập Lại"
        type = 1
        lbl_button.text = "ĐĂNG SUẤT"
        
    }

    
   
    @IBAction func btn_makeToChangePasswordViewController(_ sender: Any) {
        if type == 1 {
            self.logout()
        }else
        {
     
            viewModel.makeToChangePasswordViewController()
            
        }
       
    }
    
}
