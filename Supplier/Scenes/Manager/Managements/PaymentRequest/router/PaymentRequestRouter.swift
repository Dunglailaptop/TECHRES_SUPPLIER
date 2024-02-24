//
//  PaymentRequestRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class PaymentRequestRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = PaymentRequestViewController(nibName: "PaymentRequestViewController", bundle: .main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("")}
        self.sourceView = view
    }
    
    
    func navigateToCreatePaymentRequestViewController(){
        let createPaymentRequestViewController = CreatePaymentRequestRouter().viewController as! CreatePaymentRequestViewController
        sourceView?.navigationController?.pushViewController(createPaymentRequestViewController, animated: true)
    }
    
    func navigateToDetailedPaymentRequestViewController(supplierDebtPayment:SupplierDebtPayment){
        let detailedPaymentRequestViewController = DetailedPaymentRequestRouter().viewController as! DetailedPaymentRequestViewController
        detailedPaymentRequestViewController.supplier_order_ids = supplierDebtPayment.supplier_order_ids
        detailedPaymentRequestViewController.debt = supplierDebtPayment
        sourceView?.navigationController?.pushViewController(detailedPaymentRequestViewController, animated: true)
    }

    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
}

