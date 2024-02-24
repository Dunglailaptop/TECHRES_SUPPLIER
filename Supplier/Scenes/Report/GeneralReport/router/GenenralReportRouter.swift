//
//  GenenralReportRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class GenenralReportRouter: NSObject {
    var viewController: UIViewController{
        return createViewController()
    }
    
    var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = GeneralReportViewController(nibName: "GeneralReportViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    

    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
