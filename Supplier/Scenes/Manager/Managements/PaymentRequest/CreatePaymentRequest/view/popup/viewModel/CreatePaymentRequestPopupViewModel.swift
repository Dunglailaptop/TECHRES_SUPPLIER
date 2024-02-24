//
//  CreatePaymentRequestPopupViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class CreatePaymentRequestPopupViewModel: BaseViewModel {
    private(set) weak var view: CreatePaymentRequestPopupViewController?
    
    
    var dataArray = BehaviorRelay<[Restaurant]>(value:[])
    
    
    var selectedData = BehaviorRelay<(
        restaurant:Restaurant,
        brand:Restaurant,
        branch:Restaurant)>(value:(restaurant:Restaurant(),brand:Restaurant(),branch:Restaurant()))
    
    
    
    
    var keySearch = BehaviorRelay<String>(value:"")
    var pagination = BehaviorRelay<(limit:Int, page:Int, totalRecord:Int,isGetFullData:Bool)>(value: (limit:10, page:1, totalRecord:0,isGetFullData:false))
    var popupType = BehaviorRelay<String>(value:"RESTAURANT")
    
    
    func bind(view: CreatePaymentRequestPopupViewController){
        self.view = view
    }
    
    func clearDataAndCallAPI(){
        dataArray.accept([])
        pagination.accept((limit:10, page:1, totalRecord:0,isGetFullData:false))
        switch popupType.value{
            case "RESTAURANT":
                view?.getRestaurantList()
            case "BRAND":
                view?.getBrandList()
            case "BRANCH":
                view?.getBranchList()
            default:
                return
        }
    }
    
    
}

extension CreatePaymentRequestPopupViewModel{
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
