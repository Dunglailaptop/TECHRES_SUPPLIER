//
//  CreatePaymentRequestViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 31/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class CreatePaymentRequestViewModel: BaseViewModel {
    private(set) weak var view: CreatePaymentRequestViewController?
    private var router: CreatePaymentRequestRouter?

    var APIParameter = BehaviorRelay<(
            restaurant_id: Int,
            brand_id:Int,
            branch_id: Int,
            status: Int,
            from_date: String,
            to_date: String,
            supplier_order_ids: Array<Int>,
            reason:String
    )>(value:(restaurant_id: 0,
              brand_id: 0,
              branch_id: 0,
              status: 0,
              from_date: "01/" + Utils.getCurrentMonthYearString(),
              to_date: Utils.getCurrentDateString(),
              supplier_order_ids: [],
              reason:""
    ))
    var dateType = BehaviorRelay<Int>(value: 0)
    var receivableList =  BehaviorRelay<[SupplierDebtReceivable]>(value:[])
    var fullReceivableList =  BehaviorRelay<[SupplierDebtReceivable]>(value:[])
    
    func bind(view: CreatePaymentRequestViewController, router: CreatePaymentRequestRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func updateFullReceivableList(){

        var fullList = fullReceivableList.value
        for ele in receivableList.value{
            if let pos = fullList.firstIndex(where: {$0.id == ele.id}){
                fullList[pos] = ele
            }
        }
        
        fullReceivableList.accept(fullList)
    }
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
     
}

extension CreatePaymentRequestViewModel{
    func createSupplierDebtPayment() -> Observable<APIResponse> {
        var supplier_order_ids:[Int] = []
        for receivable in receivableList.value.filter{$0.isSelected == ACTIVE}{
            supplier_order_ids.append(receivable.id)
        }
        return appServiceProvider.rx.request(.postSupplierDebtPaymentCreate(
            restaurant_id: APIParameter.value.restaurant_id,
            branch_id: APIParameter.value.branch_id,
            status: 1,/*status = 0 -> là chưa gửi cho nhà hàng, status = 1 là đã gửi cho nhà hàng*/
            from_date: APIParameter.value.from_date,
            to_date: APIParameter.value.to_date,
            supplier_order_ids: supplier_order_ids))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getSupplierOrders() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierOrders(
                restaurant_id: APIParameter.value.restaurant_id,
                brand_id:  APIParameter.value.brand_id,
                branch_id: APIParameter.value.branch_id,
                payment_status: "0",
                status: String(Constants.SUPPLIER_ORDERS_STATUS.COMPLETED),
                key_search: "",
                from_date: APIParameter.value.from_date,
                to_date: APIParameter.value.to_date,
                is_return_material: -1,
                is_return_all_total_material: -1,
                limit: 500,
                page: 1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}
