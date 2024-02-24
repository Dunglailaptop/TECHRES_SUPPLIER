//
//  CompleteOrderManagementViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

//MARK: CALL API
extension CompleteOrderManagementViewController {
    func getSupplierOrdersList(){
        viewModel.getlistRestaurant().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data) {
                    
                    viewModel.data.accept(dataFromServer)
                    
                    var cloneData = self.viewModel.dataArray.value
                    cloneData.append(contentsOf: dataFromServer.list)
                    viewModel.dataArray.accept(cloneData.filter({$0.total_done > 0}))
                    if(cloneData.count == 0){
                        self.viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: self.root_view_empty_data)
                    }else{
                        Utils.isHideAllView(isHide: true, view: self.root_view_empty_data)
                    }
                    
                    if(self.viewModel.limit.value < dataFromServer.list.count){
                        self.lastPosition = true
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
