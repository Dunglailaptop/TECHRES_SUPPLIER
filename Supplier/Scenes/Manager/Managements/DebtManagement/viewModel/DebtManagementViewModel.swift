//
//  DebtManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DebtManagementViewModel: BaseViewModel {
    private(set) weak var view: DebtManagementViewController?
    private var router: DebtManagementRouter?
    
    func bind(view: DebtManagementViewController, router: DebtManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}
