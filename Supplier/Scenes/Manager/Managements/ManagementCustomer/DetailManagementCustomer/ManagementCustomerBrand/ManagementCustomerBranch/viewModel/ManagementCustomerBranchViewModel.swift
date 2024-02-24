//
//  ManagementCustomerBranchViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxRelay
import RxCocoa
import RxSwift

class ManagementCustomerBranchViewModel:BaseViewModel {
    
    private(set) weak var view: ManagementCustomerBranchViewController?
    private var router: ManagementCustomerBranchRouter?
    
    public var status:BehaviorRelay<Int> = BehaviorRelay(value: ACTIVE)
    public var restaurant_id:BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var restaurant_brand_id:BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var limit:BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page:BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var key_search:BehaviorRelay<String> = BehaviorRelay(value: "")
    public var dataArray:BehaviorRelay<[Branches]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: ManagementCustomerBranchViewController, router: ManagementCustomerBranchRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
   
    func MakePopToViewController(){
        router?.makepopToViewController()
    }
    
    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }
    
    func clearDataAndCallAPI(){
        clearData()
        view!.getBranchCustomer()
    }
}

extension ManagementCustomerBranchViewModel {
    func getBranchCustomer() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBranchesCustomer(status: status.value, restaurant_id: restaurant_id.value, restaurant_brand_id: restaurant_brand_id.value, limit: limit.value, page: page.value, key_search: key_search.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
