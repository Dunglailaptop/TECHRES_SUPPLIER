//
//  ReceiptAndPaymentCategoryRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ReceiptAndPaymentCategoryRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ReceiptAndPaymentCatetoryViewController(nibName: "ReceiptAndPaymentCatetoryViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    
    
    func navigateToPopViewController(callBackToPopViewController: () -> Void = {}){
        sourceView?.navigationController?.popViewController(animated: false)
        callBackToPopViewController()
    }
    
    func navigateToCreateReceiptAndPaymentCategoryViewController(receiptAndPaymentCategory:ReceiptPaymentCategory){
        let createReceiptAndPaymentCategoryViewController = CreateReceiptAndPaymentCategoryRouter().viewController as! CreateReceiptAndPaymentCategoryViewController
        createReceiptAndPaymentCategoryViewController.receiptAndPaymentCategory = receiptAndPaymentCategory
        sourceView?.navigationController?.pushViewController(createReceiptAndPaymentCategoryViewController, animated: true)
    }
    
    
    func navigateToReceiptAndPaymentViewController(screenType:Int){

        // Assuming you have a reference to your UINavigationController
        if let navigationController = sourceView?.navigationController {
            // Iterate through the view controllers in the navigation stack
            for viewController in navigationController.viewControllers {
                // Check if the current view controller is the one you want, and then pop to that view controller as you want
                if let desiredViewController = viewController as? ReceiptAndPaymentViewController {
//                    desiredViewController.screenType = screenType
                    desiredViewController.viewModel.type.accept(screenType)
                    navigationController.popViewController(animated: false)
                    break // Exit the loop since we found the desired view controller
                }
            }
        }
        
       
    }
    
    
    
}
