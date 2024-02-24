//
//  ReportDayOffRouter.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class ReceiptAndPaymentRouter{
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ReceiptAndPaymentViewController(nibName: "ReceiptAndPaymentViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }

    
    
    func navigateToDetailedReceiptAndPaymentViewController(receiptPayment:ReceiptPayment){
        let detailedReceiptAndPaymentViewController = DetailedReceiptAndPaymentRouter().viewController as! DetailedReceiptAndPaymentViewController
        detailedReceiptAndPaymentViewController.receiptPayment = receiptPayment
        
        sourceView?.navigationController?.pushViewController(detailedReceiptAndPaymentViewController, animated: true)
    }
    
    func navigateToCreateReceiptAndPaymentViewController(noteType:Int){
        let createReceiptAndPaymentViewController = CreateReceiptAndPaymentRouter().viewController as! CreateReceiptAndPaymentViewController
        createReceiptAndPaymentViewController.noteType = noteType
        sourceView?.navigationController?.pushViewController(createReceiptAndPaymentViewController, animated: true)
    }
    
    
    func navigateToReceiptAndPaymentCatetoryViewController(){
        let receiptAndPaymentCatetoryViewController = ReceiptAndPaymentCategoryRouter().viewController as! ReceiptAndPaymentCatetoryViewController
        receiptAndPaymentCatetoryViewController.callBackToPopViewController = navigateToPopViewController
        sourceView?.navigationController?.pushViewController(receiptAndPaymentCatetoryViewController, animated: false)
    }
    
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
