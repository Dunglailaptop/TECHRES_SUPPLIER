//
//  UnitManagementViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class UnitManagementViewModel: BaseViewModel {
    private(set) weak var view: UnitManagementViewController?
    private var router: UnitManagementRouter?
    var closure:BehaviorRelay<() -> Void> = BehaviorRelay(value: {})
    var status = BehaviorRelay<Int>(value: -1)
    var unitId = BehaviorRelay<Int>(value: -1)
    var key_search = BehaviorRelay<String>(value: "")
    var dataArray = BehaviorRelay<[MaterialUnit]>(value: [])
    var dataFilter = BehaviorRelay<[MaterialUnit]>(value: [])
    
    
    
    func bind(view: UnitManagementViewController, router: UnitManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeCreateMaterialUnitViewController(materialUnit:MaterialUnit = MaterialUnit()!,isAllowToEdit:Bool = true){
        router?.navigateToCreateMaterialUnitViewController(materialUnit: materialUnit,isAllowEdit: isAllowToEdit)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//MARK:call API
extension UnitManagementViewModel{
    
    func getMaterialUnitList() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getMaterialUnitList(status: status.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func changeMaterialUnitStatus() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.postChangeMaterialUnitStatus(id: unitId.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
