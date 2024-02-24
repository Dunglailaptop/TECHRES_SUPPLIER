//
//  CancelReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//



import UIKit
import RxSwift
import RxRelay
class CancelReportViewModel: BaseViewModel {
    private(set) weak var view: CancelReportViewController?
    private weak var router: CancelReportRouter?
 
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    var type = BehaviorRelay<Int>(value: 2)
   var date_string = BehaviorRelay<String>(value: "")
    var report_type = BehaviorRelay<Int>(value: 0)
   
    var dataMap = BehaviorRelay<CancelItemReport>(value: CancelItemReport())
    
    var dataArray: BehaviorRelay<[CancelItemReport]> = BehaviorRelay(value: [])
    
    
    func bind(_ view:CancelReportViewController,router: CancelReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func ClearData() {
        dataArray.accept([])
    }
    
    func clearandCallAPI() {
        ClearData()
        view?.getCancelItemReport()
    }
    
}
extension CancelReportViewModel {
    //Báo cáo huỷ mặt hàng
    func getCancelItemReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(. getCancelItemReport(report_type: report_type.value, type: type.value, date_string: date_string.value, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
}

