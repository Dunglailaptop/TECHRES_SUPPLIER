//
//  NotificationViewRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 20/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class NotificationViewRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    

    private func createViewController()-> UIViewController {
        let view = NotificationViewController(nibName: "NotificationViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
