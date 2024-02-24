//
//  DetailedAccountsPayableRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedAccountsPayableRouter {
    private var sourceView:UIViewController?
    
    var viewController:UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = DetailedAccountsPayableViewController(nibName: "DetailedAccountsPayableViewController", bundle: Bundle.main)
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
