//
//  PendingOrderManagementViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

//MARK: CALL API
extension PendingOrderManagementViewController {
    func getSupplierOrdersRequestList(){
        viewModel.getlistRestaurant().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data) {
                    
                    viewModel.data.accept(dataFromServer)
                    
                    var cloneData = viewModel.dataArray.value
                    cloneData.append(contentsOf: dataFromServer.list)
                    if(cloneData.filter({$0.total_waiting > 0}).count > 0){
                        viewModel.dataArray.accept(cloneData.filter({$0.total_waiting > 0}))
                        Utils.isHideAllView(isHide: true, view: root_view_empty_data)
                    }else{
                        viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: root_view_empty_data)
                    }
                    
                    if(viewModel.limit.value < dataFromServer.list.count){
                        lastPosition = true
                    }
                    spinner.stopAnimating()
                                        
                    dLog(dataFromServer.toJSON())
                }
               
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
            }
         
        }).disposed(by: rxbag)
    }
}
