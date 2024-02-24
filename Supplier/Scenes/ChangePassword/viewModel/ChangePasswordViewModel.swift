//
//  ChangePasswordViewModel.swift
//  Seemt
//
//  Created by Kelvin on 08/04/2023.
//

import UIKit
import RxRelay
import RxSwift
import CoreFoundation

class ChangePasswordViewModel:BaseViewModel{
    private(set) weak var view: ChangePasswordViewController?
    private var router: ChangePasswordRouter?    
    var oldPassword = BehaviorRelay<String>(value: "")
    var newPassword = BehaviorRelay<String>(value: "")
    var reEnterNewPassword = BehaviorRelay<String>(value: "")
    
    
    var isOldPasswordValid: Observable<Bool>{
        return self.oldPassword.asObservable().map{
          [self] (oldPassword) in
            
            view!.text_field_old_password.keyboardType = .asciiCapable
//            view?.text_field_old_password.text = Utils.blockSpace(oldPassword)
            view?.text_field_old_password.text = Utils().processString(input: oldPassword)
            if (oldPassword.count < Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin){
                view?.lbl_notification_old_pwd.text = String(format: "* Mật Khẩu phải có tối thiểu %d ký tự",Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin)
                return false
            }else if (oldPassword.count > 8){
                view?.lbl_notification_old_pwd.text = String(format: "* Mật Khẩu phải có tối đa %d ký tự", 8)
                return false
            }
            view?.lbl_notification_old_pwd.text = ""
            return true
        }
    }

    var isNewPasswordValid: Observable<Bool>{
        return self.newPassword.asObservable().map{
            [self] (newPassword) in
            view?.text_field_new_password.keyboardType = .asciiCapable
            view?.text_field_new_password.text = Utils.blockSpace(newPassword)
            if (newPassword.count < Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin){
                view?.lbl_notification_new_pwd.text = String(format: "* Mật Khẩu phải có tối thiểu %d ký tự",Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin)
                return false
            }else if (newPassword.count > 8){
                view?.lbl_notification_new_pwd.text = String(format: "* Mật Khẩu phải có tối đa %d ký tự",8)
                return false
            }else {
                view?.lbl_notification_new_pwd.text = ""
                if(!self.reEnterNewPassword.value.isEmpty && newPassword != self.reEnterNewPassword.value){
                    view?.lbl_notification_new_pwd.text = "Mật khẩu không trùng khớp"
                    return false
                }
                            
                if(!self.reEnterNewPassword.value.isEmpty && newPassword == self.reEnterNewPassword.value){
                    view?.lbl_notification_new_pwd.text = ""
                    return true
                }
                
                if (self.oldPassword.value != "" && newPassword == self.oldPassword.value){
                    view?.lbl_notification_new_pwd.text = "Mật khẩu mới không được trùng với mật khẩu cũ"
                    return false
                }
            }
            view?.lbl_notification_re_enter_new_pwd.text = ""
            return true
        }
    }

    var isReEnterNewPasswordValid: Observable<Bool>{
        return self.reEnterNewPassword.asObservable().map(){
            [self] (reEnterNewPassword) in
            view?.text_field_re_enter_new_password.keyboardType = .asciiCapable
            view?.text_field_re_enter_new_password.text = Utils.blockSpace(reEnterNewPassword)
            if (reEnterNewPassword.count < Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin){
                view?.lbl_notification_re_enter_new_pwd.text = String(format: "Mật Khẩu phải có tối thiểu %d ký tự",Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin)
                return false
            }else if (reEnterNewPassword.count > 8){
                view?.lbl_notification_re_enter_new_pwd.text = String(format: "Mật Khẩu phải có tối đa %d ký tự",8)
                return false
            }else {
                view?.lbl_notification_re_enter_new_pwd.text = ""
                if(reEnterNewPassword != self.newPassword.value){
                    view?.lbl_notification_re_enter_new_pwd.text = "Mật khẩu không trùng khớp"
                    return false
                }
                if (self.newPassword.value.isEmpty && reEnterNewPassword == self.newPassword.value){
                    view?.lbl_notification_re_enter_new_pwd.text = ""
                    return true
                }
            }
            view?.lbl_notification_re_enter_new_pwd.text = ""
            return true
        }
    }
    
    var isValid: Observable<Bool>{
        return Observable.combineLatest(isOldPasswordValid, isNewPasswordValid, isReEnterNewPasswordValid){ $0 && $1 && $2 }
    }

    func bind(view: ChangePasswordViewController, router: ChangePasswordRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
    func makeMainViewController(){
        router?.navigateToMainViewController()
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    let emojiRegex = #"[^\p{ASCII}]"#
    func containsEmoji(text: String) -> Bool {
        return text.range(of: emojiRegex, options: .regularExpression) != nil
    }


   
}
// MARK: CALL API HERE ....
extension ChangePasswordViewModel{
    func changePassword() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.ChangePassword(oldPassword: oldPassword.value, new_password: newPassword.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
