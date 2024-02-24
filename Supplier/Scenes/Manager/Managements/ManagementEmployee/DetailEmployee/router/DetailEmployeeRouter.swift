//
//  DetailEmployeeRouter.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailEmployeeRouter: NSObject {
    private var sourceView:UIViewController?
    var detailEmployeeId = 0
    
    var viewController:UIViewController{
        return createViewController()
    }
    
    private func createViewController() -> UIViewController{
        let view = DetailEmployeeViewController(nibName: "DetailEmployeeViewController", bundle: Bundle.main)
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
