//
//  ManagementRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ManagementRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementViewController(nibName: "ManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigateToItemsManagementViewController(){
        let itemsManagementViewController = ItemsManagementRouter().viewController as! ItemsManagementViewController
        sourceView?.navigationController?.pushViewController(itemsManagementViewController, animated: true)
    }
    
    func navigateToEmployeeListManagementViewController(){
        let employeeListManagementViewController = EmployeeListManagementRouter().viewController as! EmployeeListManagementViewController
        sourceView?.navigationController?.pushViewController(employeeListManagementViewController, animated: true)
    }
    
    func navigateToDebtManagementViewController(){
        let debtManagementViewController = DebtManagementRouter().viewController as! DebtManagementViewController
        sourceView?.navigationController?.pushViewController(debtManagementViewController, animated: true)
    }
    
    func navigateToPriceListManagementViewController(){
        let priceListManagementViewController = PriceListManagementRouter().viewController as! PriceListManagementViewController
        sourceView?.navigationController?.pushViewController(priceListManagementViewController, animated: true)
    }
    
    func navigateToReceiptAndPaymentViewController(){
        let receiptAndPaymentViewController = ReceiptAndPaymentRouter().viewController as! ReceiptAndPaymentViewController
        sourceView?.navigationController?.pushViewController(receiptAndPaymentViewController, animated: true)
    }
    
    func navigateToPaymentRequestViewController(){
        let paymentRequestViewController = PaymentRequestRouter().viewController as! PaymentRequestViewController
        sourceView?.navigationController?.pushViewController(paymentRequestViewController, animated: true)
    }
    
    func navigateToUnitSpecsManagementViewController(){
        let unitSpecsManagementViewController = UnitSpecsManagementRouter().viewController as! UnitSpecsManagementViewController
        sourceView?.navigationController?.pushViewController(unitSpecsManagementViewController, animated: true)
    }
    
    func navigateToUnitManagementViewController(){
        let unitManagementViewController = UnitManagementRouter().viewController as! UnitManagementViewController
        sourceView?.navigationController?.pushViewController(unitManagementViewController, animated: true)
    }
    
    func navigateToManagementListCustomerViewController(){
        let ManagementCustomerViewController = ManagementCustomerRouter().viewController as! ManagementCustomerViewController
        sourceView?.navigationController?.pushViewController(ManagementCustomerViewController, animated: true)
    }
    
    func navigateToInventoryManagementViewController(){
        let inventoryManagementViewController = InventoryManagementRouter().viewController as! InventoryManagementViewController
        sourceView?.navigationController?.pushViewController(inventoryManagementViewController, animated: true)
    }

}
