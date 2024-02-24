//
//  ManagementViewController+Extension.swift
//  SEEMT
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//
import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert

/*
//MARK: CALL API
extension ManagementViewController {
    func getEmployeesCountWaiting(){
        viewModel.getEmployeesCountWaiting().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<EmployeesCountWaitingResponse>().map(JSONObject: response.data) {
                    
                    self.lbl_record_waiting_leave_manager.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_leave_form )
                    self.lbl_record_waiting_addition_manager.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_salary_additions )
                    self.lbl_record_waiting_advance_salary_manager.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_advance_salary )
                    self.lbl_record_waiting_target_manager.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_targets )
//                    self.lbl_record_waiting_advance_salary_manager.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_advance_salary )
                    
                    
                    self.view_record_waiting_leave_manager.isHidden = dataFromServer.total_leave_form == 0 ? true : false
                    self.view_record_waiting_addition_manager.isHidden = dataFromServer.total_salary_additions == 0 ? true : false
                    self.view_record_waiting_advance_salary_manager.isHidden = dataFromServer.total_advance_salary == 0 ? true : false
                    self.view_record_waiting_target_manager.isHidden = dataFromServer.total_targets == 0 ? true : false
                    
                    
                    
                    
                    self.view_record_waiting_salary_table.isHidden = true// dataFromServer.total_advance_salary == 0 ? true : false
                    
                    let badgeValue = dataFromServer.total_leave_form + dataFromServer.total_salary_additions + dataFromServer.total_targets + dataFromServer.total_advance_salary > 99
                    ? "99+" : String(format: "%d", dataFromServer.total_leave_form + dataFromServer.total_salary_additions + dataFromServer.total_targets + dataFromServer.total_advance_salary)
                    
                    

                    let badgeValueNotification = ["messageInfo": ["seemtBadgeValue": badgeValue]]
                    
                    
                    NotificationCenter.default
                                .post(name:NSNotification.Name("vn.techres.seemt.badgeValue"),
                                 object: nil,
                                 userInfo: badgeValueNotification)
                    
                    
                }
            }
//            else{
//                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại",andIcon: UIImage(named: "icon-warning"), duration: 2.5)
//                dLog(response.message ?? "")
//            }

        }).disposed(by: rxbag)
        
       
    }
}
*/
