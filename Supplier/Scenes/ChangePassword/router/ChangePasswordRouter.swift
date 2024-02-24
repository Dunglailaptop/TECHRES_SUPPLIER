//
//  ChangePasswordRouter.swift
//  Seemt
//
//  Created by Kelvin on 08/04/2023.
//

import UIKit
import RxSwift
class ChangePasswordRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToLoginViewController(){
          let loginViewController = LoginRouter().viewController
          sourceView?.navigationController?.pushViewController(loginViewController, animated: true)
      }
    func navigateToMainViewController(){
          let mainViewController = CustomTabBarController()
          sourceView?.navigationController?.pushViewController(mainViewController, animated: true)
      }

    func navigatePopViewController(){
          sourceView?.navigationController?.popViewController(animated: true)
      }
    
}
