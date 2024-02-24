//
//  PaymentRequestViewController+Extension+ChooseDate.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 21/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension PaymentRequestViewController: SambagDatePickerViewControllerDelegate{
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        var cloneAPIParameter = viewModel.APIParameter.value
        
        switch viewModel.dateType.value{
            case 1:
                if(Utils.isDateValid(fromDateStr: result.description, toDateStr: cloneAPIParameter.to_date)){
                        cloneAPIParameter.from_date = result.description
                        lbl_from_date.text = result.description
                        viewModel.APIParameter.accept(cloneAPIParameter)
                        viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày bắt đầu không được lớn hơn ngày kết thúc",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                        lbl_from_date.text = cloneAPIParameter.from_date
                }
                break

            case 2:
            
                if(Utils.isDateValid(fromDateStr: cloneAPIParameter.from_date, toDateStr:result.description)){
                    cloneAPIParameter.to_date = result.description
                    viewModel.APIParameter.accept(cloneAPIParameter)
                    lbl_to_date.text = result.description
                    viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày kết thúc không được bé hơn ngày bắt đầu",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                        lbl_to_date.text = cloneAPIParameter.to_date
                }
                break

            default:
                break
        }

        viewController.dismiss(animated: true, completion: nil)
    }

    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

    func showDateTimePicker(dateTimeData:String){
        let vc = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()

        var dateNow = Date()
        let dateString = dateTimeData == "" ? Utils.getCurrentDateString() : dateTimeData
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
