//
//  OrderReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class OrderReportViewModel: BaseViewModel {
    private(set) weak var view: OrderReportViewController?
    private weak var router: OrderReportRouter?
    var report_type = BehaviorRelay<Int>(value: 0)
    var date_string = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    
    var total_amount:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var order_not_delivered_amount:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var order_delivered_amount:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var order_cancel_amount:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    var total_return_amount:BehaviorRelay<Int> = BehaviorRelay(value: 0)

    var dataArray: BehaviorRelay<[OrderReportData]> = BehaviorRelay(value: [])
    
    func bind(_ view:OrderReportViewController,router: OrderReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func clearData() {
        dataArray.accept([])
    }
    
    //Báo cáo đơn hàng
    func getOrderReport() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getOrderReport(report_type: report_type.value, date_string: date_string.value, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
        
    }
    
}
