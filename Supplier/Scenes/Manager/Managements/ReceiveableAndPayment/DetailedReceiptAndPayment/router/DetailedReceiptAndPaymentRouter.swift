//
//  DetailedReceiptAndPaymentRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedReceiptAndPaymentRouter{
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = DetailedReceiptAndPaymentViewController(nibName: "DetailedReceiptAndPaymentViewController", bundle: Bundle.main)
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
