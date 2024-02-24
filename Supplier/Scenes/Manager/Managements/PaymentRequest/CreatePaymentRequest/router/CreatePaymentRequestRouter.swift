//
//  CreatePaymentRequestRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 31/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class CreatePaymentRequestRouter {
    var viewController:UIViewController{
        return createViewController()
    }
    
    var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = CreatePaymentRequestViewController(nibName: "CreatePaymentRequestViewController", bundle: .main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("")}
        self.sourceView = view
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    

}
