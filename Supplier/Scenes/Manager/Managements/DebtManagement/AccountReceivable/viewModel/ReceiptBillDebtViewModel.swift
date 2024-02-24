//
//  ReceiptBillDebtViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class AccountsReceivableViewModel: BaseViewModel {
    
    private(set) weak var view: AccountsReceivableViewController?
    private var router: AccountsReceivableRouter?
    
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "01/" + Utils.getCurrentMonthYearString())
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: Utils.getCurrentDateString())
    public var dateType : BehaviorRelay<Int> = BehaviorRelay(value: 0)
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
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "4,6,7")
    /*
        payment status:
        WAITTING_PAYMENT(0), //"Chờ thanh toán"
        WAITTING_CONFIRM(1), //"Chờ xác nhận thanh toán"
        PAID(2), //"Đã thanh toán"
        CANCELLED(3); //"Đã hủy"
     */
    public var payment_status : BehaviorRelay<String> = BehaviorRelay(value: "0,1")
    

    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var restaurant_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var restaurant_brand_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)

    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var dataArray : BehaviorRelay<[RestaurantWithReceipt]> = BehaviorRelay(value: [])
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    
    func clearDataAndCallAPI(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
        view!.getListOfRestaurantWithReceipt()
    }
    
    func bind(view: AccountsReceivableViewController, router: AccountsReceivableRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func makeListReceiptBillDebtViewController(restaurant: RestaurantWithReceipt){
        router?.navigateToAccountsReceivableListViewController(restaurant: restaurant,from_date: from_date.value,to_date: to_date.value)
    }
}


// MARK: Call API
extension AccountsReceivableViewModel{
    func getListOfRestaurantWithReceipt() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierOrdersGroupByRestaurant(
            from_date: "",
            to_date: "",
            key_search: key_search.value,
            status: status.value,
            payment_status: payment_status.value,
            limit: limit.value,
            page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    

}

