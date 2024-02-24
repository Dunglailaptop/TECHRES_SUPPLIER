//
//  DetailedPaymentRequestRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 23/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedPaymentRequestRouter: NSObject {

    var viewController:UIViewController{
        return createViewController()
    }
    
    var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = DetailedPaymentRequestViewController(nibName: "DetailedPaymentRequestViewController", bundle: .main)
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
