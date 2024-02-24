//
//  DeliveringOrderManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DeliveringOrderManagementViewModel: BaseViewModel {
    
    private(set) weak var view: DeliveringOrderManagementViewController?
    private var router: DeliveringOrderManagementRouter?
    
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: ACTIVE)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    
    public var data : BehaviorRelay<RestaurantModel> = BehaviorRelay(value: RestaurantModel.init())
    public var dataArray : BehaviorRelay<[Restaurant]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: DeliveringOrderManagementViewController, router: DeliveringOrderManagementRouter){
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
        clearData()
        view!.getSupplierOrdersGroupsList()
    }
  
    func makeListDeliveringOrderViewController(restaurant_id: Int){
        router?.navigateToListDeliveringOrderViewController(restaurant_id: restaurant_id)
    }
}

// MARK: CALL API
extension DeliveringOrderManagementViewModel{
    func getlistRestaurant() ->  Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: status.value, limit: limit.value, page: page.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
