//
//  ReceiptBillDebtRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class AccountsReceivableRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = AccountsReceivableViewController(nibName: "AccountsReceivableViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToAccountsReceivableListViewController(restaurant: RestaurantWithReceipt, from_date:String, to_date:String){
        let accountsReceivableListViewController = AccountsReceivableListRouter().viewController as! AccountsReceivableListViewController
        dLog(restaurant)
        accountsReceivableListViewController.restaurant = restaurant
        accountsReceivableListViewController.from_date = from_date
        accountsReceivableListViewController.to_date = to_date
        sourceView?.navigationController?.pushViewController(accountsReceivableListViewController, animated: true)
    }
    
}
