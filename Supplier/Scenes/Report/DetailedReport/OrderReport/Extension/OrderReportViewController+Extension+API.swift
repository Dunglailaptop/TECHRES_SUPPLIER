//
//  OrderReportViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert

extension OrderReportViewController {
    func getOrderReport() {
        viewModel.getOrderReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let orderReport = Mapper<OrderReport>().map(JSONObject: response.data) {
                    dLog(orderReport)
                    dLog(viewModel.report_type.value)
                    viewModel.clearData()
                    var dataNew = viewModel.dataArray.value
                    dataNew.append(contentsOf: orderReport.data)
                    viewModel.dataArray.accept(dataNew)
                    setupBarChart(data: orderReport.data, barChart: view_chart)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false, view: view_nodata)
                    
                }
            }else{
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            
            }
         
        }).disposed(by: rxbag)
    }
}
