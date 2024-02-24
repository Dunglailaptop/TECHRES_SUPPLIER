//
//  CreateUnitSpecificationViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class CreateUnitSpecificationViewModel: BaseViewModel {
    private(set) weak var view: CreateUnitSpecificationViewController?
    private var router: CreateUnitSpecificationRouter?
    public var unitSpecification = BehaviorRelay<UnitSpecification>(value: UnitSpecification()!)
    public var ExchangeUnitSpecsList = BehaviorRelay<[ExchangeUnitSpecification]>(value: [])
    
    func bind(view: CreateUnitSpecificationViewController, router: CreateUnitSpecificationRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
}


extension CreateUnitSpecificationViewModel{
    func getExchangeUnitSpecsList() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getExchangeUnitSpecsList)
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func CreateMaterialUnitSpecification() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(
            .postCreateMaterialUnitSpecs(
                assign_to_unit_id: unitSpecification.value.assign_to_unit_id,
            material_unit_specification_exchange_name_id: unitSpecification.value.material_unit_specification_exchange_name_id,
            name: unitSpecification.value.name,
            exchange_value: unitSpecification.value.exchange_value
            ))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func updateMaterialUnitSpecs() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.postUpdateMaterialUnitSpecs(id: unitSpecification.value.id, name: unitSpecification.value.name, exchange_value: unitSpecification.value.exchange_value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
