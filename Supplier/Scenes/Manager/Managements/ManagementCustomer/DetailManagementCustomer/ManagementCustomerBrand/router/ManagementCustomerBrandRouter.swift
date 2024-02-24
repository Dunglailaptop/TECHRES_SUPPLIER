//
//  ManagementListBranchesRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit


class ManagementCustomerBrandRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementCustomerBrandViewController(nibName: "ManagementCustomerBrandViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationToManagementListBranchesViewController(BrandDetail:Brand) {
        let managementCustomerBranch = ManagementCustomerBranchRouter().viewController as! ManagementCustomerBranchViewController
        managementCustomerBranch.brandRestaurantInfo = BrandDetail
        sourceView?.navigationController?.pushViewController(managementCustomerBranch, animated: true)
    }
    
    func makepopToViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
