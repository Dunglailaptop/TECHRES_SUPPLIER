//
//  DeliveringOrderManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DeliveringOrderManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = DeliveringOrderManagementViewController(nibName: "DeliveringOrderManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToListDeliveringOrderViewController(restaurant_id: Int){
        let listDeliveringOrderViewController = ListDeliveringOrderRouter().viewController as? ListDeliveringOrderViewController
        listDeliveringOrderViewController?.restaurant_id = restaurant_id
        sourceView?.navigationController?.pushViewController(listDeliveringOrderViewController!, animated: true)
      }
}
