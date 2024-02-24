//
//  DetailImportedInventoryViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailImportedInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: DetailImportedInventoryViewController?
    private var router: DetailImportedInventoryRouter?
    
    public var type_select_input_money : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var type_select_input_quantity : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    // MARK: GET
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 1000)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierWarehouseSessions> = BehaviorRelay(value: SupplierWarehouseSessions.init())
    public var dataMaterial : BehaviorRelay<MaterialWarehouseSessionsResponse> = BehaviorRelay(value: MaterialWarehouseSessionsResponse.init()!)
    public var dataArrayMaterial : BehaviorRelay<[MaterialWarehouseSessions]> = BehaviorRelay(value:[])

    func bind(view: DetailImportedInventoryViewController, router: DetailImportedInventoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
}

//MARK: Call API
extension DetailImportedInventoryViewModel{
    
    // MARK: GET
    func getDetailSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierWarehouseSessions(id: view?.idDetail ?? 0))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func getSupplierWarehouseSessionsDetail() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessionsDetail(id: view?.idDetail ?? 0, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
