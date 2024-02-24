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
class DialogChooseRestaurantViewModel: BaseViewModel {
    private (set) weak var view: DialogChooseRestaurantViewController?
    private var router: DialogChooseRestaurantRouter?
    
    /*
        dropDownType = 1 -> chọn nhà hàng
        dropDownType = 2 -> chọn thương hiệu
        dropDownType = 3 -> chọn chi nhánh
     */
    var dropDownType = BehaviorRelay<Int>(value:1)
    

    var selectedRestaurant = BehaviorRelay<Restaurant>(value:Restaurant())
    var selectedBrand = BehaviorRelay<Brand>(value:Brand())
    var selectedBranch = BehaviorRelay<Branches>(value: Branches())
    
    var listOfRestaurants = BehaviorRelay<[Restaurant]>(value:[])
    var listOfBrands = BehaviorRelay<[Brand]>(value:[])
    var listOfBranches = BehaviorRelay<[Branches]>(value:[])
    var keySearch = BehaviorRelay<String>(value:"")

    
    func bind(view:DialogChooseRestaurantViewController, router: DialogChooseRestaurantRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
}

extension DialogChooseRestaurantViewModel{
    func getRestaurantList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: ACTIVE, limit: 500, page: 1, key_search: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getBrandList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBrandsCustomer(restaunrant_id: selectedRestaurant.value.id, limit: 500, page: 1, status: ACTIVE, key_search: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getBranchList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBranchesCustomer(status: ACTIVE, restaurant_id: selectedRestaurant.value.id, restaurant_brand_id: selectedBrand.value.id, limit: 500, page: 1, key_search: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}

