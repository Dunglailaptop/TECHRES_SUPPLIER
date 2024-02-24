//
//  ManagementCustomerBrandViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import ObjectMapper

extension ManagementCustomerBrandViewController{
    func getBrandCustomer() {
        viewModel.getBrandCustomer().subscribe(onNext: { [self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response.toJSON())
                if let dataFromServer = Mapper<BrandResponse>().map(JSONObject: response.data){
                    
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
