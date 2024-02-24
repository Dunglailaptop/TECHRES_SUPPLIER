//
//  PaymentRequestViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class PaymentRequestViewModel: BaseViewModel {
    private(set) weak var view: PaymentRequestViewController?
    private var router: PaymentRequestRouter?
    /*
        status = 1 -> đang chờ xử lý
        status = 2 -> đã hoàn thành
        status = 0 -> đã huỷ
     */
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: 2)
    public var dateType : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var APIParameter:BehaviorRelay<(
        restaurant_id:Int,
        brand_id:Int,
        branch_id:Int,
        key_search:String,
        from_date:String,
        to_date:String)> = BehaviorRelay(value:(
            restaurant_id:-1,
            brand_id:-1,
            branch_id:-1,
            key_search:"",
            from_date:"01/" + Utils.getCurrentMonthYearString(),
            to_date:Utils.getCurrentDateString()))
    
    
    var pagination = BehaviorRelay<(limit: Int,
                                page:Int,
                                total_record:Int,
                                isGetFullData:Bool,
                                isAPICalling:Bool
    )>(value: (limit:50, page:1, total_record:0,isGetFullData:false,isAPICalling:false))
    
    public var dataArray:BehaviorRelay<[SupplierDebtPayment]> = BehaviorRelay(value: [])
    
    public var dataRestaurant : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBrand : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBranch : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    
    public var fullDataArray:BehaviorRelay<[SupplierDebtPayment]> = BehaviorRelay(value: [])
    
    
    func bind(view: PaymentRequestViewController, router: PaymentRequestRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeCreatePaymentRequestViewController(){
        router?.navigateToCreatePaymentRequestViewController()
    }
    
    func makeDetailedPaymentRequestViewController(supplierDebtPayment:SupplierDebtPayment){
        router?.navigateToDetailedPaymentRequestViewController(supplierDebtPayment:supplierDebtPayment)
    }
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    
    func clearDataAndCallAPI(){
        fullDataArray.accept([])
        dataArray.accept([])
        var pagination = self.pagination.value
        pagination.page = 1
        pagination.isGetFullData = false
        self.pagination.accept(pagination)
        view?.getSupplierDebtPayment()
    }
    func clearData() {
        
        fullDataArray.accept([])
        dataArray.accept([])
    }
    

}

extension PaymentRequestViewModel{
    func getSupplierDebtPayment() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierDebtPayment(
            restaurant_id: APIParameter.value.restaurant_id,
            restaurant_brand_id: APIParameter.value.brand_id,
            branch_id: APIParameter.value.branch_id,
            status: "",
            from_date: APIParameter.value.from_date,
            to_date: APIParameter.value.to_date,
            key_search: APIParameter.value.key_search,
            is_delete: -1,
            limit: pagination.value.limit,
            page: pagination.value.page))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
