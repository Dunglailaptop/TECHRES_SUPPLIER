//
//  FeedBackRouter.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class FeedBackRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = FeedBackViewController(nibName: "FeedBackViewController", bundle: Bundle.main)
        return view
    }
    
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    
}
