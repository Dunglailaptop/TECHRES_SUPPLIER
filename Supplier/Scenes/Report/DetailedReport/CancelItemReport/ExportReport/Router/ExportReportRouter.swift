//
//  ExportReportRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit

class ExportReportRouter{
    var viewController: UIViewController{
        return createViewController()
    }
    
    var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = ExportReportViewController(nibName: "ExportReportViewController", bundle: Bundle.main)
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
