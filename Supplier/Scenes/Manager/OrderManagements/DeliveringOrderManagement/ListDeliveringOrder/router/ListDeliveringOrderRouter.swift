//
//  ListDeliveringOrderRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ListDeliveringOrderRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ListDeliveringOrderViewController(nibName: "ListDeliveringOrderViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToListDeliveringOrderViewController(dataDetail: SupplierOrders){
        let detailDeliveringOrderViewController = DetailDeliveringOrderRouter().viewController as? DetailDeliveringOrderViewController
        detailDeliveringOrderViewController?.dataDetail = dataDetail
        sourceView?.navigationController?.pushViewController(detailDeliveringOrderViewController!, animated: true)
      }
}
