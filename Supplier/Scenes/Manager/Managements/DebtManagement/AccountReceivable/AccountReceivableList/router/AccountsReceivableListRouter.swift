//
//  ListReceiptBillDebtRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class AccountsReceivableListRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = AccountsReceivableListViewController(nibName: "AccountsReceivableListViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigateToDetailReceiptBillDebtViewController(debtReceivable:SupplierDebtReceivable, from_date:String, to_date:String){
        let AccountReceivableDetailViewController = AccountReceivableDetailRouter().viewController as! AccountReceivableDetailViewController
        AccountReceivableDetailViewController.debtReceivable = debtReceivable
        AccountReceivableDetailViewController.from_date = from_date
        AccountReceivableDetailViewController.to_date = to_date
        sourceView?.navigationController?.pushViewController(AccountReceivableDetailViewController, animated: true)
    }
    
    
    func navigateToCreatePaymentRequestViewController(debtReceivables:[SupplierDebtReceivable], from_date:String, to_date:String){
        let createPaymentRequestViewController = CreatePaymentRequestRouter().viewController as! CreatePaymentRequestViewController
        createPaymentRequestViewController.debtReceivables = debtReceivables
        createPaymentRequestViewController.from_date = from_date
        createPaymentRequestViewController.to_date = to_date
        sourceView?.navigationController?.pushViewController(createPaymentRequestViewController, animated: true)
    }
    
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
    
    
}
