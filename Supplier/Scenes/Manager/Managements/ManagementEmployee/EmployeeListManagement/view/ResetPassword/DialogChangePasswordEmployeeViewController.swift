//
//  DialogChangePasswordEmployeeViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChangePasswordEmployeeViewController: BaseViewController {
    
   
    @IBOutlet weak var lbl_tittle: UILabel!
    
    @IBOutlet weak var view_button: UIStackView!
    @IBOutlet weak var lbl_note_noty: UILabel!
    var viewModel = EmployeeListManagementViewModel()
    var delegate:ResetPasswordDelegate?
    
    var employeeId = 0
    var type = 0
    var usernames = ""
    var time: Timer?
    var note_noty = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dLog(employeeId)
        viewModel.IdEmployeeReset.accept(employeeId)
        setup()
    }

    @IBAction func btn_action_cancel(_ sender: Any) {
        dismiss(animated: true)
        
    }
    
    func setup() {
        if type == 1 {
            lbl_tittle.text = "XÁC NHẬN RESET MẬT KHẨU"
            lbl_note_noty.text = "Bạn có muốn reset mật khẩu của nhân viên này không?"
        }else if type == 0  {
          
            view_button.isHidden = true
            lbl_tittle.text = "THÔNG BÁO"
            let username = usernames // Replace "YOUR_USERNAME" with the actual username
            let normalText = note_noty
            let boldText = username // This is the part you want to make bold
            let lbl_note_text = "\(normalText) \(boldText) thành công"
            let attributedText = NSMutableAttributedString(string: lbl_note_text)
            let usernameRange = (lbl_note_text as NSString).range(of: boldText)
            attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: usernameRange)
            lbl_note_noty.attributedText = attributedText
            time = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
            

        }
    }
    
    @objc func timerFired() {
           dismiss(animated: true)
       }

       // Don't forget to invalidate the timer when you're done with it, typically in the deinitializer or when you no longer need it.
       deinit {
           time?.invalidate()
       }
    
    
    @IBAction func btn_action_access(_ sender: Any) {
        type == 1 ? self.ResetEmployee() : dismiss(animated: true)
    }
    
}
