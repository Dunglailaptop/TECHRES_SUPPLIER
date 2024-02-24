//
//  CompleteOrderManagementRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class CompleteOrderManagementRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = CompleteOrderManagementViewController(nibName: "CompleteOrderManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToListCompleteOrderViewController(restaurant_id: Int){
        let listCompleteOrderViewController = ListCompleteOrderRouter().viewController as? ListCompleteOrderViewController
        listCompleteOrderViewController?.restaurant_id = restaurant_id
        sourceView?.navigationController?.pushViewController(listCompleteOrderViewController!, animated: true)
      }
}
