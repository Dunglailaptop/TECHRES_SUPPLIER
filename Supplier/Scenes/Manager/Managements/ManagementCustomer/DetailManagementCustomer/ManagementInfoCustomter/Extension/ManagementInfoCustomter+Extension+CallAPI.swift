//
//  ManagementInfoDetailCustomerViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import ObjectMapper

extension ManagementInfoCustomerViewController{
    func getDetailCustomer() {
        viewModel.getDetailCustomerReport().subscribe(onNext: { [self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                if let data = Mapper<CustomerReport>().map(JSONObject: response.data)
                {
                    setupTotal()
                    viewModel.dataArray.accept(data)
                    lbl_total_count.text = Utils.stringQuantityFormatWithNumber(amount: data.total_order)
                    lbl_total_amount.text =  Utils.stringQuantityFormatWithNumber(amount: data.total_order_amount)
                    lbl_waittingPayment_count.text =  Utils.stringQuantityFormatWithNumber(amount: data.waitting_payment)
                    lbl_waittingPayment_amount.text = Utils.stringQuantityFormatWithNumber(amount: data.waitting_payment_amount)
                    lbl_successPayment_count.text =  Utils.stringQuantityFormatWithNumber(amount: data.done)
                    lbl_successPayment_amount.text =  Utils.stringQuantityFormatWithNumber(amount: data.done_amount)
                    lbl_canceled_count.text =  Utils.stringQuantityFormatWithNumber(amount: data.canceled)
                  
                }
                dLog(response.toJSON())
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    func setupTotal() {
        lbl_total_amount.adjustsFontSizeToFitWidth = true
        lbl_successPayment_amount.adjustsFontSizeToFitWidth = true
        lbl_waittingPayment_amount.adjustsFontSizeToFitWidth = true
    }
}
