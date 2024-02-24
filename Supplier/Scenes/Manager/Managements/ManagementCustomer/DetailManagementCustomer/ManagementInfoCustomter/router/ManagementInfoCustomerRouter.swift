//
//  ManagementInfoCustomterRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit


class ManagementInfoCustomerRouter {
    
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ManagementInfoCustomerViewController(nibName: "ManagementInfoCustomerViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
}
