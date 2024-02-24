//
//  EnterOTPViewModel.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 02/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class EnterOTPViewModel: BaseViewModel{
    private (set) weak var view: EnterOTPViewController?
    private var router: EnterOTPRouter?

    var OTPCode = BehaviorRelay<String>(value: "")
    var restaurant_brand_name = BehaviorRelay<String>(value: "")
    var username = BehaviorRelay<String>(value: "")
    var sessionString = BehaviorRelay<String>(value: "")
    var timeToLockOPTEnterView = BehaviorRelay<Int>(value: 0)
    func bind(view:EnterOTPViewController, router: EnterOTPRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateLoginViewController()
    }
  
    func makeUpdatePasswordViewController(){
        router?.navigateToUpdatePasswordViewController(username:username.value
                                                       ,verifyCode: OTPCode.value, restaurant_brand_name:restaurant_brand_name.value)
    }
        
}

extension EnterOTPViewModel{
    func verifyCode() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.verifyCode(supplier_name: restaurant_brand_name.value, user_name: username.value, verify_code: OTPCode.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    
    
    
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
        return appServiceProvider.rx.request(.forgotPassword(username: username.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    
}
