//
//  PaymentRequestViewController + Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension PaymentRequestViewController: CreatePaymentRequestPopupDelegate{

    func presentModalDialogFilterRestaurantBranch() {
        let dialogFilterRestaurantBranchViewController = DialogFilterRestaurantBranchViewController()

        dialogFilterRestaurantBranchViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogFilterRestaurantBranchViewController.delegate = self
        dialogFilterRestaurantBranchViewController.dataRestaurant = viewModel.dataRestaurant.value
        dialogFilterRestaurantBranchViewController.dataBrand = viewModel.dataBrand.value
        dialogFilterRestaurantBranchViewController.dataBranch = viewModel.dataBranch.value
        dialogFilterRestaurantBranchViewController.is_restaurant = true
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
        var cloneAPIParameter = viewModel.APIParameter.value
        cloneAPIParameter.restaurant_id = restaurant.id
        cloneAPIParameter.brand_id = brand.id
        cloneAPIParameter.branch_id = branch.id
        viewModel.APIParameter.accept(cloneAPIParameter)
        viewModel.dataRestaurant.accept(restaurant)
        viewModel.dataBrand.accept(brand)
        viewModel.dataBranch.accept(branch)
        viewModel.clearDataAndCallAPI()
    }
}
