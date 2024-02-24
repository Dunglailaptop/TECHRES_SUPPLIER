//
//  CancelExportInventoryRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class CancelExportInventoryRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = CancelExportInventoryViewController(nibName: "CancelExportInventoryViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailCancelExportInventoryViewController(idDetail: Int){
        let detailViewController = DetailCancelExportInventoryRouter().viewController as? DetailCancelExportInventoryViewController
        detailViewController?.idDetail = idDetail
        sourceView?.navigationController?.pushViewController(detailViewController!, animated: true)
    }
}
