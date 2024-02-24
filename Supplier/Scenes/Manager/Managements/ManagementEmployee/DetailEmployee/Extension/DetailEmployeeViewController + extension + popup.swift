//
//  DetailEmployeeViewController + extension + popup.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

//DialogBirthday
extension DetailEmployeeViewController: SambagDatePickerViewControllerDelegate{
    
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        let selectedDate = result.asDate
        let currentDate = Date()
        if let selectedDate = selectedDate, selectedDate > currentDate{
            viewModel.closure.value()
        }else {
           
            var cloneEmployeeInfor = viewModel.employeeInfor.value
            cloneEmployeeInfor.birthday = result.description
            viewModel.employeeInfor.accept(cloneEmployeeInfor)
            lbl_birthday.text = result.description
            viewController.dismiss(animated: true, completion: nil)
            checkDailog = true
        }
     
    }
    
    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func showDateTimePicker(dateTimeData:String){

        let vc = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()
        
        var dateNow = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateNow = dateFormatter.date(from: dateTimeData) ?? dateNow
        limit.selectedDate = dateNow

        // Set the minimum and maximum selectable dates
        let calendar = Calendar.current
        let currentDate = Date()
        let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
//        let minDate = dateFormatter.date(from: "11/10/1990")
//        let maxDate = dateFormatter.date(from: "29/08/2023")
        let maxDate = calendar.date(byAdding: .day, value: 0, to: currentDate) // One year from now

        limit.minDate = minDate
        limit.maxDate = maxDate
        viewModel.closure.value()
        viewModel.closure.accept {
        
            vc.limit?.maxDate = maxDate
            vc.yearWheel.loadView()
            vc.loadView()
        }

      
  
        
        
        vc.limit = limit
        vc.delegate = self
        present(vc, animated: true, completion: nil)
       }
}

extension DetailEmployeeViewController: DialogConfirmDelegate {
    func prensentDialogConfirm(content:String = ""){
        let dialogConfirm = DialogConfirmViewController()
        dialogConfirm.view.backgroundColor = ColorUtils.blackTransparent()
        dialogConfirm.dialog_type = dialogConfirm.CONFIRM_DIALOG
        dialogConfirm.dialogWidth = 300
        dialogConfirm.dialogConfirmDelegate = self
        dialogConfirm.dialogConfrimAccessEmployeeCreate = self
        dialogConfirm.isCheckPopUpCreateEmployee = true
        dialogConfirm.dialog_title = "THÔNG BÁO"
        
        /*
            0 là dialog thông báo "Bạn có chắc chắn thêm nhân viên này không?"
            1 là dialog thông báo "Thêm mới nhân viên thành công"
         */
        if viewModel.dialogType.value == 1{
            dialogConfirm.isAllowAttributedText = true
            dialogConfirm.lbl_content_dialog.textAlignment = .left
            dialogConfirm.view_btn_cancel.isHidden = true
            dialogConfirm.lbl_content_dialog.attributedText = Utils.setMultipleColorForLabel(
                label: dialogConfirm.lbl_content_dialog,
                attributes: [
                    (str:"     Thêm mới nhân viên thành công\n\n", color:ColorUtils.gray_600()),
                    (str:"NHÀ CUNG CẤP: ",color:ColorUtils.gray_600()),
                    (str:viewModel.createdAccount.value.identify_name + "\n",color:.black),
                    (str:"TÀI KHOẢN: ",color:ColorUtils.gray_600()),
                    (str:viewModel.createdAccount.value.username + "\n",color:.black),
                    (str:"MẬT KHẨU: ",color:ColorUtils.gray_600()),
                    (str:viewModel.createdAccount.value.password + "\n",color:.black),
                ])
        }else {
            dialogConfirm.dialog_content = content
        }
        
        let nav = UINavigationController(rootViewController: dialogConfirm)
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
     
     func callBackToConfirm() {
         if viewModel.dialogType.value == 0{
             self.imagecover.count > 0 ? self.createEmployeeWithAvatar() : self.createEmployeeWithoutAvatar()
         }else {
             viewModel.makePopViewController()
         }
        
     }
    
}
