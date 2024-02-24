//
//  CreateReceiptAndPaymentViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class CreateReceiptAndPaymentViewModel: BaseViewModel {
    private(set) weak var view: CreateReceiptAndPaymentViewController?
    private var router: CreateReceiptAndPaymentRouter?

    var APIParameter = BehaviorRelay<ReceiptPayment>(value: ReceiptPayment())
    var categoryList = BehaviorRelay<[ReceiptPaymentCategory]>(value: [])
    var warehouseReceiptList = BehaviorRelay<[WarehouseReceipt]>(value: [])

    /*
         noteType = 0 -> phiếu thu
         noteType = 1 -> phiếu chi
     */
    var noteType = BehaviorRelay<Int>(value: 0)
    /*
        object_type = 0 -> khác
        object_type = 1 -> đơn hàng
        object_type = 2 -> phiếu kho
        . khi tạo phiếu thu và phiếu chi (chi phí khác ) ta truyển object_type = 0
        . khi tạo phiếu chi (nhập kho) ta truyển object_type = 2
     */
    var object_type = BehaviorRelay<Int>(value: 0)

    
    
    func bind(view: CreateReceiptAndPaymentViewController, router: CreateReceiptAndPaymentRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    
    
    
}

extension CreateReceiptAndPaymentViewModel{
    func createReceiptAndPayment() -> Observable<APIResponse>{
        
        var cloneAPIParameter = APIParameter.value
        cloneAPIParameter.supplier_warehouse_session_ids = []
        for selectedReceipt in warehouseReceiptList.value.filter{$0.isSelected==ACTIVE} {
            cloneAPIParameter.supplier_warehouse_session_ids.append(selectedReceipt.id)
        }
        APIParameter.accept(cloneAPIParameter)
        return appServiceProvider.rx.request(.postCreateReceiptAndPayment(note: APIParameter.value.note, amount: Double(APIParameter.value.amount), warehouse_session_ids: APIParameter.value.supplier_warehouse_session_ids, object_type: object_type.value, fee_month: APIParameter.value.fee_month, supplier_addition_fee_reason_id: APIParameter.value.supplier_addition_fee_reason_id))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getReceiptAndPaymentCategory() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getReceiptAndPaymentCategory(supplier_addition_fee_reason_category_id: 0, supplier_addition_fee_type: noteType.value, is_hidden: 0, key_search: "", is_system_auto_generate: 0))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    
    func getSupplierWarehouseSession() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSession(status: 2, type: 0, payment_status: "0", limit: 500, page: 1, key_search: "", from_date: "", to_date: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}
