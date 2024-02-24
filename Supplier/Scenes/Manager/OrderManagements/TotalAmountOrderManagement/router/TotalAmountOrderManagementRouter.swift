//
//  TotalAmountOrderManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class TotalAmountOrderManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = TotalAmountOrderManagementViewController(nibName: "TotalAmountOrderManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToCreateInventoryViewController(dataArrayMaterial: [Material]){
        let createInventoryViewController = CreateInventoryRouter().viewController as! CreateInventoryViewController
        createInventoryViewController.dataArrayMaterial = dataArrayMaterial
        sourceView?.navigationController?.pushViewController(createInventoryViewController, animated: true)
    }
}
