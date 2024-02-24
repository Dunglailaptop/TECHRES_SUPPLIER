//
//  PaymentBillDebtViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert
//MARK: Handler dialog cancel
extension AccountsPayableViewController: SupplierDebtPaymentBillDelegate {
    
    func callBackAcceptSupplierDebtPaymentBill() {
        createSupplierWarehouseSessions()
    }
    
    func presentModalDialogAcceptSupplierWarehouse() {
        
        let dialogAcceptCreatePaymentBillViewController = DialogAcceptCreatePaymentBillViewController()
        
        dialogAcceptCreatePaymentBillViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogAcceptCreatePaymentBillViewController.delegate = self
        let nav = UINavigationController(rootViewController: dialogAcceptCreatePaymentBillViewController)
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
}


extension AccountsPayableViewController: SambagDatePickerViewControllerDelegate{
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        var search = viewModel.search.value
        
        switch viewModel.search.value.dateType{
            case 1:
                if(isDateValid(fromDate: result.description, toDate: search.to_date)){
                    search.from_date = result.description
                    lbl_from_date.text = result.description
                    viewModel.search.accept(search)
                    viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày bắt đầu không được lớn hơn ngày kết thúc",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                        lbl_from_date.text = search.from_date
                }
                break

            case 2:
                if(isDateValid(fromDate: search.from_date, toDate:result.description)){
                    search.to_date = result.description
                    lbl_to_date.text = result.description
                    viewModel.search.accept(search)
                    viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày kết thúc không được bé hơn ngày bắt đầu",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                        lbl_to_date.text = search.to_date
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


    private func isDateValid(fromDate:String, toDate:String)-> Bool{
        let from_date = fromDate.components(separatedBy: "/")
        let to_date = toDate.components(separatedBy: "/")
        let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        return from_date_in <= to_date_in
    }
}


