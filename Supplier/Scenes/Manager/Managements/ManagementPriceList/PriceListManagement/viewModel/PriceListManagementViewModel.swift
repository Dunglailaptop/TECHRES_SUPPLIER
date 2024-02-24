//
//  PriceListManagementViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class PriceListManagementViewModel: BaseViewModel {
    private(set) weak var view: PriceListManagementViewController?
    private var router: PriceListManagementRouter?
    
    public var dateType:BehaviorRelay<String> = BehaviorRelay(value: "")
    public var from_date:BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date:BehaviorRelay<String> = BehaviorRelay(value: "")
    public var dataArray : BehaviorRelay<[Supplier]> = BehaviorRelay(value: [])
    public var key_search: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var pagination = BehaviorRelay<(limit: Int, page: Int,total_record:Int,isGetFullData:Bool,isAPICalling:Bool)>(value: (limit:20,page:1,total_record:0,isGetFullData:false,isAPICalling:false))
    
    func bind(view: PriceListManagementViewController, router: PriceListManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func ClearDataAndCallApi(){
        dataArray.accept([])
        var clonePagination = pagination.value
        clonePagination.page = 1
        clonePagination.isGetFullData = false
        clonePagination.isAPICalling = true
        pagination.accept(clonePagination)
        view?.getListSupplier()
    }
    
   
    
    func makePriceListDetailViewController(supplier:Supplier) {
        router?.navigateToPriceListDetailViewController(supplier: supplier)
    }
    func makePopViewController() {
        router?.navigationToPopViewController()
    }
}

extension PriceListManagementViewModel {
    func getListSupplier() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: ACTIVE, limit: pagination.value.limit, page: pagination.value.page, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
  
}
