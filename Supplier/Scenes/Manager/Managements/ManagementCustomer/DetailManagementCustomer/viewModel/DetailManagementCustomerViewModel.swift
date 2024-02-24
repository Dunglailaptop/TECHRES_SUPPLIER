//
//  ManagementDetailCustomerViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailManagementCustomerViewModel: BaseViewModel {
    private(set) weak var view: DetailManagementCustomerViewController?
    private var router: DetailManagementCustomerRouter?
     
    func bind(view: DetailManagementCustomerViewController, router: DetailManagementCustomerRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeToManagementListCustomerViewController(){
        router?.makePopToViewController()
    }
}
