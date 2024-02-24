//
//  CreateBonusPunishViewController+Extension+ChooseDate.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 20/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension DetailPendingOrderViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
        dLog(result.description)
        
        let orderTime = viewModel.expected_delivery_time.value.components(separatedBy: "/")
        let deliveryTime = result.description.components(separatedBy: "/")
    
        let orderTimeIn = String(format: "%@%@%@", orderTime[2], orderTime[1], orderTime[0])
        let deliveryTimeIn = String(format: "%@%@%@", deliveryTime[2], deliveryTime[1], deliveryTime[0])
        
        // MARK: Xét điều kiện Ngày giao hàng dự kiến không được nhỏ hơn ngày đặt hàng
        if(orderTimeIn > deliveryTimeIn){
            JonAlert.show(message: "Ngày giao hàng dự kiến không được nhỏ hơn ngày đặt hàng!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            lbl_expected_delivery_time.text = viewModel.expected_delivery_time.value
        }else{
            lbl_expected_delivery_time.text = result.description
            viewModel.expected_delivery_time.accept(result.description)
        }
        
        viewController.dismiss(animated: true, completion: nil)
    }

    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func showDateTimePicker(){
        let vỉewController = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()
        
        var dateNow = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyyy"
            dateNow = dateFormatter.date(from: viewModel.expected_delivery_time.value)!
            limit.selectedDate = dateNow
            
            let calendar = Calendar.current
            let currentDate = Date()
            let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
            let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

            limit.minDate = minDate
            limit.maxDate = maxDate
        
        vỉewController.limit = limit
        vỉewController.delegate = self
        present(vỉewController, animated: true, completion: nil)
    }
}
