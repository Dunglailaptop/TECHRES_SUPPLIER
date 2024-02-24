//
//  InventoryManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class InventoryManagementRouter {
    
    var viewModel = InventoryManagementViewModel()
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = InventoryManagementViewController(nibName: "InventoryManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToCreateInventoryViewController(btnCreateType: Int){
        let createInventoryViewController = CreateInventoryRouter().viewController as! CreateInventoryViewController
        createInventoryViewController.btnCreateType = btnCreateType
        sourceView?.navigationController?.pushViewController(createInventoryViewController, animated: true)
    }
}
