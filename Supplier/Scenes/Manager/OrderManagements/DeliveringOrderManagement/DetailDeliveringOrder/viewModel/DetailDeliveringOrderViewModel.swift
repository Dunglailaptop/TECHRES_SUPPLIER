//
//  DetailDeliveringOrderViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailDeliveringOrderViewModel: BaseViewModel {
    
    private(set) weak var view: DetailDeliveringOrderViewController?
    private var router: DetailDeliveringOrderRouter?
    
    public var id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "3")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 100)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    public var dataArray : BehaviorRelay<[SupplierOrdersDetailResponse]> = BehaviorRelay(value:[])
    public var dataArrayMaterial : BehaviorRelay<[SupplierOrdersDetailResponse]> = BehaviorRelay(value:[])
    public var dataDetail : BehaviorRelay<SupplierOrders> = BehaviorRelay(value: SupplierOrders.init())
    
    public var warehouse_session_status : BehaviorRelay<Int> = BehaviorRelay(value: 0)
        
    func bind(view: DetailDeliveringOrderViewController, router: DetailDeliveringOrderRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
}

//MARK: Call API
extension DetailDeliveringOrderViewModel{
    func getDetailSupplierOrders() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierOrders(id: view?.dataDetail.id ?? 0, status: status.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
