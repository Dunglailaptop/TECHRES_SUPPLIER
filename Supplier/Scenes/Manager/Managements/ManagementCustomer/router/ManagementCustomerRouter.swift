//
//  ManagementCustomerRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ManagementCustomerRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementCustomerViewController(nibName: "ManagementCustomerViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigationToManagementDetailCustomerViewController(restaurantInfo: Restaurant){
        let detailManagementCustomerViewController = DetailManagementCustomerRouter().viewController as! DetailManagementCustomerViewController
        detailManagementCustomerViewController.restaurant = restaurantInfo
        sourceView?.navigationController?.pushViewController(detailManagementCustomerViewController, animated: true)
        
    }
    
    func makePopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
}
