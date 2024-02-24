//
//  DetailReceiptBillDebtViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class AccountReceivableDetailViewModel: BaseViewModel {
    
    private(set) weak var view: AccountReceivableDetailViewController?
    private var router: AccountReceivableDetailRouter?
    
    
    var debtReceivable = BehaviorRelay<SupplierDebtReceivable>(value:SupplierDebtReceivable())
    var debtReceivableDataArray = BehaviorRelay<[SupplierOrdersDetailResponse]>(value:[])
    var dataSectionArray = BehaviorRelay<[Int]>(value:[0])
    
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "4,6,7")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 100)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    func bind(view: AccountReceivableDetailViewController, router: AccountReceivableDetailRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
}

// MARK: Call API
extension AccountReceivableDetailViewModel{
    func getDetailSupplierOrders() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierOrders(id: debtReceivable.value.id, status: status.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    
    
    func createPaymentRequest() -> Observable<APIResponse> {
        var selectedOrderList:[Int] = []

        for data in debtReceivableDataArray.value {
            selectedOrderList.append(data.supplier_order_id)
        }
        
        return appServiceProvider.rx.request(.postSupplierDebtPaymentCreate(
            restaurant_id: debtReceivable.value.restaurant_id,
            branch_id: debtReceivable.value.branch_id,
            status: 0,/*status = 0 -> là chưa gửi cho nhà hàng, status = 1 là đã gửi cho nhà hàng*/
            from_date: view?.from_date ?? "",
            to_date: view?.to_date ?? "",
            supplier_order_ids: selectedOrderList))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    

}
