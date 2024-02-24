//
//  ImportedInventoryRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ImportedInventoryRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ImportedInventoryViewController(nibName: "ImportedInventoryViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToDetailImportedInventoryViewController(idDetail: Int){
        let detailImportedInventoryViewController = DetailImportedInventoryRouter().viewController as? DetailImportedInventoryViewController
        detailImportedInventoryViewController?.idDetail = idDetail
        sourceView?.navigationController?.pushViewController(detailImportedInventoryViewController!, animated: true)
      }
}
