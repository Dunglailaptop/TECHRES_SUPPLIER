//
//  ManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class ManagementViewModel: BaseViewModel {
    private(set) weak var view: ManagementViewController?
    private var router: ManagementRouter?
    
    public var id: BehaviorRelay<Int> = BehaviorRelay(value: 0)

    
    func bind(view: ManagementViewController, router: ManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    func makeEmployeeListManagementViewController(){
        router?.navigateToEmployeeListManagementViewController()
    }
    
    func makeDebtManagementViewController(){
        router?.navigateToDebtManagementViewController()
    }
    
    func makePriceListManagementViewController() {
        router?.navigateToPriceListManagementViewController()
    }
    
    func makePaymentRequestViewController() {
        router?.navigateToPaymentRequestViewController()
    }
    
    func makeReceiptAndPaymentViewController() {
        router?.navigateToReceiptAndPaymentViewController()
    }
    
    func makeItemsManagementViewController() {
        router?.navigateToItemsManagementViewController()
    }
    
    
    func makeUnitManagementViewController() {
        router?.navigateToUnitManagementViewController()
    }
    
    func makeUnitSpecsManagementViewController() {
        router?.navigateToUnitSpecsManagementViewController()
    }
    
    func makeManagementListCustomerViewController(){
        router?.navigateToManagementListCustomerViewController()
    }
    
    func makeInventoryManagementViewController(){
        router?.navigateToInventoryManagementViewController()
    }

}
 
