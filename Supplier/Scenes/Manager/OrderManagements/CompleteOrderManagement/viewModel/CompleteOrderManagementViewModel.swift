//
//  CompleteOrderManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class CompleteOrderManagementViewModel: BaseViewModel {
    
    private(set) weak var view: CompleteOrderManagementViewController?
    private var router: CompleteOrderManagementRouter?
    
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: ACTIVE)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    
    public var data : BehaviorRelay<RestaurantModel> = BehaviorRelay(value: RestaurantModel.init())
    public var dataArray : BehaviorRelay<[Restaurant]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: CompleteOrderManagementViewController, router: CompleteOrderManagementRouter){
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
        view!.getSupplierOrdersList()
    }
  
    func makeListCompleteOrderViewController(restaurant_id: Int){
        router?.navigateToListCompleteOrderViewController(restaurant_id: restaurant_id)
    }
}

//MARK: CALL API
extension CompleteOrderManagementViewModel{
    func getlistRestaurant() ->  Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: status.value, limit: limit.value, page: page.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
