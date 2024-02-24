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
class DebtReportViewModel: BaseViewModel {
    private(set) weak var view: DebtReportViewController?
    private weak var router: DebtReportRouter?
    var reportType = BehaviorRelay<Int>(value: 0)
    var dateString = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    var payment_status = BehaviorRelay<String>(value: "0,1")
    var status = BehaviorRelay<String>(value: "4,6,7")
    // Data cong no thu vs tra danh cho Bar chart
    var dataArray: BehaviorRelay<DebtReport> = BehaviorRelay(value: DebtReport())
    
    // Data cong no thu cho table
    var dataSupplierDebtReport: BehaviorRelay<SupplierDebtPayment> = BehaviorRelay(value: SupplierDebtPayment())
    var dataSupplierDebtReportArray: BehaviorRelay<[SupplierDebtPayment]> = BehaviorRelay(value: [])
    // Data cong no tra cho table
    var dataSupplierWarehouseSeasionsArray: BehaviorRelay<[SupplierWarehouseSessions]> = BehaviorRelay(value: [])
    
    
    func bind(_ view:DebtReportViewController,router: DebtReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func ClearData() {
//        fromDate.accept()
//        toDate.accept()
        dataSupplierDebtReportArray.accept([])
        dataSupplierWarehouseSeasionsArray.accept([])
    }
   
    
}

extension DebtReportViewModel {
    //Báo cáo công nợ
    func getDebtReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDebtReport(report_type: dataArray.value.report_type, date_string: dataArray.value.date_string, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
    func getListSupplierDebtPayment() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListSupplierDebtPayment(from_date: fromDate.value, to_date: toDate.value, status: status.value , payment_status: payment_status.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func getListSupplierWareHouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListSupplierWarehouseSessions(from_date: fromDate.value, to_date: toDate.value, type: 0, status: 2,payment_status: payment_status.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
}
