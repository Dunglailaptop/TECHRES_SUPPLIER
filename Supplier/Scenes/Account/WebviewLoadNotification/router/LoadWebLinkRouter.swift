//
//  LoadWebLinkRouter.swift
//  ALOLINE
//
//  Created by Kelvin on 06/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class LoadWebLinkRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    private var sourceView: UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = LoadWebLinkViewController(nibName: "LoadWebLinkViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
}
