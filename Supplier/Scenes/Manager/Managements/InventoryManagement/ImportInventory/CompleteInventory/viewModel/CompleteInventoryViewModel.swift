//
//  CompleteInventoryViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class CompleteInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: CompleteInventoryViewController?
    private var router: CompleteInventoryRouter?
    
    public var payment_status : BehaviorRelay<String> = BehaviorRelay(value: "2,3")
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var type : BehaviorRelay<String> = BehaviorRelay(value: "0,2")
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "2,3") // lấy status 2,3
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierWarehouseSessionsResponse> = BehaviorRelay(value: SupplierWarehouseSessionsResponse.init()!)
    public var dataArray : BehaviorRelay<[SupplierWarehouseSessions]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: CompleteInventoryViewController, router: CompleteInventoryRouter){
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
  
    func makeDetailCompleteInventoryViewController(idDetail: Int){
        router?.navigateToDetailCompleteInventoryViewController(idDetail: idDetail)
    }
}

//MARK: CALL API
extension CompleteInventoryViewModel{
    func getSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessions(status: status.value, type: type.value, payment_status: payment_status.value, limit: limit.value, page: page.value, key_search: key_search.value, from_date: from_date.value, to_date: to_date.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
