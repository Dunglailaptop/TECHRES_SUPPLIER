//
//  DialogChooseCategoryViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DialogChooseCategoryViewModel: BaseViewModel {

    private(set) weak var view: DialogChooseCategoryViewController?
    
    public var objectArray:BehaviorRelay<[GeneralObject]> = BehaviorRelay(value: [])
    public var fullObjectArray:BehaviorRelay<[GeneralObject]> = BehaviorRelay(value: [])
    
    
    

    
    var selectedRestaurant = BehaviorRelay<GeneralObject>(value:GeneralObject()!)
    var selectedBrand = BehaviorRelay<GeneralObject>(value:GeneralObject()!)
    var selectedBranch = BehaviorRelay<GeneralObject>(value:GeneralObject()!)
    
    
    var keySearch = BehaviorRelay<String>(value:"")
    var pagination = BehaviorRelay<(limit:Int, page:Int, totalRecord:Int,isGetFullData:Bool)>(value: (limit:10, page:1, totalRecord:0,isGetFullData:false))
 
    func bind(view: DialogChooseCategoryViewController){
        self.view = view
    }


}
//MARK: define API
extension DialogChooseCategoryViewModel{
    func getAllCategoryItems() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getAllCategoryMaterial(status: 1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }

    func getAllMaterialMeasureUnits() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getAllMaterialMeasureUnits)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    
    func getRestaurantList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getlistRestaurant(status: ACTIVE, limit: pagination.value.limit, page: pagination.value.page, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getBrandList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBrandsCustomer(restaunrant_id: selectedRestaurant.value.id, limit: pagination.value.limit, page: pagination.value.page, status: ACTIVE, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getBranchList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListBranchesCustomer(status: ACTIVE, restaurant_id: selectedRestaurant.value.id, restaurant_brand_id: selectedBrand.value.id, limit: pagination.value.limit, page: pagination.value.page, key_search: keySearch.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    
}
