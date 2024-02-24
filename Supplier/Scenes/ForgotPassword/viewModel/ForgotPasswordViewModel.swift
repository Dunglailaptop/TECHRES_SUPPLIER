//
//  ForgotPasswordViewModel.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 01/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class ForgotPasswordViewModel: BaseViewModel {
    private (set) weak var view: ForgotPasswordViewController?
    private var router: ForgotPasswordRouter?
    var sessionString = BehaviorRelay<String>(value: "")
    var restaurant_brand_name = BehaviorRelay<String>(value: "")
    var account = BehaviorRelay<String>(value: "")
    
    
    func bind(view:ForgotPasswordViewController, router: ForgotPasswordRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
    func makeEnterOTPViewController(){
        router?.navigateEnterOTPViewController(username: account.value, restaurant_brand_name: restaurant_brand_name.value)
    }
    
    
    
    var isBrandValid:Observable<Bool>{
        return restaurant_brand_name.asObservable().map{
            [self] (brand) in
            
            if(brand.isEmpty){
                view?.lbl_notification_brand.text = "Tên nhà cung cấp không được để trống"
                return false
            }else{
                if(brand.count < 2){
                    view?.lbl_notification_brand.text = "Tên nhà cung cấp phải có tối thiểu 2 ký tự"
                    return false
                }else if(brand.count > 50){
                    view?.lbl_notification_brand.text = "Tên nhà cung cấp chỉ được tối đa 50 ký tự"
                    return false
                }
                view?.text_field_brand.text = String(brand.prefix(50))

                return true
            }
        }
    }
    
    
    var isAccountValid:Observable<Bool>{
        return account.asObservable().map{
            [self] (account) in
            
            if(account.isEmpty){
                view?.lbl_notification_account.text = "Tài khoản không được để trống"
                return false
            }else{
                if(account.count < 8){
                    view?.lbl_notification_account.text = "Tài khoản phải có 8 đến 10 ký tự"
                    return false
                }else if (isSpaceExisting(str: account)){
                    view?.lbl_notification_account.text = "Tài khoản không được chứa khoảng trắng"
                    view?.text_field_account.text = String(account.prefix(10))
                    return false
                }
                view?.text_field_account.text = String(account.prefix(10))
                return true
            }
        }
    }
    
    var isValid:Observable<Bool>{
        return Observable.combineLatest(isBrandValid, isAccountValid){$0 && $1}
    }
    
    private func isSpaceExisting(str:String) -> Bool{
        return str.trimmingCharacters(in:.whitespaces).contains(" ")
    }
    
   
    
}



extension ForgotPasswordViewModel{
    
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
    
    
    func forgotPassword() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.forgotPassword(username: account.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
