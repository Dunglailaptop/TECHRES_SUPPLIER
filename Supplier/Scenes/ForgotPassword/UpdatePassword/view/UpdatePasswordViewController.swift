//
//  NewPasswordViewController.swift
//  Seemt
//
//  Created by Pham Khanh Huy on 07/04/2023.
//

import UIKit
import RxSwift
import RxRelay
import JonAlert
import ObjectMapper
class UpdatePasswordViewController: BaseViewController,UITextFieldDelegate {
    var viewModel = UpdatePasswordViewModel()
    var router = UpdatePasswordRouter()
    var verifyCode = ""
    var username = ""
    var restaurant_brand_name = ""
    var iconClick = true
    
    
    @IBOutlet weak var text_field_new_password: UITextField!
    @IBOutlet weak var lbl_notification_new_password: UILabel!
    @IBOutlet weak var btn_show_new_password: UIButton!
    
    @IBOutlet weak var text_field_re_enter_new_password: UITextField!
    @IBOutlet weak var lbl_notification_re_enter_new_password: UILabel!
    
    @IBOutlet weak var btn_show_reEnter_new_password: UIButton!
    
    
    @IBOutlet weak var btn_update_password: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dLog(restaurant_brand_name)
        viewModel.verify_code.accept(verifyCode)
        viewModel.username.accept(username)
        viewModel.restaurant_brand_name.accept(restaurant_brand_name)
        viewModel.bind(view: self, router: router)
        
        _ = text_field_new_password.rx.text.map{$0 ?? ""}.bind(to: viewModel.newPassword)
        _ = text_field_re_enter_new_password.rx.text.map{$0 ?? ""}.bind(to: viewModel.reEnterNewPassword)
        
        viewModel.isNewPasswordValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            self!.lbl_notification_new_password.isHidden = isValid ? true : false

        })

        viewModel.isReEnterNewPasswordValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            self!.lbl_notification_re_enter_new_password.isHidden = isValid ? true : false

        })

        viewModel.isValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            var reEnterNewPassword = self!.viewModel.reEnterNewPassword.value
            var newPassword = self!.viewModel.newPassword.value
            self!.enableBtnUpdatePassword(condition: isValid && reEnterNewPassword == newPassword)

        })
        
        lbl_notification_new_password.isHidden = true
        lbl_notification_re_enter_new_password.isHidden = true
       
        
        text_field_new_password.delegate = self
        text_field_new_password.addTarget(self, action:#selector(textFieldDidEndEditing(_:)), for: .editingChanged)
        text_field_re_enter_new_password.delegate = self
        text_field_re_enter_new_password.addTarget(self, action:#selector(textFieldDidEndEditingReEnterNewPassword(_:)), for: .editingChanged)
    }

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makeLoginViewController()
    }
    
    private func enableBtnUpdatePassword(condition:Bool){
 
        if condition == true{
            btn_update_password.backgroundColor = UIColor(hex: "C7D9EC")
            btn_update_password.setTitleColor(UIColor(hex: "1462B0"), for: .normal)
            btn_update_password.isEnabled = true
        }else{
            btn_update_password.backgroundColor = UIColor(hex: "C5C6C9")
            btn_update_password.setTitleColor(UIColor(hex: "FFFFFF"), for: .normal)
            btn_update_password.isEnabled = false
        }
        
    }
   
    
    
    @objc func textFieldDidEndEditing(_ textField: UITextField){
        var ReEnterNewPassword = viewModel.reEnterNewPassword.value
        enableBtnUpdatePassword(
            condition:!ReEnterNewPassword.isEmpty && textField.text == ReEnterNewPassword
            ? true : false)
        
    
    }
    
    @objc func textFieldDidEndEditingReEnterNewPassword(_ textField: UITextField) {
        var newPassword = viewModel.newPassword.value
        

        enableBtnUpdatePassword(
            condition:!newPassword.isEmpty && textField.text == newPassword
            ? true : false)
    }
    
    
    @IBAction func actionUpdatePassword(_ sender: Any) {
        getSession()
    }
    
    @IBAction func actionShowNewPassword(_ sender: Any) {
        text_field_new_password.becomeFirstResponder()
        text_field_new_password.isSecureTextEntry = iconClick == true ? true : false
        btn_show_new_password.setImage(UIImage(named: iconClick ? "icon_eye_pass" : "eye" ), for: .normal)
        iconClick = !iconClick
    }
    
    
    @IBAction func actionShowReEnterNewPassword(_ sender: Any) {
        text_field_re_enter_new_password.becomeFirstResponder()
        text_field_re_enter_new_password.isSecureTextEntry = iconClick ? true : false
        btn_show_reEnter_new_password.setImage(UIImage(named: iconClick ? "icon_eye_pass" : "eye" ), for: .normal)
        iconClick = !iconClick
    }

}

