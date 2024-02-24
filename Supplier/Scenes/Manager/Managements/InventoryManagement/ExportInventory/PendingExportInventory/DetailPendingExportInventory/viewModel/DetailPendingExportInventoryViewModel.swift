//
//  DetailPendingExportInventoryViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailPendingExportInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: DetailPendingExportInventoryViewController?
    private var router: DetailPendingExportInventoryRouter?
    
    // MARK: GET
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "3")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 1000)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierWarehouseSessions> = BehaviorRelay(value: SupplierWarehouseSessions.init())
    public var dataMaterial : BehaviorRelay<MaterialWarehouseSessionsResponse> = BehaviorRelay(value: MaterialWarehouseSessionsResponse.init()!)
    public var dataArrayMaterial : BehaviorRelay<[MaterialWarehouseSessions]> = BehaviorRelay(value:[])

    func bind(view: DetailPendingExportInventoryViewController, router: DetailPendingExportInventoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
}

//MARK: Call API
extension DetailPendingExportInventoryViewModel{
    
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
