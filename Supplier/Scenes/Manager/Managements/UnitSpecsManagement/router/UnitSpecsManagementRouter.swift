//
//  UnitSpecsManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class UnitSpecsManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = UnitSpecsManagementViewController(nibName: "UnitSpecsManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToCreateUnitSpecificationViewController(unitSpecification:UnitSpecification){
        let createUnitSpecificationViewController = CreateUnitSpecificationRouter().viewController as! CreateUnitSpecificationViewController
        createUnitSpecificationViewController.unitSpecification = unitSpecification
        sourceView?.navigationController?.pushViewController(createUnitSpecificationViewController, animated: true)
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
}
