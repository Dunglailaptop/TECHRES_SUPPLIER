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
class InventoryReportViewModel: BaseViewModel {
    private(set) weak var view: InventoryReportViewController?
    private weak var router: InventoryReportRouter?
    var report_type = BehaviorRelay<Int>(value: 0)
    var inventoryType = BehaviorRelay<Int>(value: 0)
    var date_string = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")
    
    var dataArray:BehaviorRelay<[InventoryReport]> = BehaviorRelay(value: [])
    var dataReport: BehaviorRelay<InventoryReport> = BehaviorRelay(value: InventoryReport())
    
    func bind(_ view:InventoryReportViewController,router: InventoryReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    


}
extension InventoryReportViewModel {
    //Báo cáo kho
    func getInventoryReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getInventoryReport(material_category_id: inventoryType.value,report_type: report_type.value, date_string: date_string.value, from_date: fromDate.value, to_date: toDate.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
}
