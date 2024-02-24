//
//  ExportReportViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxRelay



extension ExportReportViewController {
    func getExportItemReport() {
        viewModel.getExportItemReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let cancelItemReport = Mapper<CancelItemReport>().mapArray(JSONObject: response.data) {
                    dLog(cancelItemReport)
                    self.contraints_height_tableView.constant = CGFloat(cancelItemReport.count * 40)
                    viewModel.dataArray.accept(cancelItemReport)
                    setByCategoryFoodRevenuePieChart(revenues: viewModel.dataArray.value)
                    setup()
                    self.view_nodata.isHidden = cancelItemReport.count > 0 ? true:false
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
    func setup() {
       
        lbl_total_money.text = Utils.stringQuantityFormatWithNumber(amount: viewModel.dataArray.value.map { $0.total_amount }.reduce(0, +) ?? 0)
        lbl_total_amount.text = String(viewModel.dataArray.value.count)
       
    }
}
