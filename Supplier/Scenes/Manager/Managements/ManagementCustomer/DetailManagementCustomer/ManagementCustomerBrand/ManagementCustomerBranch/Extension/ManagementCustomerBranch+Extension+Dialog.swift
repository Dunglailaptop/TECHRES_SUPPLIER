//
//  ManagementCustomerBranch+Extension+Dialog.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 20/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension ManagementCustomerBranchViewController: CreatePaymentRequestPopupDelegate {
    
    func showPopupFilter(){
        let popupViewController = PopupChooseRestaurantViewController()
        popupViewController.popupType = .brand
        popupViewController.isChooseOnceTime = true
        popupViewController.input = Restaurant(id: viewModel.restaurant_id.value)
        popupViewController.delegate = self
        popupViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: popupViewController)
        // 1
        nav.modalPresentationStyle = .overFullScreen

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

    func callBackToGetResult(restaurant:Restaurant, brand:Restaurant, branch:Restaurant){
        viewModel.restaurant_brand_id.accept(brand.id)
        
        lbl_brand_name.text = brand.name
        lbl_brand_phone.text = brand.phone
        
        viewModel.clearDataAndCallAPI()
    }
}
