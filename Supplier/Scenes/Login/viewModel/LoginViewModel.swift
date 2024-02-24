//
//  LoginViewModel.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit
import RxSwift
import RxRelay
import Alamofire

class LoginViewModel {

    private(set) weak var view: LoginViewController?
    private var router: LoginRouter?
    private let disposeBag = DisposeBag()


    // Khai báo biến để hứng dữ liệu từ VC
    var usernameText = BehaviorRelay<String>(value: "")
    var passwordText = BehaviorRelay<String>(value: "")
    var supplierNameText = BehaviorRelay<String>(value: "")





    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)


    var isLoginFace = false

    var phone = ""
    var pass = ""
    var restaurant_name = ""
          
    // Khai báo viến Bool để lắng nghe sự kiện và trả về kết quả thoả mãn điều kiện
    var isValidUsername: Observable<Bool> {
          return self.usernameText.asObservable().map { username in
              username.count >= Constants.LOGIN_FORM_REQUIRED.requiredUserNameLengthMin &&
              username.count <= 10
          }
    }
       
      
       
      
    var isValidPassword: Observable<Bool> {
        return self.passwordText.asObservable().map {
          password in
          password.count <= 8 &&  password.count >= Constants.UPDATE_INFO_FORM_REQUIRED.requiredPasswordMin
        }
    }

    var isValidRestaurantName: Observable<Bool> {
        return self.supplierNameText.asObservable().map { restaurant_name in
           restaurant_name.count >= Constants.LOGIN_FORM_REQUIRED.requiredRestaurantMinLength &&
           restaurant_name.count <= Constants.LOGIN_FORM_REQUIRED.requiredRestaurantMaxLength
        }
    }
       
      
    // Khai báo biến để lắng nghe kết quả của cả 3 sự kiện trên

    var isValid: Observable<Bool> {
      return Observable.combineLatest(isValidUsername, isValidPassword, isValidRestaurantName) {$0 && $1 && $2}

    }



    func bind(view: LoginViewController, router: LoginRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(self.view)
    }
    
    func makeForgotPasswordViewController(){
        router?.navigateToForgotPasswordViewController()
    }
 
        

}
extension LoginViewModel{
  
    // get data from server by rxswift with alamofire
    func getSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.sessions)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    
    func getConfig() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.config(supplier_name:supplierNameText.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func setting() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.setting)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    
    // get data from server by rxswift with alamofire
    func registerDeviceUDID() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.registerDevice)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
       }
    
    func login() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.login(supplier_name:supplierNameText.value, username: isLoginFace ? ManageCacheObject.getUsername() : usernameText.value, password: isLoginFace ? ManageCacheObject.getPassword() : passwordText.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
       }
        
}
