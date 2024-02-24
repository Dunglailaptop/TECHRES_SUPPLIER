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
class ItemsManagementRouter{
    var viewController: UIViewController{
        return createViewController()
    }
    private var sourceView:UIViewController?
    
    private func createViewController()-> UIViewController {
        let view = ItemsManagementViewController(nibName: "ItemsManagementViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }

    func navigateToDetailedItemsManagemenTViewController(item:Material,isAllowEditting:Bool){
        let detailedItemsManagemenTViewController = DetailedItemsManagementRouter().viewController as! DetailedItemsManagementViewController
        detailedItemsManagemenTViewController.item = item
        detailedItemsManagemenTViewController.isAllowEditing = isAllowEditting
        sourceView?.navigationController?.pushViewController(detailedItemsManagemenTViewController, animated: true)
    }
   
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
}
