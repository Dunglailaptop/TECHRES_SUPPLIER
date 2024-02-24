//
//  EmployeeListManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class EmployeeListManagementViewModel: BaseViewModel {

    private(set) weak var view: EmployeeListManagementViewController?
    private var router: EmployeeListManagementRouter?
    
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var employee_role_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var is_working : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var idLock : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var is_quit_job : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var IdEmployeeReset: BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    public var node_access_token : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)

    public var dataArray : BehaviorRelay<[Account]> = BehaviorRelay(value: [])
    public var pagination = BehaviorRelay<(limit: Int, page: Int,total_record:Int,isGetFullData:Bool,isAPICalling:Bool)>(value: (limit:20,page:1,total_record:0,isGetFullData:false,isAPICalling:false))
    
    func bind(view: EmployeeListManagementViewController, router: EmployeeListManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }
    
    func clearDataAndCallAPI(){
        dataArray.accept([])
        var clonePagination = pagination.value
        clonePagination.page = 1
        clonePagination.isGetFullData = false
        clonePagination.isAPICalling = true
        pagination.accept(clonePagination)
        view!.getEmployees()
    }
    
    
    func makeDetailEmployeeViewController(employeeList:Account=Account(),isAllowEditing:Bool=false){
        router?.navigateToDetailEmployeeViewController(employeeList:employeeList, isAllowEditing: isAllowEditing)
    }
    
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//MAKR : CALL API
extension EmployeeListManagementViewModel{
    func getEmployees() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.employees(status: status.value,key_search: key_search.value,limit: pagination.value.limit,page: pagination.value.page))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func lockEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.employeeLock(id: idLock.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    func unLockEmployee() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.employeeLock(id: idLock.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func resetPassword() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.resetPassword(IdEmployee: IdEmployeeReset.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
