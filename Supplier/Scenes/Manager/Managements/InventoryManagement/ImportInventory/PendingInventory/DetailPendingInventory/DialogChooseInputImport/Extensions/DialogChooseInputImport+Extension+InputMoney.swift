//
//  DetailPendingOrder+Extension+InputMoney.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DialogChooseInputImportViewController: InputMoneyDelegate {
    func presentModalInputMoneyViewController(current_money: Int) {
            let dialogInputMoneyViewController = DialogInputMoneyViewController()
            dialogInputMoneyViewController.minMoney = 1000
            dialogInputMoneyViewController.maxMoney = 999999999
            dialogInputMoneyViewController.current_money = current_money
            dialogInputMoneyViewController.delegate = self
            dialogInputMoneyViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputMoneyViewController)
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
    
    func callBackInputMoney(amount: Int, position: Int) {
        self.viewModel.discount_amount.accept(amount)
        self.viewModel.discount_amount_display.accept(amount)
        self.txt_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: amount)
    }
}
