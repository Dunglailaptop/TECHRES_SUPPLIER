//
//  ManagementCustomerViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import RxRelay

class ManagementCustomerViewModel: BaseViewModel {
    private(set) weak var view: ManagementCustomerViewController?
    private var router: ManagementCustomerRouter?
    
    public var dataArray: BehaviorRelay<[Restaurant]> = BehaviorRelay(value: [])
    public var key_search: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var limit: BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page: BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: ManagementCustomerViewController, router: ManagementCustomerRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func maketoManagemenDetailListCustomerViewController(restaurant: Restaurant){
        router?.navigationToManagementDetailCustomerViewController(restaurantInfo: restaurant)
    }
    
    func makePopToViewController() {
        router?.makePopToViewController()
    }
    
    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }
    
    func clearDataAndCallAPI(){
        clearData()
        view!.getRestaurant()
    }
}

extension ManagementCustomerViewModel {
    func getlistRestaurant() ->  Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: status.value, limit: limit.value, page: page.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
