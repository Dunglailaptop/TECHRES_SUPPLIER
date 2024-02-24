//
//  ShowDateFilter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
extension CreatePaymentRequestViewController:CreatePaymentRequestPopupDelegate{
    
    func showPopup(){
        let popupViewController = PopupChooseRestaurantViewController()
        popupViewController.delegate = self
        popupViewController.popupType = .restaurant
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
   
    

    func callBackToGetResult(restaurant:Restaurant, brand:Restaurant,branch:Restaurant){
        var cloneAPIParameter = viewModel.APIParameter.value
        cloneAPIParameter.restaurant_id = restaurant.id
        cloneAPIParameter.brand_id = brand.id
        cloneAPIParameter.branch_id = branch.id
        viewModel.APIParameter.accept(cloneAPIParameter)
        lbl_restaurant_name.text = restaurant.name
        
        lbl_brand.text = String(format: "%@",brand.name)
        lbl_branch.text = String(format: "%@",branch.name)
        
        
        lbl_please_to_choose_restaurant.isHidden = restaurant.name != "" ? true : false
        view_of_restaurant_name.isHidden = false
        getSupplierOrder()
    }
}


extension CreatePaymentRequestViewController: SambagDatePickerViewControllerDelegate{
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
        
        var paramater = viewModel.APIParameter.value
        
        switch viewModel.dateType.value{
            case 1:
                if(Utils.isDateValid(fromDateStr: result.description, toDateStr: paramater.to_date)){
                        paramater.from_date = result.description
                        lbl_from_date.text = result.description
                    }else {
                        JonAlert.show(
                            message: "Ngày bắt đầu không được lớn hơn ngày kết thúc",
                            andIcon: UIImage(named: "icon-warning"),
                            duration: 2.0)
                       
                }
                break

            case 2:
                if(Utils.isDateValid(fromDateStr: paramater.from_date, toDateStr:result.description)){
                    paramater.to_date = result.description
                    lbl_to_date.text = result.description
                }else {
                    JonAlert.show(
                        message: "Ngày kết thúc không được bé hơn ngày bắt đầu",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                }
                break

            default:
                break
        }
        viewModel.APIParameter.accept(paramater)
        getSupplierOrder()
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

