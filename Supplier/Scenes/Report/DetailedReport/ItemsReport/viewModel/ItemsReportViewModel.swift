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

class ItemsReportViewModel: BaseViewModel {
    private(set) weak var view: ItemsReportViewController?
    private weak var router: ItemsReportRouter?
    
    func bind(_ view: ItemsReportViewController,router: ItemsReportRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}
