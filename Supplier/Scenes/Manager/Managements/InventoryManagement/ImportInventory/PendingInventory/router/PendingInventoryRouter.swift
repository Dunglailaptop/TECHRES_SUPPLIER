//
//  PendingInventoryRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class PendingInventoryRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = PendingInventoryViewController(nibName: "PendingInventoryViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailPendingInventoryViewController(idDetail: Int){
        let detailPendingInventoryViewController = DetailPendingInventoryRouter().viewController as? DetailPendingInventoryViewController
        detailPendingInventoryViewController?.idDetail = idDetail
        sourceView?.navigationController?.pushViewController(detailPendingInventoryViewController!, animated: true)
      }
}
