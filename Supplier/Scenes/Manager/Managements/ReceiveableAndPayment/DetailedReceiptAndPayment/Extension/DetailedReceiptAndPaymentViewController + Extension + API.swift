//
//  DetailedReceiptAndPayment.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert
// MARK:call API
extension DetailedReceiptAndPaymentViewController {
    func getReceiptAndPaymentDetail(){
        viewModel.getReceiptAndPaymentDetail().subscribe(onNext: {[self] (response) -> Void in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if let receiptPaymentDetail = Mapper<ReceiptPayment>().map(JSONObject:response.data){
                    mapData(receiptPaymentDetail:receiptPaymentDetail)
                    viewModel.receiptPaymentDetail.accept(receiptPaymentDetail)
                    viewModel.orderList.accept(receiptPaymentDetail.supplier_orders)
                    tableView.reloadData()
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration: 2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    
    func changeReceiptAndPaymentStatus(status:Int,reason:String){
        viewModel.changeReceiptAndPaymentStatus(status: status, reason:reason).subscribe(onNext: {[self] (response) -> Void in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: status == 3 ? "Huỷ phiếu thành công" : "xác nhận phiếu thành công",duration:2.0)
                viewModel.makePopViewController()
            }else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Xác nhận không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            }else{
                JonAlert.showError(message: response.message ?? "",duration: 2.0)
            }
        }).disposed(by: rxbag)
    }
    

    
    
 
    
    

}
