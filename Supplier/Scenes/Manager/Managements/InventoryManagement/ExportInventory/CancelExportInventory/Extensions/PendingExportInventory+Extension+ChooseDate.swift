//
//  DetailCancelExportInventoryViewController+Extension+ChooseDate.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 19/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension DetailCancelExportInventoryViewController: SambagDatePickerViewControllerDelegate {
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
          dLog(result.description)
        viewModel.clearData()
        if(type_choose_date == 0) {
            viewModel.from_date.accept(result.description)
            lbl_from_date.text = result.description
            viewModel.clearData()
            getSupplierWarehouseSessions()
        } else {
            viewModel.to_date.accept(result.description)
            lbl_to_date.text = result.description
            viewModel.clearData()
            getSupplierWarehouseSessions()
        }
        
        let from_date = viewModel.from_date.value.components(separatedBy: "/")
        let to_date = viewModel.to_date.value.components(separatedBy: "/")
    
        let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        
        // MARK: Xét điều kiện ngày bắt đầu ko được lớn hơn ngày kết thúc
        if(from_date_in > to_date_in){
            JonAlert.show(message: "Ngày bắt đầu không được lớn hơn ngày kết thúc!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            if(type_choose_date == 0){
                lbl_from_date.text = Utils.getCurrentDateString()
            }else{
                lbl_to_date.text = Utils.getCurrentDateString()
            }
            viewModel.from_date.accept(Utils.getCurrentDateString())
            viewModel.clearData()
            getSupplierWarehouseSessions()
        }
          viewController.dismiss(animated: true, completion: nil)
      }

      func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
          viewController.dismiss(animated: true, completion: nil)
      }

      func showDateTimePicker(dataDateTime : String){
          let vc = SambagDatePickerViewController()
          var limit = SambagSelectionLimit()
          var dateNow = Date()
          let dateString = dataDateTime
          let dateFormatter = DateFormatter()
          dateFormatter.dateFormat = "dd/MM/yyyy"
          dateNow = dateFormatter.date(from: dateString)!
          limit.selectedDate = dateNow
          
          let currentDate = Date()
          let minDate = Calendar.current.date(byAdding: .year, value: -1000, to: currentDate)
          let maxDate = Calendar.current.date(byAdding: .year, value: 1000, to: currentDate)
          
          limit.minDate = minDate
          limit.maxDate = maxDate
          vc.limit = limit
          vc.delegate = self
          present(vc, animated: true, completion: nil)
      }
    
}