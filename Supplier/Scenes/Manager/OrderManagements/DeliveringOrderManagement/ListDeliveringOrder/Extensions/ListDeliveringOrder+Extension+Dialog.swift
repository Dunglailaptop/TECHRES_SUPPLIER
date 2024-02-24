//
//  ListPendingOrder+Extension+Dialog.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 19/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension ListDeliveringOrderViewController: CreatePaymentRequestPopupDelegate{
  
    func presentModalDialogFilterRestaurantBranch() {
        
        let dialogFilterRestaurantBranchViewController = DialogFilterRestaurantBranchViewController()
        
        dialogFilterRestaurantBranchViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogFilterRestaurantBranchViewController.dataRestaurant = viewModel.dataRestaurant.value
        dialogFilterRestaurantBranchViewController.dataBrand = viewModel.dataBrand.value
        dialogFilterRestaurantBranchViewController.dataBranch = viewModel.dataBranch.value
        dialogFilterRestaurantBranchViewController.is_restaurant = false
        dialogFilterRestaurantBranchViewController.delegate = self
        let nav = UINavigationController(rootViewController: dialogFilterRestaurantBranchViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
    
    func callBackToGetResult(restaurant: Restaurant, brand: Restaurant, branch: Restaurant) {
        viewModel.brand_id.accept(brand.id)
        viewModel.branch_id.accept(branch.id)
        viewModel.dataBrand.accept(brand)
        viewModel.dataBranch.accept(branch)
        viewModel.clearDataAndCallAPI()
    }
}
