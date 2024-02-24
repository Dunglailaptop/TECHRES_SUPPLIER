//
//  UpdatePasswordViewModel.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class UpdatePasswordViewModel: BaseViewModel {
    private (set) weak var view: UpdatePasswordViewController?
    private var router: UpdatePasswordRouter?
    var sessionString = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    var restaurant_brand_name = BehaviorRelay<String>(value: "")
    var verify_code = BehaviorRelay<String>(value: "")
    var newPassword = BehaviorRelay<String>(value: "")
    var reEnterNewPassword = BehaviorRelay<String>(value: "")
    func bind(view:UpdatePasswordViewController, router: UpdatePasswordRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
    var isNewPasswordValid:Observable<Bool> {
        return newPassword.asObservable().map{[self] newPassword in
            if(newPassword.count < 4 || newPassword.count > 20){
                view?.lbl_notification_new_password.text = "Mật khẩu nhập lại chỉ từ 4 đến 20 ký tự"
                return false
            }else {
                if(containsEmoji(text: newPassword)){
                    view?.lbl_notification_new_password.text = "Mật khẩu nhập lại không được chứa emoji"
                    return false
                }
                
                return true
            }
        }
    }
    
    var isReEnterNewPasswordValid:Observable<Bool>{
        return reEnterNewPassword.asObservable().map{[self] reEnterNewPassword in
            if(reEnterNewPassword.count < 4 || reEnterNewPassword.count > 20){
                view?.lbl_notification_re_enter_new_password.text = "Mật khẩu nhập lại chỉ từ 4 đến 20 ký tự"
                return false
            }else {
                if(containsEmoji(text: reEnterNewPassword)){
                    view?.lbl_notification_re_enter_new_password.text = "Mật khẩu nhập lại không được chứa emoji"
                    return false
                }
                
                return true
            }
        }
    }
    
    
    
    var isValid: Observable<Bool> {
      return Observable.combineLatest(isNewPasswordValid, isReEnterNewPasswordValid) {$0 && $1}

    }
    

    private func containsEmoji(text: String) -> Bool {
        let emojiRegex = #"[^\p{ASCII}]"#
        return text.range(of: emojiRegex, options: .regularExpression) != nil
    }
    

}

extension UpdatePasswordViewModel{
    
    func getSession() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.sessions)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func getConfig() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.config(supplier_name: restaurant_brand_name.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func updatePassword() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.verifyChangePassword(username: username.value, verify_code: verify_code.value, new_password: newPassword.value, node_access_token: "", device_uid: Utils.getUDID(), app_type: Utils.getAppType()))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}


