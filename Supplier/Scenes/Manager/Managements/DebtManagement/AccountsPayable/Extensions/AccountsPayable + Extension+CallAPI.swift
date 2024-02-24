//
//  PaymentBillDebtViewController+Extension+CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert

extension AccountsPayableViewController {
    //API lấy danh sách phiếu nhập kho
    func getSupplierWarehouseSession(){
        viewModel.getSupplierWarehouseSession().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<WarehouseReceiptResponse>().map(JSONObject: response.data) {
                    
                    var pagination = viewModel.pagination.value
                    pagination.totalRecord = dataFromServer.total_record
                    if(dataFromServer.data.count > 0){
                        var list = viewModel.warehouseReceiptList.value
                        list.append(contentsOf: dataFromServer.data)
                        viewModel.warehouseReceiptList.accept(list)
                   
                        pagination.isGetFullData = list.count == pagination.totalRecord ? true : false
                    }
                    if viewModel.warehouseReceiptListHisory.value.count > 0 {
                        var data = viewModel.warehouseReceiptList.value
                        var dataSearch = viewModel.warehouseReceiptListHisory.value
                        dataSearch.enumerated().forEach{(index,value) in
                            data.enumerated().forEach{
                                (index1,value1) in
                                if value1.id == value.id && value.isSelected == ACTIVE {
                                    data[index1].isSelected = ACTIVE
                                }
                            }
                        }
                        viewModel.warehouseReceiptList.accept(data)
                    }
                    pagination.isAPICalling = false
                    viewModel.pagination.accept(pagination)
                    Utils.isHideAllView(isHide: viewModel.warehouseReceiptList.value.count > 0 ? true: false , view: no_data_view)
                    lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.total_amount)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    
    func getReceiptAndPaymenCategory(){
        viewModel.getReceiptAndPaymentCategory().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ReceiptPaymentCategory>().mapArray(JSONObject: response.data) {
                    viewModel.paymenCategory.accept(dataFromServer)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    func createSupplierWarehouseSessions(){
        viewModel.createPayment().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Tạo phiếu chi thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                self.dismiss(animated: true)
                self.viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Xác nhận không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                dLog(response.message ?? "")
            } else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
