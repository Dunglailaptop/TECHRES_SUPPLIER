//
//  DetailPendingInventoryRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailPendingInventoryRouter {
    private var sourceView:UIViewController?
    
    var viewController:UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = DetailPendingInventoryViewController(nibName: "DetailPendingInventoryViewController", bundle: Bundle.main)
        return view
    }

    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }

    func navigatePopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
