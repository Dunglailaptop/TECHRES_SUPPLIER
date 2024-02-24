//
//  CreateInventoryRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class CreateInventoryRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = CreateInventoryViewController(nibName: "CreateInventoryViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
//    func navigateToMaterialInventoryViewController(dataCompare: [Material]) {
//        let materialInventoryViewController = MaterialInventoryRouter().viewController as! MaterialInventoryViewController
//        materialInventoryViewController.requestSupplierMarerialDelegate = sourceView as! CreateInventoryViewController
//        sourceView?.navigationController?.pushViewController(materialInventoryViewController, animated: true)
//    }
}
