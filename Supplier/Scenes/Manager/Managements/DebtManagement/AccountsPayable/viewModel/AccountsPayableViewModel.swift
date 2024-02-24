//
//  PaymentBillDebtViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class AccountsPayableViewModel: BaseViewModel {
    
    private(set) weak var view: AccountsPayableViewController?
    private var router: AccountsPayableRouter?
    
    /*
        type = 0 -> phiếu nhập
        type = 1 -> phiếu xuất
        type = 2 -> phiếu nhập trả
        type = 3 -> phiếu nhập huỷ
        type = 4 -> phiếu xuất huỷ

        type = 1 -> Đang xử lý
        type = 2 -> Hoàn tất
        type = 3 -> Hủy
     
        vì user đang cần tạo phiếu chi nên ta chỉ lấy danh sách các phiếu nhập kho để tạo phiếu chi
     */
    var type = BehaviorRelay<Int>(value: Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.IN)
    var note = BehaviorRelay<String>(value: "")
    var search = BehaviorRelay<(dateType:Int,from_date:String,to_date:String,key_search:String)>(value:(
        dateType:1,
        from_date: "01/" + Utils.getCurrentMonthYearString(),
        to_date:Utils.getCurrentDateString(),
        key_search:""))
    var pagination = BehaviorRelay<(limit:Int,page:Int,totalRecord:Int, isGetFullData:Bool, isAPICalling:Bool)>(value: (limit:10,page:1,totalRecord:0,isGetFullData:false,isAPICalling:false))
    var warehouseReceiptList = BehaviorRelay<[WarehouseReceipt]>(value: [])
    var warehouseReceiptListHisory = BehaviorRelay<[WarehouseReceipt]>(value: [])
    var paymenCategory = BehaviorRelay<[ReceiptPaymentCategory]>(value: [])
    
    func clearDataAndCallAPI(){
        var pagination = pagination.value
        pagination.page = 1
        pagination.isGetFullData = false
        self.pagination.accept(pagination)
        warehouseReceiptList.accept([])
        view!.getSupplierWarehouseSession()
    }
    
    func bind(view: AccountsPayableViewController, router: AccountsPayableRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func makeDetailedAccountsPayableViewController(receipt: WarehouseReceipt){
        router?.navigateToDetailedAccountsPayableViewController(receipt: receipt, from_date: search.value.from_date, to_date: search.value.to_date)
    }
    
}

// MARK: CALL API
extension AccountsPayableViewModel{
    func getSupplierWarehouseSession() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSession(
            status: 2,//Status = 2 -> là những phiếu đã hoàn tất
            type: type.value,
            payment_status: "0",
            limit: pagination.value.limit,
            page: pagination.value.page,
            key_search: search.value.key_search,
            from_date: search.value.from_date,
            to_date:  search.value.to_date
        ))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func getReceiptAndPaymentCategory() -> Observable<APIResponse> {
        /*
         Chỉ lấy hạng mục chi thôi => supplier_addition_fee_type = 1 (phiếu chi) , supplier_addition_fee_type = 0 (phiếu thu)
         is_hidden = 0 -> ACTIVE,  is_hidden = 1 -> DEACTIVE
         is_system_auto_generate = 1 là phiếu thu tự động, ở nghiệp vụ này chỉ lấy những phiếu thu tay thôi
        */
        return appServiceProvider.rx.request(.getReceiptAndPaymentCategory(supplier_addition_fee_reason_category_id: -1, supplier_addition_fee_type: 1, is_hidden: 0, key_search: "", is_system_auto_generate: 0))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    

    func createPayment() -> Observable<APIResponse> {
        /*
            object_type = 0 -> khác
            object_type = 1 -> đơn hàng
            object_type = 2 -> phiếu nhập kho
            . khi tạo phiếu thu và phiếu chi (chi phí khác ) ta truyển object_type = 0
            . khi tạo phiếu chi (nhập kho) ta truyển object_type = 2
         */
        
        var warehouse_session_ids:[Int] = []
        //Backend yêu cầu là chỉ lấy phần tử đầu tiên trong danh sách hạng mục chi khi sử dụng API tạo phiếu chi trong module này
        dLog(paymenCategory.value[0].id)
        var supplier_addition_fee_reason_id:Int = paymenCategory.value.count > 0 ? paymenCategory.value[0].id : 0
        var totalAmount = 0.0
        for receipt in warehouseReceiptList.value.filter{$0.isSelected == ACTIVE} {
            warehouse_session_ids.append(receipt.id)
            totalAmount += receipt.total_amount
        }
        
        return appServiceProvider.rx.request(.postCreateReceiptAndPayment(
            note: "",
            amount: totalAmount,
            warehouse_session_ids: warehouse_session_ids,
            object_type: 2,
            fee_month: Utils.getCurrentDateString(),
            supplier_addition_fee_reason_id:supplier_addition_fee_reason_id))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}
