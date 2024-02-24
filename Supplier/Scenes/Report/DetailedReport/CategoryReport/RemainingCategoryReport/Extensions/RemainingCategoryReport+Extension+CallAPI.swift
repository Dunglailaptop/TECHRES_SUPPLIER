//
//  ImportItemsReport+Extension+CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper

extension RemainingCategoryReportViewController {
    func getCategoryReport() {
        viewModel.getCategoryReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialReport>().map(JSONObject: response.data) {
                    dLog(dataFromServer.toJSON())
                    
                    viewModel.data.accept(dataFromServer)
                    viewModel.dataArray.accept(dataFromServer.data)
                    setUpPieChart(dataChart: dataFromServer.data)
                    
                    Utils.isHideAllView(isHide: dataFromServer.total_import_amount > 0 ? true : false, view: root_view_empty_data_chart)
                    Utils.isHideAllView(isHide: dataFromServer.data.count > 0 ? true : false, view: root_view_empty_data)
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
}
