//
//  DetailedReportViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DetailedReportViewModel: BaseViewModel {
    private(set) weak var view: DetailedReportViewController?
    private weak var router: DetailedReportRouter?
    var reportType = BehaviorRelay<Int>(value: 0)
    var inventoryType = BehaviorRelay<Int>(value: 0)
    var dateString = BehaviorRelay<String>(value: "")
    var fromDate = BehaviorRelay<String>(value: "")
    var toDate = BehaviorRelay<String>(value: "")

    
    func bind(_ view:DetailedReportViewController,router: DetailedReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    
    
    func makeOrderReportViewController(){
        router?.navigateToOrderReportViewController()
    }
    
    func  makeCancelItemReportViewController(){
        router?.navigateToCancelItemReportViewController()
    }
    
    func makeInventoryReportViewController(){
        router?.navigateToInventoryReportViewController()
    }
    
    func makeDebtReportViewController(){
        router?.navigateToDebtReportViewController()
    }
    
    func makeRestaurantOrderReportViewController(){
        router?.navigateToRestaurantOrderReportViewController()
    }
    
    func makeItemReportViewController(){
        router?.navigateToItemReportViewController()
    }
    func makeCategoryReportViewController(){
        router?.navigateToCategoryReportViewController()
    }
    
}


