//
//  ReportDayOffViewModel.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailedItemsManagementViewModel: BaseViewModel {
    private(set) weak var view: DetailedItemsManagementViewController?
    private var router: DetailedItemsManagementRouter?
    
    
    public var item:BehaviorRelay<Material> = BehaviorRelay(value: Material())
    
    
    
    
    //=================================================================================================
    public var categories:BehaviorRelay<[MaterialCategory]> = BehaviorRelay(value: [])
    public var fullCategories:BehaviorRelay<[MaterialCategory]> = BehaviorRelay(value: [])
    //=================================================================================================
    public var measureUnits:BehaviorRelay<[MaterialMeasureUnit]> = BehaviorRelay(value: [])
    public var fullMeasureUnits:BehaviorRelay<[MaterialMeasureUnit]> = BehaviorRelay(value: [])
    //=================================================================================================
    public var measureUnitSpecifications:BehaviorRelay<[MaterialUnitSpecification]> = BehaviorRelay(value: [])
    public var fullMeasureUnitSpecifications:BehaviorRelay<[MaterialUnitSpecification]> = BehaviorRelay(value: [])
    
    /*
        type = 1 -> giá nhập
        type = 2 -> giá niêm yết
        type = 3 -> số lượng stock còn lại
        type = 4 -> tỉ lệ hao hụt
        type = 5 -> danh mục
        type = 6 -> đơn vị
     */
    public var inputType:BehaviorRelay<Int> = BehaviorRelay(value: 0)

    
    func bind(view: DetailedItemsManagementViewController, router: DetailedItemsManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//MAKR : CALL API
extension DetailedItemsManagementViewModel{
    func updateItem() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postUpdateMaterial(material: item.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
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
    
    
    func createItem() -> Observable<APIResponse> {
        var cloneItem = item.value
        cloneItem.status = 1
        item.accept(cloneItem)
        return appServiceProvider.rx.request(.postCreateMaterial(material: cloneItem))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    
    
}
