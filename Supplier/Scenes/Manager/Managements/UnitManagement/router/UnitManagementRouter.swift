//
//  UnitManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class UnitManagementRouter: NSObject {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = UnitManagementViewController(nibName: "UnitManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToCreateMaterialUnitViewController(materialUnit:MaterialUnit,isAllowEdit:Bool){
        let createMaterialUnitViewController = CreateMaterialUnitRouter().viewController as! CreateMaterialUnitViewController
        createMaterialUnitViewController.materialUnit = materialUnit
        createMaterialUnitViewController.isAllowToEdit = isAllowEdit
        sourceView?.navigationController?.pushViewController(createMaterialUnitViewController, animated: true)
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
