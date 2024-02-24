//
//  OrderReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class RestaurantOrderReportViewModel: BaseViewModel {
    private(set) weak var view: RestaurantOrderReportViewController?
    private weak var router: RestaurantOrderReportRouter?
    var reportType = BehaviorRelay<Int>(value: 0)
    var dateString = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    var restaurantOrder =  BehaviorRelay<[RestaurantOrderReport]>(value: [])

    
    func bind(_ view:RestaurantOrderReportViewController,router: RestaurantOrderReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    //Báo cáo Đơn hàng theo nhà Hàng
    func getRestaurantOrderReport() -> Observable<APIResponse>{
        return appServiceProvider.rx.request(.getRestaurantOrderReport(report_type: reportType.value, date_string: dateString.value, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
    
}
