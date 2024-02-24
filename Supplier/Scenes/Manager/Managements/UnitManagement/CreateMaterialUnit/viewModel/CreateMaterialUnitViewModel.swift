//
//  CreateMaterialUnitViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class CreateMaterialUnitViewModel: BaseViewModel {
    private(set) weak var view: CreateMaterialUnitViewController?
    private var router: CreateMaterialUnitRouter?
    public var newMaterialUnit = BehaviorRelay<MaterialUnit>(value: MaterialUnit()!)
    var unitSpecsList = BehaviorRelay<[UnitSpecification]>(value: [])

    
    
    func bind(view: CreateMaterialUnitViewController, router: CreateMaterialUnitRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    
    func getMaterialUnitSpecifications() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getMaterialUnitSpecifications(status: 1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func CreateMaterialUnit() -> Observable<APIResponse>{
        var unitSpecsList:[Int] = []
        for unitSpecs in self.unitSpecsList.value.filter{$0.isSelected == ACTIVE} {
            unitSpecsList.append(unitSpecs.id)
        }
        
        return appServiceProvider.rx.request(.postCreateMaterialUnit(name: newMaterialUnit.value.name, code: newMaterialUnit.value.code, description: newMaterialUnit.value.description, unit_specifications: unitSpecsList))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func updateMaterialUnit() -> Observable<APIResponse>{
        
        var unitSpecsList:[Int] = []
        for unitSpecs in self.unitSpecsList.value.filter{$0.isSelected == ACTIVE}{
            unitSpecsList.append(unitSpecs.id)
        }
        return appServiceProvider.rx.request(.postUpdateMaterialUnit(id: newMaterialUnit.value.id, name: newMaterialUnit.value.name, description: newMaterialUnit.value.description, specification_ids: unitSpecsList))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
