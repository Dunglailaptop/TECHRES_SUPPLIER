//
//  InventoryReportViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import JonAlert
import ObjectMapper

extension InventoryReportViewController {
    func getInventoryReport() {
        viewModel.getInventoryReport().subscribe(onNext: { [self](response) in
            dLog(response.toJSON())
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let inventoryReport = Mapper<InventoryReport>().map(JSONObject: response.data) {
                    self.setupBarChart(revenues: inventoryReport)
                    viewModel.dataReport.accept(inventoryReport)
                    setup(inventoryReport: viewModel.dataReport.value)
                  
                }
            }else{
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
    func setup(inventoryReport: InventoryReport){
        lbl_total_first_amount.text = String(inventoryReport.total_inventory_first_amount)
        lbl_total_cancel_amount.text = Utils.stringQuantityFormatWithNumber(amount: inventoryReport.total_cancel_amount)
        lbl_total_export_amount.text =  Utils.stringQuantityFormatWithNumber(amount: inventoryReport.total_export_amount)
        lbl_total_import_amount.text =  Utils.stringQuantityFormatWithNumber(amount: inventoryReport.total_import_amount)
        lbl_total_Now_amount.text =   Utils.stringQuantityFormatWithNumber(amount: inventoryReport.total_inventory_now_amount)
    }
}
