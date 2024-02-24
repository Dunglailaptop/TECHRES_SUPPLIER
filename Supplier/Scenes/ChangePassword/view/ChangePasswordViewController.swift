//
//  ChangePasswordViewController.swift
//  Seemt
//
//  Created by Kelvin on 08/04/2023.
//

import UIKit
import RxSwift
import RxRelay
class ChangePasswordViewController: BaseViewController {
    var viewModel = ChangePasswordViewModel()
    var router = ChangePasswordRouter()
    @IBOutlet weak var text_field_old_password: UITextField!
    @IBOutlet weak var text_field_new_password: UITextField!
    @IBOutlet weak var text_field_re_enter_new_password: UITextField!
    @IBOutlet weak var btn_secure_old_pwd: UIButton!
    @IBOutlet weak var btn_secure_new_pwd: UIButton!
    @IBOutlet weak var btn_secure_re_enter_pwd: UIButton!
    @IBOutlet weak var btn_change_password: UIButton!
    
    @IBOutlet weak var lbl_notification_old_pwd: UILabel!
    @IBOutlet weak var lbl_notification_new_pwd: UILabel!
    @IBOutlet weak var lbl_notification_re_enter_new_pwd: UILabel!
    
    @IBOutlet weak var update_btn_view: UIView!
    
    var type = 0
    var delegate: DialogResetPassword?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dLog(ManageCacheObject.getCurrentUser())
        viewModel.bind(view: self, router: router)
        _ = text_field_old_password.rx.text.map{ $0 ?? "" }.bind(to:viewModel.oldPassword)
        _ = text_field_new_password.rx.text.map{ $0 ?? "" }.bind(to:viewModel.newPassword)
        _ = text_field_re_enter_new_password.rx.text.map{ $0 ?? ""}.bind(to:viewModel.reEnterNewPassword)
        

        
        _ = viewModel.isValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            dLog(isValid)

            self?.enable(condition: isValid ? true: false)
         
            
        })
   
        
        _ = viewModel.isOldPasswordValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else {return}
//            self?.enable(condition: isValid ? true: false)
            if strongSelf.text_field_old_password.isEditing{
                self!.lbl_notification_old_pwd.isHidden = isValid && strongSelf.text_field_old_password.isEditing
            }else{
                self!.lbl_notification_old_pwd.isHidden = true
              
            }
        })
        
        _ = viewModel.isNewPasswordValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else {return}
//            self?.enable(condition: isValid ? true: false)
            if strongSelf.text_field_new_password.isEditing{
                self!.lbl_notification_new_pwd.isHidden = isValid && strongSelf.text_field_old_password.isEditing
            }else{
                self!.lbl_notification_new_pwd.isHidden = true
                
            }
        })
        
        _ = viewModel.isReEnterNewPasswordValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else {return}
            self?.enable(condition: isValid ? true: false)
            
            if strongSelf.text_field_re_enter_new_password.isEditing{
                self!.lbl_notification_re_enter_new_pwd.isHidden = isValid && strongSelf.text_field_old_password.isEditing
            }else{
                self!.lbl_notification_re_enter_new_pwd.isHidden = true
               
            }
            
        })

    
        
//        text_field_re_enter_new_password.delegate = self
//        text_field_re_enter_new_password.addTarget(self, action:#selector(textFieldDidEndEditing(_:)), for: .editingChanged)

    }

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionSeePassword(_ sender: Any) {
        text_field_old_password.isSecureTextEntry = !text_field_old_password.isSecureTextEntry
        if(text_field_old_password.isSecureTextEntry){
            btn_secure_old_pwd.setImage(UIImage(named:"icon_eye_pass"), for: .normal)
        }else {
            var image = UIImage(named:"eye")?.withTintColor(ColorUtils.black(),renderingMode: .alwaysOriginal)
            btn_secure_old_pwd.setImage(image, for: .normal)
        }
    }
    
    @IBAction func actionSeeNewPassword(_ sender: Any) {
        text_field_new_password.isSecureTextEntry = !text_field_new_password.isSecureTextEntry
        if(text_field_new_password.isSecureTextEntry){
            btn_secure_new_pwd.setImage(UIImage(named:"icon_eye_pass"), for: .normal)
        }else {
            var image = UIImage(named:"eye")?.withTintColor(ColorUtils.black(),renderingMode: .alwaysOriginal)
            btn_secure_new_pwd.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func actionSeeReEnterPassword(_ sender: Any) {
        text_field_re_enter_new_password.isSecureTextEntry = !text_field_re_enter_new_password.isSecureTextEntry
        if(text_field_re_enter_new_password.isSecureTextEntry){
            btn_secure_re_enter_pwd.setImage(UIImage(named:"icon_eye_pass"), for: .normal)
        }else {
            var image = UIImage(named:"eye")?.withTintColor(ColorUtils.black(),renderingMode: .alwaysOriginal)
            btn_secure_re_enter_pwd.setImage(image, for: .normal)
        }
    }
    
    
    @IBAction func actionChangePassword(_ sender: Any) {
        changePassword()
    }
    
    



    private func enable(condition: Bool){
        if condition {
            self.btn_change_password.isEnabled = true
            self.update_btn_view.backgroundColor = ColorUtils.blueButton()
        }else {
            self.btn_change_password.isEnabled = false
            self.update_btn_view.backgroundColor = ColorUtils.grayColor()
        }
    }
}




