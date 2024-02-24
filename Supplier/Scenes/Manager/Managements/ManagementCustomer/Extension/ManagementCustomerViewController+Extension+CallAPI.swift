//
//  ManagementListCustomerViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import RxSwift
import ObjectMapper

extension ManagementCustomerViewController {
    func getRestaurant() {
        viewModel.getlistRestaurant().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    
                    var cloneData = viewModel.dataArray.value
                    cloneData.append(contentsOf: dataFromServer.list)
                    if(cloneData.count > 0){
                        viewModel.dataArray.accept(cloneData)
                        Utils.isHideAllView(isHide: true, view: root_view_empty_data)
                    }else{
                        viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: root_view_empty_data)
                    }
                    
                    if(viewModel.limit.value < dataFromServer.list.count){
                        lastPosition = true
                    }
                    spinner.stopAnimating()
                      
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
