//
//  DialogConfrimShowInfoViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogConfrimShowInfoViewController: UIViewController {

    
    @IBOutlet weak var lbl_tittle: UIView!
    var username = ""
    
    var delegate: DialogConfrimUpdateEmployee?
    
    @IBOutlet weak var lbl_note: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
        // Do any additional setup after loading the view.
    }

    func setup() {
        let username = username // Replace "YOUR_USERNAME" with the actual username
        let normalText = "Thông tin Nhân viên"
        let boldText = username // This is the part you want to make bold
        let lbl_note_text = "\(normalText) \(boldText) sẽ được cập nhật"
        let attributedText = NSMutableAttributedString(string: lbl_note_text)
        let usernameRange = (lbl_note_text as NSString).range(of: boldText)
        attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: usernameRange)
        lbl_note.attributedText = attributedText
    }
  
    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        delegate?.callBackDialogUpdateEmployee()
    }
    
}
