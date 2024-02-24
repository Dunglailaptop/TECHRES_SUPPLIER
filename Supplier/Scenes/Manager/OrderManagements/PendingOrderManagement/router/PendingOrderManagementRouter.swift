//
//  PendingOrderManagementRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class PendingOrderManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = PendingOrderManagementViewController(nibName: "PendingOrderManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToListPendingOrderViewController(restaurant_id: Int){
        let listPendingOrderViewController = ListPendingOrderRouter().viewController as? ListPendingOrderViewController
        listPendingOrderViewController?.restaurant_id = restaurant_id
        sourceView?.navigationController?.pushViewController(listPendingOrderViewController!, animated: true)
      }
}
