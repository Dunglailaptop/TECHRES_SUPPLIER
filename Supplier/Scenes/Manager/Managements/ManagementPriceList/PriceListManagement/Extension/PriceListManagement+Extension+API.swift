//
//  PriceListManagement+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert

extension PriceListManagementViewController {
    func getListSupplier() {
       
        viewModel.getListSupplier().subscribe(onNext: {(response) in
                if(response.code == RRHTTPStatusCode.ok.rawValue){
                    dLog(response.toJSON())
                
                    if let dataFromServer = Mapper<SupplierModel>().map(JSONObject: response.data) {
                        var pagination = self.viewModel.pagination.value
                        pagination.total_record = dataFromServer.total_record
                        
                        if (dataFromServer.list.count > 0 && !pagination.isGetFullData) {
                            var datanew = self.viewModel.dataArray.value
                            datanew.append(contentsOf: dataFromServer.list)
                            self.viewModel.dataArray.accept(datanew)
                            pagination.isGetFullData = self.viewModel.dataArray.value.count == pagination.total_record ? true : false
                        }
                        pagination.isAPICalling = false
                        self.viewModel.pagination.accept(pagination)
                        
                    Utils.isHideAllView(isHide: self.viewModel.dataArray.value.count > 0 ? true: false , view: self.view_empty_data)
                      
                          
                    }
                }else{
                    JonAlert.show(message: "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.5)
                }
            }).disposed(by: rxbag)
        
    }
}
