//
//  ManagementListBranchesViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import RxRelay
 
class ManagementCustomerBrandViewModel:BaseViewModel {
    private(set) weak var view: ManagementCustomerBrandViewController?
    private var router: ManagementCustomerBrandRouter?
    
    public var status:BehaviorRelay<Int> = BehaviorRelay(value: ACTIVE)
    public var restaurant_id:BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var restaurant_brand_id:BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var limit:BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page:BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var key_search:BehaviorRelay<String> = BehaviorRelay(value: "")
    public var dataArray:BehaviorRelay<[Brand]> = BehaviorRelay(value: [])
  
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: ManagementCustomerBrandViewController, router: ManagementCustomerBrandRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeToManagementListBranchesCustomerViewController(BrandDetail: Brand) {
        router?.navigationToManagementListBranchesViewController(BrandDetail: BrandDetail)
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
        view!.getBrandCustomer()
    }
}

extension ManagementCustomerBrandViewModel{
    func getBrandCustomer() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBrandsCustomer(restaunrant_id: restaurant_id.value, limit: limit.value, page: page.value, status: status.value,key_search: key_search.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
