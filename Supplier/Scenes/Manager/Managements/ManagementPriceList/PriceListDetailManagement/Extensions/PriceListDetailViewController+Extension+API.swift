//
//  PriceListDetailViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert

extension PriceListDetailViewController {
    func getPriceListDetail() {
        viewModel.getDetailPriceList().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response.toJSON())
                
                if let dataFromServer = Mapper<MaterialPriceList>().mapArray(JSONObject: response.data) {
                   
                        self.viewModel.dataArray.accept(dataFromServer)
                        self.viewModel.dataFilter.accept(dataFromServer)
                    Utils.isHideAllView(isHide: self.viewModel.dataArray.value.count > 0 ? true: false , view: self.view_empty_data)
                    dLog(self.viewModel.dataArray.value)
                    self.lbl_total_list.text = self.viewModel.dataArray.value.count == 0 ? "0": String(self.viewModel.dataArray.value.count)

                }
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
            }
            
        }).disposed(by: rxbag)
    }
    
    func getUpdateMaterialPrice() {
        viewModel.getUpdatePrice().subscribe(onNext: { (response) in
            dLog("vao day roi")
            dLog(response.message)
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response.toJSON())
                Toast.show(message: "Cập nhật giá bán thành công",controller: self)
                
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
            }
            
        }).disposed(by: rxbag)
    }
}
