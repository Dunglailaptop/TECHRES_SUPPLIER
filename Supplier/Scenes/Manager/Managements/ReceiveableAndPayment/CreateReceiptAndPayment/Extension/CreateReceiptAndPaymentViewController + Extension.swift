//
//  CreateReceiptAndPaymentViewController + Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import TagListView

extension CreateReceiptAndPaymentViewController: SambagDatePickerViewControllerDelegate{
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func showDateTimePicker(dateTimeData:String){
        let vc = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()
        
        var dateNow = Date()
        let dateString = dateTimeData
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateNow = dateFormatter.date(from: dateString)!
        limit.selectedDate = dateNow

        // Set the minimum and maximum selectable dates
        let calendar = Calendar.current
        let currentDate = Date()
        let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
        let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

        limit.minDate = minDate
        limit.maxDate = maxDate
        vc.limit = limit
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}


extension CreateReceiptAndPaymentViewController:TagListViewDelegate{
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        tag_view.removeTag(title)
        height_of_tag_view.constant = 10 + tag_view.intrinsicContentSize.height
        self.view.layoutIfNeeded()
        var warehouseReceiptList = viewModel.warehouseReceiptList.value
        if let position = warehouseReceiptList.firstIndex(where: {(element) in element.code == title}){
            warehouseReceiptList[position].isSelected = DEACTIVE
        }
        viewModel.warehouseReceiptList.accept(warehouseReceiptList)
        warehouse_receipt_dropdown.optionArray = warehouseReceiptList.filter{$0.isSelected == DEACTIVE}.map{$0.code}
        
    }
 
}




extension CreateReceiptAndPaymentViewController:CaculatorDelegate{

    func presentCalculator(currentFigure:Double) {
        let inputQuantityViewController = InputQuantityViewController()
        inputQuantityViewController.max_quantity = 999999999
        inputQuantityViewController.delegate = self
        inputQuantityViewController.result = currentFigure
        inputQuantityViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: inputQuantityViewController)
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
            present(nav, animated: true, completion: nil)
        }
      
    func callbackToGetResult(number: Double) {
        var cloneAPIParameter = viewModel.APIParameter.value
        cloneAPIParameter.amount = Int(number)
        viewModel.APIParameter.accept(cloneAPIParameter)
        lbl_amount.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: number)
    }
 
}
