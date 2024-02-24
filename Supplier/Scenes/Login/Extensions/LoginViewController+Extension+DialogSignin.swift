//
//  LoginViewController+Extension+DialogSignin.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit

extension LoginViewController {
    func presentModalDialogSignin() {
        
        let SigninDialogViewController = SigninDialogViewController()
        
        SigninDialogViewController.view.backgroundColor = ColorUtils.blackTransparent()
    
        let nav = UINavigationController(rootViewController: SigninDialogViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
    
    
    
}
