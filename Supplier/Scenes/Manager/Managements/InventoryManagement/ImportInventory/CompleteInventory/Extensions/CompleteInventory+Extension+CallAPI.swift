//
//  CompleteInventoryViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

//MARK: CALL API
extension CompleteInventoryViewController {
    func getSupplierWarehouseSessions(){
        viewModel.getSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierWarehouseSessionsResponse>().map(JSONObject: response.data) {
                    
                    viewModel.data.accept(dataFromServer)
                    viewModel.dataArray.accept(dataFromServer.data)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false , view: root_view_empty_data)
//                    dLog(dataFromServer.toJSON())
                }
               
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
         
        }).disposed(by: rxbag)
    }
}
