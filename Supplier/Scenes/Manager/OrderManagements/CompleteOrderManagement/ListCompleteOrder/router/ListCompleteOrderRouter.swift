//
//  ListCompleteOrderRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ListCompleteOrderRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ListCompleteOrderViewController(nibName: "ListCompleteOrderViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailCompleteOrderViewController(dataDetail: SupplierOrders){
        let listCompleteOrderViewController = DetailCompleteOrderRouter().viewController as? DetailCompleteOrderViewController
        listCompleteOrderViewController?.dataDetail = dataDetail
        sourceView?.navigationController?.pushViewController(listCompleteOrderViewController!, animated: true)
      }
}
