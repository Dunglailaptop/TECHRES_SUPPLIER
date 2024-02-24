//
//  GeneralReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class GeneralReportViewModel:BaseViewModel {
    private(set) weak var view: GeneralReportViewController?
    private weak var router: GenenralReportRouter?
    
    var dataSection = BehaviorRelay<[Int]>(value: [0,1,2,3,4])
        
    var generalReport = BehaviorRelay<GeneralReport>(value:  GeneralReport())
    
    var actualRevenueCostProfitReport = BehaviorRelay<RevenueCostProfitReport>(value:  RevenueCostProfitReport())
    
    var orderReport = BehaviorRelay<OrderReport>(value: OrderReport())
    
    var estimatedRevenueCostProfitReport = BehaviorRelay<RevenueCostProfitReport>(value: RevenueCostProfitReport())
    
    var materialReport = BehaviorRelay<MaterialReport>(value: MaterialReport())
    
    
    func bind(_ view:GeneralReportViewController,router: GenenralReportRouter ){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
     
}


//MARK: call API here
extension GeneralReportViewModel{
    

    

    func getGeneralReport()-> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierGeneralReport(restaurant_brand_id:-1, branch_id: -1,report_type: 1, date_string: Utils.getCurrentDateString(), from_date: "", to_date: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    //Báo cáo đơn hàng
    func getOrderReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getOrderReport(
            report_type: orderReport.value.report_type,
            date_string: orderReport.value.date_string,
            from_date:"",
            to_date: ""
        ))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
        
    }
    //Báo cáo danh thu lợi nhuận ước tính
    func getEstimatedRevenueCostProfitReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getEstimatedRevenueCostProfitReport(
            report_type: estimatedRevenueCostProfitReport.value.report_type,
            date_string: estimatedRevenueCostProfitReport.value.date_string,
            from_date: "",
            to_date:"")
        )
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    //Báo cáo danh thu lợi nhuận thực tế
    func getActualRevenueCostProfitReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getActualRevenueCostProfitReport(
            report_type: actualRevenueCostProfitReport.value.report_type,
            date_string: actualRevenueCostProfitReport.value.date_string,
            from_date: "",
            to_date: ""))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
 
 
    //báo cao nguyên liệu
    func getMaterialReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getMaterialReport(
            material_category_id: 1,
            report_type: materialReport.value.report_type,
            from_date:"",
            to_date: "",
            date_string:materialReport.value.date_string
        ))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
}
