//
//  RestaurantOrderReportViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_01 on 04/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import ObjectMapper
extension RestaurantOrderReportViewController{
    func getRestaurantOrderReport() {
        viewModel.getRestaurantOrderReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let restaurantOrderReport = Mapper<RestaurantOrderReportModel>().map(JSONObject: response.data) {
                    
                    self.lbl_total_amount.text = restaurantOrderReport.total_amount
                    self.lbl_total_order.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: restaurantOrderReport.restaurantOrders!.count)
                    
                    height_tableView.constant = CGFloat(restaurantOrderReport.restaurantOrders!.count * 50 )
                    tableView.reloadData()
                    
                    if let restaurantOrders = restaurantOrderReport.restaurantOrders{
                        self.setupPieChart(restaurantOrder: restaurantOrders)
                        self.viewModel.restaurantOrder.accept(restaurantOrders)
                    }
                    self.view_nodata.isHidden = restaurantOrderReport.restaurantOrders!.count > 0 ? true : false
                }
                
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        })
    }
}
