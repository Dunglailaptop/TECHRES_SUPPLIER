//
//  DialogChooseRestaurantRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChooseRestaurantRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    
    var sourceView:UIViewController?
    private func createViewController() -> UIViewController{
        let view = DialogChooseRestaurantViewController(nibName: "DialogChooseRestaurantViewController", bundle: Bundle.main)
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
