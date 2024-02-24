//
//  DetailedReportRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedReportRouter {
    var viewController: UIViewController{
        return createViewController()
    }
    
    var sourceView: UIViewController?
    
    private func createViewController() -> UIViewController{
        let view = DetailedReportViewController(nibName: "DetailedReportViewController", bundle: Bundle.main)
        return view
    }
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Error Desconocido")}
        self.sourceView = view
    }
    

    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToOrderReportViewController(){
        let orderReportViewController = OrderReportRouter().viewController as! OrderReportViewController
        sourceView?.navigationController?.pushViewController(orderReportViewController, animated: true)
    
    }
    
    func navigateToCancelItemReportViewController(){
        let cancelItemReportViewController = CancelItemReportRouter().viewController as! CancelItemReportViewController
        sourceView?.navigationController?.pushViewController(cancelItemReportViewController, animated: true)
    }
    
    func navigateToInventoryReportViewController(){
        let inventoryReportViewController = InventoryReportRouter().viewController as! InventoryReportViewController
        sourceView?.navigationController?.pushViewController(inventoryReportViewController, animated: true)
    
    }
    
    func navigateToDebtReportViewController(){
        let debtReportViewController = DebtReportRouter().viewController as! DebtReportViewController
        sourceView?.navigationController?.pushViewController(debtReportViewController, animated: true)
    
    }
    
    func navigateToRestaurantOrderReportViewController(){
        let restaurantOrderReportViewController = RestaurantOrderReportRouter().viewController as! RestaurantOrderReportViewController
        sourceView?.navigationController?.pushViewController(restaurantOrderReportViewController, animated: true)
    
    }
    
    func navigateToItemReportViewController(){
        let itemsReportViewController = ItemsReportRouter().viewController as! ItemsReportViewController
        sourceView?.navigationController?.pushViewController(itemsReportViewController, animated: true)
    }
    
    func navigateToCategoryReportViewController(){
        let categoryReportViewController = CategoryReportRouter().viewController as! CategoryReportViewController
        sourceView?.navigationController?.pushViewController(categoryReportViewController, animated: true)
    
    }
    
    
    
}
