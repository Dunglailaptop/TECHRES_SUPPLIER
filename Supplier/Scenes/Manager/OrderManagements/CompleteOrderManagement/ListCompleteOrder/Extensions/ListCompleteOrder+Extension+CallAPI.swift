//
//  ListCompleteOrderViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

//MARK: CALL API
extension ListCompleteOrderViewController {
    func getSupplierOrdersRequestList(){
        viewModel.getSupplierOrdersRequest().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierOrdersResponse>().map(JSONObject: response.data) {
                    
                    viewModel.data.accept(dataFromServer)
                    var cloneData = self.viewModel.dataArray.value
                    cloneData.append(contentsOf: dataFromServer.data)
                    viewModel.dataArray.accept(cloneData)
                    if(cloneData.count == 0){
                        self.viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: self.root_view_empty_data)
                    }else{
                        Utils.isHideAllView(isHide: true, view: self.root_view_empty_data)
                    }
                    
                    if(self.viewModel.limit.value < dataFromServer.data.count){
                        self.lastPosition = true
                    }
                    spinner.stopAnimating()
                    dLog(dataFromServer.toJSON())
                }
               
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
         
        }).disposed(by: rxbag)
    }
}
