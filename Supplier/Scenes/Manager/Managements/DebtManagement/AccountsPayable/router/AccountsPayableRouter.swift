//
//  PaymentBillDebtRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class AccountsPayableRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = AccountsPayableViewController(nibName: "AccountsPayableViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailedAccountsPayableViewController(receipt: WarehouseReceipt, from_date:String, to_date:String){
        let detailedAccountsPayableViewController = DetailedAccountsPayableRouter().viewController as! DetailedAccountsPayableViewController
        detailedAccountsPayableViewController.warehouseReceipt = receipt
        detailedAccountsPayableViewController.from_date = from_date
        detailedAccountsPayableViewController.to_date = to_date
        sourceView?.navigationController?.pushViewController(detailedAccountsPayableViewController, animated: true)
    }
}
