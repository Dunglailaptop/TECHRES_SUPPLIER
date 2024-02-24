//
//  DetailedPaymentRequestViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 23/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DetailedPaymentRequestViewModel: BaseViewModel {
    private(set) weak var view: DetailedPaymentRequestViewController?
    private var router: DetailedPaymentRequestRouter?
 
    public var detailedOrders = BehaviorRelay<[SupplierOrders]>(value: [])
    public var noteId = BehaviorRelay<Int>(value: 0)
    public var status = BehaviorRelay<Int>(value: 0)
        
    func bind(view: DetailedPaymentRequestViewController, router: DetailedPaymentRequestRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
 
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    

   

}

extension DetailedPaymentRequestViewModel{
    func getSupplierOrdersByIds() -> Observable<APIResponse> {
       var supplier_order_ids =  view?.supplier_order_ids.map{String($0)}.reduce("") { (result, element) in
               result + element +  ","
        }
        supplier_order_ids = String(supplier_order_ids!.dropLast())
        
        return appServiceProvider.rx.request(.getSupplierOrdersByIds(supplier_order_ids: supplier_order_ids ?? ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    func getSupplierDebtPaymentUpdate() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierDebtPaymentChangeStatus(id: noteId.value, status: status.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}


