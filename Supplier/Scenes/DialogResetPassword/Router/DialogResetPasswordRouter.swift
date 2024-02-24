//
//  DialogResetPasswordRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 13/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogResetPasswordRouter {
   
    
    var viewController:UIViewController{
        return createViewController()
    }
    
    var sourceView:UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = DialogResetPasswordViewController(nibName: "DialogResetPasswordViewController", bundle: .main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("")}
        self.sourceView = view
    }
    
    func navigationToChangePasswordViewController() {
        let viewControllerChangePassword = ChangePasswordRouter().viewController as! ChangePasswordViewController
        viewControllerChangePassword.type = 1
        
        sourceView?.navigationController?.pushViewController(viewControllerChangePassword, animated: true)
    }
    
    
    
}

