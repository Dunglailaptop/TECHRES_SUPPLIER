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
class CategoryReportViewModel: BaseViewModel {
    
    private(set) weak var view: CategoryReportViewController?
    private weak var router: CategoryReportRouter?
    
    func bind(_ view:CategoryReportViewController,router: CategoryReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}
