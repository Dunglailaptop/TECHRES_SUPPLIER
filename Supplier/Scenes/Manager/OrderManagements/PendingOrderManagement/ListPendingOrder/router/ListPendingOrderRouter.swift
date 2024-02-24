//
//  ListPendingOrderRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ListPendingOrderRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ListPendingOrderViewController(nibName: "ListPendingOrderViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailPendingOrderViewController(dataDetail: SupplierOrdersRequest){
        let detailPendingOrderViewController = DetailPendingOrderRouter().viewController as? DetailPendingOrderViewController
        detailPendingOrderViewController?.dataDetail = dataDetail
        sourceView?.navigationController?.pushViewController(detailPendingOrderViewController!, animated: true)
      }
}
