//
//  ReceiptAndPaymentViewController + Extension + A{I.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 19/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
extension ReceiptAndPaymentViewController{
    
    
//    func mapData(data:[ReceiptPayment]){
//        /*hàm này dùng để filter dữ liệu cần hiển thị, và hiển thị tổng số lượng đang waiting and completed and cancel trên tab sub-header*/
//        viewModel.dataArray.accept(data.filter({(element) in element.status == viewModel.status.value}))
//        tableView.reloadSections(IndexSet([0]), with: .none)
//        view_empty_data.isHidden = viewModel.dataArray.value.count > 0 ? true : false
//
//        /*
//            status = 1 -> đang chờ xử lý
//            status = 2 -> đã hoàn thành
//            status = 3 -> đã huỷ
//         */
//        let waitingNumber = data.filter({(element) in element.status == 1}).count
//        let completedNumber = data.filter({(element) in element.status == 2}).count
//        let cancelNumber = data.filter({(element) in element.status == 3}).count
//        lbl_waiting_hint.text = String(format: "%@", waitingNumber > 99 ? "99+" : String(waitingNumber) )
//        lbl_completed_hint.text = String(format: "%@", completedNumber > 99 ? "99+" : String(completedNumber) )
//        lbl_cancel_hint.text = String(format: "%@", cancelNumber > 99 ? "99+" : String(cancelNumber) )
//    }
//
    
    
    func getReceiptAndPaymentList(){
        viewModel.getReceiptAndPaymentList().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ReceiptPaymentResponse>().map(JSONObject: response.data) {
                    
                    var pagination = viewModel.pagination.value
                    pagination.total_record = dataFromServer.total_record
           
                    switch viewModel.status.value{
                        /*
                            status = 1 -> đang chờ xử lý
                            status = 2 -> đã hoàn thành
                            status = 3 -> đã huỷ
                         */
                        case 1:
                            lbl_waiting_hint.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_record)
                        case 2:
                            lbl_completed_hint.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_record)
                        case 3:
                            lbl_cancel_hint.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_record)
                        default:
                            return
                    }
                    
                    if(dataFromServer.data.count > 0 && !pagination.isGetFullData){
                
                        var dataArray = viewModel.dataArray.value
                        dataArray.append(contentsOf: dataFromServer.data)
                        viewModel.dataArray.accept(dataArray)
                 
                        pagination.isGetFullData = viewModel.dataArray.value.count == pagination.total_record ? true : false
                    }
                    pagination.isAPICalling = false
                    viewModel.pagination.accept(pagination)
                    view_empty_data.isHidden = viewModel.dataArray.value.count > 0 ? true : false
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}

