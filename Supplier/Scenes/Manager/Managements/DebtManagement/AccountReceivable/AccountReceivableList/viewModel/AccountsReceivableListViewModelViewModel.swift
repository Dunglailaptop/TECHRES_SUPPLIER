//
//  ListReceiptBillDebtViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class AccountsReceivableListViewModel: BaseViewModel {
    
    private(set) weak var view: AccountsReceivableListViewController?
    private var router: AccountsReceivableListRouter?
    
  
    public var restaurant = BehaviorRelay<RestaurantWithReceipt>(value: RestaurantWithReceipt())
    /*
     status đơn hàng
        PENDING(0), // Đơn hàng đang chuẩn bị
        WAITTING_RESTAURANT_CONFIRM(1), // Chờ nhà hàng xác nhận
        WAITTING_DELIVERY(2), // Chờ giao
        DELIVERING(3), // Đang giao
        COMPLETED(4), // Hoàn tất - Trạng thái cuối cùng
        CANCELED(5), // Đã hủy - Trạng thái cuối cùng
        RETURN_TO_SUPPLIER(6), // Trả hàng về NCC
        CONFIRM_RETURN(7); // Xác nhận hàng bị trả - Trạng thái cuối cùng
     */
    public var status : BehaviorRelay<String> = BehaviorRelay(value:String(Constants.SUPPLIER_ORDERS_STATUS.COMPLETED))
    /*
        payment status:
        WAITTING_PAYMENT(0), //"Chờ thanh toán"
        WAITTING_CONFIRM(1), //"Chờ xác nhận thanh toán"
        PAID(2), //"Đã thanh toán"
        CANCELLED(3); //"Đã hủy"
     */
    public var payment_status : BehaviorRelay<String> = BehaviorRelay(value: "0,1")
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var dataArray: BehaviorRelay<[SupplierDebtReceivable]> = BehaviorRelay(value: [])
    public var dataArraySearch: BehaviorRelay<[SupplierDebtReceivable]> = BehaviorRelay(value: []) //data search
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }

    func clearDataAndCallAPI(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
        view!.getSupplierDebtPayment()
    }
    
    func bind(view: AccountsReceivableListViewController, router: AccountsReceivableListRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeDetailReceiptBillDebtViewController(debtReceivable:SupplierDebtReceivable){
        router?.navigateToDetailReceiptBillDebtViewController(debtReceivable:debtReceivable,from_date: from_date.value,to_date:to_date.value)
    }
    
    func makeCreatePaymentRequestViewController(){
        router?.navigateToCreatePaymentRequestViewController(debtReceivables: dataArray.value.filter{$0.isSelected == ACTIVE}, from_date: from_date.value, to_date: to_date.value)
    }
    

    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

// MARK: Call API
extension AccountsReceivableListViewModel{
    func getSupplierDebtPayment() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierOrders(
            restaurant_id: restaurant.value.restaurant_id,
            brand_id: restaurant.value.brand_id,
            branch_id: restaurant.value.branch_id,
            payment_status: payment_status.value,
            status: status.value,
            key_search: key_search.value,
            from_date: from_date.value,
            to_date: to_date.value,
            is_return_material: -1,
            is_return_all_total_material: -1,
            limit: limit.value,
            page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    func createSupplierDebtPayment(supplierDebtReceivable:SupplierDebtReceivable) -> Observable<APIResponse> {
        var selectedOrderList:[Int] = []

        for data in supplierDebtReceivable.supplier_order_detail {
            selectedOrderList.append(data.supplier_order_id)
        }
        
        return appServiceProvider.rx.request(.postSupplierDebtPaymentCreate(
            restaurant_id: supplierDebtReceivable.restaurant_id,
            branch_id: supplierDebtReceivable.branch_id,
            status: 0,/*status = 0 -> là chưa gửi cho nhà hàng, status = 1 là đã gửi cho nhà hàng*/
            from_date: from_date.value,
            to_date: to_date.value,
            supplier_order_ids: selectedOrderList))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    

}

