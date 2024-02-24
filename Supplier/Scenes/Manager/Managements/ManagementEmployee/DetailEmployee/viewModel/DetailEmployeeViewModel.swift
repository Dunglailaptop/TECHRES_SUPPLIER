//
//  DetailEmployeeViewModel.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import JonAlert

class DetailEmployeeViewModel: BaseViewModel {
    
    private(set) weak var view: DetailEmployeeViewController?
    private var router: DetailEmployeeRouter?
    var detailEmployee:BehaviorRelay<Account> = BehaviorRelay(value: Account())
    var dataSuplier:BehaviorRelay<[SupplierRole]> = BehaviorRelay(value: [])// model 
    public var employeeInfor = BehaviorRelay<DetailProfileEmployee>(value: DetailProfileEmployee())
    
    
    /*
        0 là dialog thông báo "Bạn có chắc chắn thêm nhân viên này không?"
        1 là dialog thông báo "Thêm mới nhân viên thành công"
     */
    var dialogType = BehaviorRelay<Int>(value: 0)
    //Dùng để lưu trữ thông tin account của nhân viên sau khi API tạo tài khoản run thành công
    var createdAccount = BehaviorRelay<Account>(value: Account())
    var isMessageShowing = BehaviorRelay<Bool>(value: false)
    var closure = BehaviorRelay<() -> Void>(value: {})
    var dateSuggestion = BehaviorRelay<SambagDatePickerResult>(value: SambagDatePickerResult())
    
    func bind(view: DetailEmployeeViewController, router: DetailEmployeeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
   
    
 
    
}

extension DetailEmployeeViewModel{
    func getDetailEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.employeInfo(employeeId: detailEmployee.value.id))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func getListRole() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getsupplierroles)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func getProfileUpdate()  -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postUpdateEmployeeProfile(
            avatar: employeeInfor.value.avatar,
            name: employeeInfor.value.name,
            identity_card: employeeInfor.value.identity_card,
            gender: employeeInfor.value.gender,
            phone: employeeInfor.value.phone,
            birthDate: employeeInfor.value.birthday,
            email: employeeInfor.value.email,
            address: employeeInfor.value.address,
            city_id: employeeInfor.value.city_id,
            district_id: employeeInfor.value.district_id,
            ward_id: employeeInfor.value.ward_id,
            supplier_role_id: employeeInfor.value.supplier_role_id))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
        
    }
    
    
    func createEmployee() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.createEmployee(DetailEmployeeNew: employeeInfor.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func UpdateEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.employeeUpdateInfo(id: detailEmployee.value.id, DetailEmployeeRequest: employeeInfor.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
