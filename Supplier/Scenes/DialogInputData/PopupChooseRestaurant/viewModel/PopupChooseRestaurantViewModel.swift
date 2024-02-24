//
//  PopupChooseRestaurantViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 09/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit
import RxRelay
import RxSwift
class PopupChooseRestaurantViewModel: BaseViewModel {
    private(set) weak var view: PopupChooseRestaurantViewController?
    
    
    var dataArray = BehaviorRelay<[Restaurant]>(value:[])
    
    
    var selectedData = BehaviorRelay<(
        restaurant:Restaurant,
        brand:Restaurant,
        branch:Restaurant)>(value:(restaurant:Restaurant(),brand:Restaurant(),branch:Restaurant()))
    
    var keySearch = BehaviorRelay<String>(value:"")
    var pagination = BehaviorRelay<(limit:Int, page:Int, totalRecord:Int,isGetFullData:Bool)>(value: (limit:10, page:1, totalRecord:0,isGetFullData:false))

    
    
    func bind(view: PopupChooseRestaurantViewController){
        self.view = view
    }
    
    func clearDataAndCallAPI(){
        dataArray.accept([])
        pagination.accept((limit:10, page:1, totalRecord:0,isGetFullData:false))
        
        switch view!.popupType{
            case .restaurant:
                view?.getRestaurantList()
            case .brand:
                view?.getBrandList()
            case .branch:
                view?.getBranchList()
            default:
                return
        }
    }


}

extension PopupChooseRestaurantViewModel{
    func getRestaurantList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: ACTIVE, limit: pagination.value.limit, page: pagination.value.page, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getBrandList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBrandsCustomer(restaunrant_id: selectedData.value.restaurant.id, limit: pagination.value.limit, page: pagination.value.page, status: ACTIVE, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getBranchList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBranchesCustomer(status: ACTIVE, restaurant_id: selectedData.value.restaurant.id, restaurant_brand_id: selectedData.value.brand.id, limit: pagination.value.limit, page: pagination.value.page, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
