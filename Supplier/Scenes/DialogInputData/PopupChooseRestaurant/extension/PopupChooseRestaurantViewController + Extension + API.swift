//
//  PopupChooseRestaurantViewController + Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 09/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
extension PopupChooseRestaurantViewController {
    func getRestaurantList() {
        viewModel.getRestaurantList().subscribe(onNext: { [self] (response) in
            dLog(response.toJSON())
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    
                    var clonePagination = viewModel.pagination.value
                    clonePagination.totalRecord = dataFromServer.total_record
                    
                    if(dataFromServer.list.count > 0 && !clonePagination.isGetFullData ){
                        var cloneDataArray = viewModel.dataArray.value
                        cloneDataArray.append(contentsOf: dataFromServer.list)
                        cloneDataArray.enumerated().forEach{ (index,value) in
                            cloneDataArray[index].type = 1
                        }
                        viewModel.dataArray.accept(cloneDataArray)
                        clonePagination.isGetFullData = viewModel.dataArray.value.count == clonePagination.totalRecord ? true: false
                    }
                    no_data_view.isHidden = viewModel.dataArray.value.count > 0 ? true : false
                    viewModel.pagination.accept(clonePagination)
                    viewModel.view?.popupType = .restaurant
                    lbl_popup_title.text = "CHỌN NHÀ HÀNG"
                }
            }
        }).disposed(by: rxbag)
    }
    
    func getBrandList() {
        viewModel.getBrandList().subscribe(onNext: { [self] (response) in
            dLog(response.toJSON())
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    
                    var clonePagination = viewModel.pagination.value
                    clonePagination.totalRecord = dataFromServer.total_record
                    
                    if(dataFromServer.list.count > 0 && !clonePagination.isGetFullData ){
                        var cloneDataArray = viewModel.dataArray.value
                        cloneDataArray.append(contentsOf: dataFromServer.list)
                        viewModel.dataArray.accept(cloneDataArray)
                        clonePagination.isGetFullData = viewModel.dataArray.value.count == clonePagination.totalRecord ? true: false
                    }
                    no_data_view.isHidden = viewModel.dataArray.value.count > 0 ? true : false
                    viewModel.view?.popupType = .brand
                    lbl_popup_title.text = "CHỌN THƯƠNG HIỆU"
                   
                }
            }
        }).disposed(by: rxbag)
    }
    
    
    func getBranchList(){
        viewModel.getBranchList().subscribe(onNext: { [self] (response) in
            dLog(response.toJSON())
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataFromServer = Mapper<RestaurantModel>().map(JSONObject: response.data){
                    
                    var clonePagination = viewModel.pagination.value
                    clonePagination.totalRecord = dataFromServer.total_record
                    
                    if(dataFromServer.list.count > 0 && !clonePagination.isGetFullData ){
                        var cloneDataArray = viewModel.dataArray.value
                        cloneDataArray.append(contentsOf: dataFromServer.list)
                        viewModel.dataArray.accept(cloneDataArray)
                        clonePagination.isGetFullData = viewModel.dataArray.value.count == clonePagination.totalRecord ? true: false
                    }
                    no_data_view.isHidden = viewModel.dataArray.value.count > 0 ? true : false
                    viewModel.pagination.accept(clonePagination)

                    viewModel.view?.popupType = .branch
                    lbl_popup_title.text = "CHỌN CHI NHÁNH"
                }
            }
        }).disposed(by: rxbag)
    }
    
}
