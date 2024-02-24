//
//  ForgotPasswordRouter.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 01/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ForgotPasswordRouter{
    var viewController:UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateEnterOTPViewController(username:String, restaurant_brand_name:String){
        let EnterOTPViewController = EnterOTPRouter().viewController as! EnterOTPViewController
        EnterOTPViewController.username = username
        EnterOTPViewController.restaurant_brand_name = restaurant_brand_name
        sourceView?.navigationController?.pushViewController(EnterOTPViewController, animated: true)
    }
    

}
