//
//  CancelItemsReportViewModel.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 09/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class CancelItemsReportViewModel: BaseViewModel {
    
    private(set) weak var view: CancelItemsReportViewController?
    private var router: CancelItemsReportRouter?
    
    public var material_category_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var report_type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var date_string : BehaviorRelay<String> = BehaviorRelay(value: "")
    
    public var data : BehaviorRelay<MaterialReport> = BehaviorRelay(value: MaterialReport.init())
    public var dataArray : BehaviorRelay<[MaterialReportData]> = BehaviorRelay(value: [])
    
    func bind(view: CancelItemsReportViewController, router: CancelItemsReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
}

extension CancelItemsReportViewModel{
    //báo cáo Mặt hàng
    func getItemsReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getMaterialReport(material_category_id: material_category_id.value, report_type: report_type.value, from_date: from_date.value, to_date: to_date.value, date_string: date_string.value))
                 .filterSuccessfulStatusCodes()
                 .mapJSON().asObservable()
                 .showAPIErrorToast()
                 .mapObject(type: APIResponse.self)
    }
}
