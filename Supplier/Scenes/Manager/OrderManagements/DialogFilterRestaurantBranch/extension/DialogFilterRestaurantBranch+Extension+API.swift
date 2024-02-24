//
//  DialogChooseRestaurantViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper

//MARK: call API
extension DialogFilterRestaurantBranchViewController {
    func getRestaurantList() {
        viewModel.getRestaurantList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    viewModel.dataArray.accept(dataFromServer.list)
                    Utils.isHideAllView(isHide: dataFromServer.list.count > 0 ? true : false, view: no_data_view)
                    dLog(dataFromServer.list.toJSON())
                }else{
                    dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
                }
            }
        }).disposed(by: rxbag)
    }
    
    func getBrandList() {
        viewModel.getBrandList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    viewModel.dataArray.accept(dataFromServer.list)
                    Utils.isHideAllView(isHide: dataFromServer.list.count > 0 ? true : false, view: no_data_view)
                    dLog(dataFromServer.list.toJSON())
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
            
        }).disposed(by: rxbag)
    }
    
    func getBranchList(){
        viewModel.getBranchList().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    viewModel.dataArray.accept(dataFromServer.list)
                    viewModel.data_type.accept(2)
                    Utils.isHideAllView(isHide: dataFromServer.list.count > 0 ? true : false, view: no_data_view)
                    dLog(dataFromServer.list.toJSON())
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
            
        }).disposed(by: rxbag)
    }
}
