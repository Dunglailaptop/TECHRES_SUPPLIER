//
//  PriceListDetailRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit


class PriceListDetailRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = PriceListDetailViewController(nibName: "PriceListDetailViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigationToPopViewController() {
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
    
   
}
