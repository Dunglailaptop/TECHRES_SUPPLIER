//
//  DialogChooseRestaurantViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DialogFilterRestaurantBranchViewModel: BaseViewModel {
    
    private (set) weak var view: DialogFilterRestaurantBranchViewController?
    private var router: DialogFilterRestaurantBranchRouter?

    public var data_type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    public var dataRestaurant : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBrand : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBranch : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    
    public var restaurant_brand_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var restaurant_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: ACTIVE)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    
    public var data : BehaviorRelay<RestaurantModel> = BehaviorRelay(value: RestaurantModel.init())
    public var dataArray : BehaviorRelay<[Restaurant]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view:DialogFilterRestaurantBranchViewController, router: DialogFilterRestaurantBranchRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func clearData(){
//        dataArray.accept([])
        isGetFullData.accept(false)
    }
}

extension DialogFilterRestaurantBranchViewModel{
    func getRestaurantList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: status.value, limit: limit.value, page: page.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getBrandList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBrandsCustomer(restaunrant_id: restaurant_id.value, limit: limit.value, page: page.value, status: status.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getBranchList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBranchesCustomer(status: status.value, restaurant_id: restaurant_id.value, restaurant_brand_id: restaurant_brand_id.value, limit: limit.value, page: page.value, key_search: key_search.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
