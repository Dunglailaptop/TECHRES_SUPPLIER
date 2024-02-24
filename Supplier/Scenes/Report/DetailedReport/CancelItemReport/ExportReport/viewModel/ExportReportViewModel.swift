//
//  ExportReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//




import UIKit
import RxSwift
import RxRelay
class ExportReportViewModel: BaseViewModel {
    private(set) weak var view: ExportReportViewController?
    private weak var router: ExportReportRouter?
    var report_type = BehaviorRelay<Int>(value: 0)
    var date_string = BehaviorRelay<String>(value: "")
    var type = BehaviorRelay<Int>(value: 1)
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    
    var dataArray: BehaviorRelay<[CancelItemReport]> = BehaviorRelay(value: [])
    
    
    func bind(_ view:ExportReportViewController,router: ExportReportRouter){
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
    
    
}
extension ExportReportViewModel {
    //Báo cáo huỷ mặt hàng
    func getExportItemReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getCancelItemReport(report_type: report_type.value, type: type.value, date_string: date_string.value, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
}

