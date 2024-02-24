//
//  PendingInventoryViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class PendingInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: PendingInventoryViewController?
    private var router: PendingInventoryRouter?
    
    public var payment_status : BehaviorRelay<String> = BehaviorRelay(value: "0")
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var type : BehaviorRelay<String> = BehaviorRelay(value: "0")
    public var status : BehaviorRelay<String> = BehaviorRelay(value: String(Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.IN))
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierWarehouseSessionsResponse> = BehaviorRelay(value: SupplierWarehouseSessionsResponse.init()!)
    public var dataArray : BehaviorRelay<[SupplierWarehouseSessions]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: PendingInventoryViewController, router: PendingInventoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
    func clearDataAndCallAPI(){
        clearData()
        view!.getSupplierWarehouseSessions()
    }
  
    func makeDetailPendingInventoryViewController(idDetail: Int){
        router?.navigateToDetailPendingInventoryViewController(idDetail: idDetail)
    }
}

//MARK: CALL API
extension PendingInventoryViewModel{
    func getSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessions(status: status.value, type: type.value, payment_status: payment_status.value, limit: limit.value, page: page.value, key_search: key_search.value, from_date: from_date.value, to_date: to_date.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
