//
//  DetailCompleteOrderViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailCompleteOrderViewModel: BaseViewModel {
    
    private(set) weak var view: DetailCompleteOrderViewController?
    private var router: DetailCompleteOrderRouter?
    
    public var id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "4,6,7")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 100)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    public var dataArray : BehaviorRelay<[SupplierOrdersDetailResponse]> = BehaviorRelay(value:[])
    public var dataArrayMaterial : BehaviorRelay<[SupplierOrdersDetailResponse]> = BehaviorRelay(value:[])
    public var dataDetail : BehaviorRelay<SupplierOrders> = BehaviorRelay(value: SupplierOrders.init())
    
    public var warehouse_session_status : BehaviorRelay<Int> = BehaviorRelay(value: 0)
        
    func bind(view: DetailCompleteOrderViewController, router: DetailCompleteOrderRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
}

// MARK: Call API
extension DetailCompleteOrderViewModel{
    func getDetailSupplierOrders() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierOrders(id: view?.dataDetail.id ?? 0, status: status.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
