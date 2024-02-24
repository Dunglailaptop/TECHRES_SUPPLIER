//
//  Call API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 02/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import ObjectMapper
import JonAlert

extension CreateReceiptAndPaymentViewController {
    
    func getReceiptAndPaymentCategory(){
        viewModel.getReceiptAndPaymentCategory().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ReceiptPaymentCategory>().mapArray(JSONObject: response.data) {
                    viewModel.categoryList.accept(dataFromServer)
                    category_drop_down.optionArray = dataFromServer.map{$0.name}
                    category_drop_down.optionIds = dataFromServer.map{$0.id}
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    //API lấy danh sách phiếu nhập kho
    func getSupplierWarehouseSession(){
        viewModel.getSupplierWarehouseSession().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<WarehouseReceiptResponse>().map(JSONObject: response.data) {
                    viewModel.warehouseReceiptList.accept(dataFromServer.data.map({(element) in
                        var cloneElement = element
                        cloneElement.isSelected = DEACTIVE
                        return cloneElement
                    }))
                    
                    warehouse_receipt_dropdown.optionArray = dataFromServer.data.map{$0.code}
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    
    func createReceiptAndPayment(){
        viewModel.createReceiptAndPayment().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: viewModel.noteType.value == 0 ? "Đã thêm phiếu thu thành công" : "Đã thêm phiếu chi thành công")
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
}
