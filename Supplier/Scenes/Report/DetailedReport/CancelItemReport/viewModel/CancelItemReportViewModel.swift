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
class CancelItemReportViewModel: BaseViewModel {
    private(set) weak var view: CancelItemReportViewController?
    private weak var router: CancelItemReportRouter?
    var reportType = BehaviorRelay<Int>(value: 0)
    var dateString = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")


    
    func bind(_ view:CancelItemReportViewController,router: CancelItemReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
  
}
