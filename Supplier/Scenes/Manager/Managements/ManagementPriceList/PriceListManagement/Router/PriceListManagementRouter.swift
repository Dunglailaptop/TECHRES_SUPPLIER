//
//  PriceListManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit


class PriceListManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = PriceListManagementViewController(nibName: "PriceListManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToPriceListDetailViewController(supplier: Supplier){
        let priceListDetailViewController = PriceListDetailRouter().viewController as? PriceListDetailViewController
        priceListDetailViewController?.supplier = supplier
        sourceView?.navigationController?.pushViewController(priceListDetailViewController!, animated: true)
    }
    
    
    func navigationToPopViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
   
}
