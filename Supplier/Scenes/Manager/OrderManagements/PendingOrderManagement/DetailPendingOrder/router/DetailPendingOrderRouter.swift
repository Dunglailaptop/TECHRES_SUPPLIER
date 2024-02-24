//
//  DetailPendingOrderRouter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailPendingOrderRouter {
    private var sourceView:UIViewController?
//    var detailEmployeeId = 0
    
    var viewController:UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = DetailPendingOrderViewController(nibName: "DetailPendingOrderViewController", bundle: Bundle.main)
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