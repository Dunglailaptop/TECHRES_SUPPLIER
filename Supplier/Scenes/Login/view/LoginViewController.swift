//
//  LoginViewController.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit
import RxSwift
import LocalAuthentication

class LoginViewController: BaseViewController {

    public var viewModel = LoginViewModel()

    private var router = LoginRouter()
    
    // MARK: - IBOutlet -
    @IBOutlet fileprivate weak var text_field_supplier: UITextField!
    @IBOutlet  weak var text_field_password: UITextField!
    @IBOutlet fileprivate weak var btn_login: UIButton!
    @IBOutlet weak var text_field_username: UITextField!
    
    
    
    @IBOutlet weak var btn_hide_password: UIButton!
    @IBOutlet weak var view_biometric: UIView!
    @IBOutlet weak var image_biometric: UIImageView!
    @IBOutlet weak var btn_forgot_password: UIButton!
    
    
    
    @IBOutlet weak var lbl_noti_phone: UILabel!
    
    @IBOutlet weak var lbl_noti_pass: UILabel!
    
    @IBOutlet weak var lbl_noti_restaurant: UILabel!
    
    var sessions_str = ""
    
    
    // MARK: - Variable - User -
    var iconClick = false
    var context = LAContext()
    var err: NSError?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_field_supplier.keyboardType = .asciiCapable
        text_field_username.keyboardType = .asciiCapable
        text_field_password.keyboardType = .asciiCapable
        text_field_supplier.text = ManageCacheObject.getSupplierNameLogin()
        text_field_username.text = ManageCacheObject.getUsernameLogin()
        
        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: router)
        
        //bind value of textfield to variable of viewmodel
        _ = text_field_supplier.rx.text.map { $0 ?? "" }.bind(to: viewModel.supplierNameText)
        
        _ = text_field_username.rx.text.map { $0!.replacingOccurrences(of: " ", with: "") }.bind(to: viewModel.usernameText)
        
        _ = text_field_password.rx.text.map { $0 ?? "" }.bind(to: viewModel.passwordText)
        
    
        //  subscribe result of variable isValid in LoginViewModel then handle button login is enable or not?
        _ = viewModel.isValid.subscribe({ [weak self] isValid in
          
            guard let strongSelf = self, let isValid = isValid.element else { return }
           
            strongSelf.btn_login.backgroundColor = isValid ? UIColor(hex: "C7D9EC") : UIColor(hex: "C5C6C9")
            strongSelf.btn_login.setTitleColor(isValid ? UIColor(hex: "1462B0") : ColorUtils.gray_000(), for: .normal)
            strongSelf.btn_login.isEnabled = isValid ? true : false
        })
        
        _ = viewModel.isValidRestaurantName.subscribe({ [weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            strongSelf.text_field_supplier.text = String(self!.text_field_supplier.text!.prefix(51))
            strongSelf.text_field_supplier.text = Utils.blockSpace(self!.text_field_supplier.text!)
            if isValid{
                strongSelf.lbl_noti_restaurant.isHidden = true
            }else{
               if strongSelf.text_field_supplier.isEditing {
                    if (self!.text_field_supplier.text!.count > 50) {
                        strongSelf.lbl_noti_restaurant.text = "Tên nhà cung cấp tối đa 50 kí tự"
                        strongSelf.lbl_noti_restaurant.isHidden = false
                    }else if(self!.text_field_supplier.text!.count <= 2 ){
                        strongSelf.lbl_noti_restaurant.text = "Tên nhà cung cấp không thể nhỏ hơn 2 kí tự"
                        strongSelf.lbl_noti_restaurant.isHidden = false
                        if (self?.text_field_supplier.text?.count == 0) {
                            strongSelf.lbl_noti_restaurant.text = "Tên nhà cung cấp không được bỏ trống"
                        }
                    } else{
                        strongSelf.lbl_noti_restaurant.isHidden = true
                    }
                }
            
               
                
            }

        })
        
        
        _ = viewModel.isValidUsername.subscribe({ [weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            strongSelf.text_field_username.text = Utils.blockSpecialCharacters((strongSelf.text_field_username.text)!)
            strongSelf.text_field_username.text = Utils.blockSpace(strongSelf.text_field_username.text!)
            strongSelf.text_field_username.text = String((strongSelf.text_field_username.text?.prefix(11))!)
         
            if isValid{
                strongSelf.lbl_noti_phone.isHidden = true
            }else{
                if strongSelf.text_field_username.isEditing {
                    if (self!.text_field_username.text!.count > 10) {
                        strongSelf.lbl_noti_phone.text = "Tên tài khoản tối đa 10 kí tự"
                        strongSelf.lbl_noti_phone.isHidden = false
                    }else if(self!.text_field_username.text!.count <= 8){
                        strongSelf.lbl_noti_phone.text = "Tên tài khoản không thể nhỏ hơn 8 kí tự"
                        strongSelf.lbl_noti_phone.isHidden = false
                        if self?.text_field_username.text?.count == 0 {
                            strongSelf.lbl_noti_phone.text = "Tên tài khoản không được bỏ trống"
                        }
                    } else{
                        strongSelf.lbl_noti_phone.isHidden = true
                    }
                }
            }

        })
        
        _ = viewModel.isValidPassword.subscribe({ [weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            strongSelf.text_field_password.text = Utils().removeDiacriticsAndD(from: strongSelf.text_field_password.text!)
           
            strongSelf.text_field_password.text = String((strongSelf.text_field_password.text?.prefix(9))!)
            dLog(isValid)
            if isValid{
                strongSelf.lbl_noti_pass.isHidden = true
            }else{
                if strongSelf.text_field_password.isEditing {
                    if (self!.text_field_password.text!.count > 8){
                        strongSelf.lbl_noti_pass.isHidden = false
                        strongSelf.lbl_noti_pass.text = "Mật khẩu tối đa 8 kí tự"
                    } else if(self!.text_field_password.text!.count <= 4){
                        strongSelf.lbl_noti_pass.isHidden = false
                        strongSelf.lbl_noti_pass.text = "Mật khẩu không thể nhỏ hơn 4 kí tự"
                    } else{
                        strongSelf.lbl_noti_pass.isHidden = true
                    }
                }
              
            }

        })
        
        // set layout
            
        self.iconClick = false
        view_biometric.isHidden = true
        if ManageCacheObject.getBiometric() == "1"{
            if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &err){
                view_biometric.isHidden = false
                if context.biometryType == .faceID{
                    if #available(iOS 13.0, *) {
                        image_biometric.image = UIImage(systemName: "faceid")
                    } else {
                        // Fallback on earlier versions
                    }
                }else{
                    if #available(iOS 13.0, *) {
                        image_biometric.image = UIImage(systemName: "touchid")
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }else{
                UIAlertController.showAlert(title: nil, message: "Vân tay/Face ID chưa thiết lập")
            }

        }
        
        clearData()
        
       
    }
    
    
    @IBAction func actionShowPassword(_ sender: Any) {
        text_field_password.becomeFirstResponder()
    
        if(iconClick == true) {
            text_field_password.isSecureTextEntry = true
            btn_hide_password.setImage(UIImage(named: "icon_eye_pass"), for: .normal)
        } else {
            btn_hide_password.setImage(UIImage(named: "eye"), for: .normal)
            text_field_password.isSecureTextEntry = false
        }
        iconClick = !iconClick
    }
    
    @IBAction func actionLoginBiometric(_ sender: Any) {
        let localString =  "Biometric Authentication"
        if context.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &err){
            
            if ManageCacheObject.getUsername() == "" || ManageCacheObject.getPassword() == "" {
                let alert = UIAlertController(title: "THÔNG BÁO" , message: "Tính năng chỉ có thể sử dụng lần đăng nhập kế tiếp", preferredStyle:.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: localString){ [self]
                    (success, error) in
                    if success{

                        DispatchQueue.main.async {
                           
                            self.viewModel.isLoginFace = true
                            
                            // call api getSessions here...
                            self.getSessions()
                        }
                    }
                }
            }

        }
    }
    

    @IBAction func actionLogin(_ sender: Any) {
        // call api getSessions here...
        self.getSessions()
        ManageCacheObject.setUsernameLogin(text_field_username.text ?? "")
        ManageCacheObject.setSupplierNameLogin(text_field_supplier.text ?? "")
    }
    
    
    
    @IBAction func actionNavigateToForgotPassword(_ sender: Any) {
        viewModel.makeForgotPasswordViewController()
    }
    
    
    @IBAction func btn_showSigin(_ sender: Any) {
        self.presentModalDialogSignin()
    }
}


