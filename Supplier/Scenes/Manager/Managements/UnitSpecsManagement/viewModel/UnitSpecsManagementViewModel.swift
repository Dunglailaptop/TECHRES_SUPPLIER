//
//  UnitSpecsManagementViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class UnitSpecsManagementViewModel: BaseViewModel {
    private(set) weak var view: UnitSpecsManagementViewController?
    private var router: UnitSpecsManagementRouter?
    var closure:BehaviorRelay<() -> Void> = BehaviorRelay(value: {})
    var status = BehaviorRelay<Int>(value: -1)
    var unitSpecificationId = BehaviorRelay<Int>(value: -1)
    var key_search = BehaviorRelay<String>(value: "")
    var dataArray = BehaviorRelay<[UnitSpecification]>(value: [])
    var dataFilter = BehaviorRelay<[UnitSpecification]>(value: [])
    
    func bind(view: UnitSpecsManagementViewController, router: UnitSpecsManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    func makeCreateUnitSpecificationViewController(unitSpecification:UnitSpecification = UnitSpecification()!){
        router?.navigateToCreateUnitSpecificationViewController(unitSpecification:unitSpecification)
    }
    
    
}
//MARK:call API
extension UnitSpecsManagementViewModel{
    
    func getMaterialUnitSpecifications() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getMaterialUnitSpecifications(status: status.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func changeMaterialUnitSpecsStatus() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.postChangeMaterialUnitSpecsStatus(id: unitSpecificationId.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func updateMaterialUnitSpecs() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.postUpdateMaterialUnitSpecs(id: unitSpecificationId.value, name: "", exchange_value: -1))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func createMateialUnitSpecs() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.postCreateMaterialUnitSpecs(
            assign_to_unit_id: -1,
            material_unit_specification_exchange_name_id: -1,
            name: "",
            exchange_value: -1)
        ).filterSuccessfulStatusCodes()
        .mapJSON().asObservable()
        .showAPIErrorToast()
        .mapObject(type: APIResponse.self)
    }
}
