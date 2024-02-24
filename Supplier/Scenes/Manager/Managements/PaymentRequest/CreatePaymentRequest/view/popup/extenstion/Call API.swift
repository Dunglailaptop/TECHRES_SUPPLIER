//
//  Call API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import ObjectMapper

//MARK: Call API
extension CreatePaymentRequestPopupViewController:UIScrollViewDelegate{
    func getRestaurantList() {
        viewModel.getRestaurantList().subscribe(onNext: { [self] (response) in
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
                    viewModel.popupType.accept("RESTAURANT")
                }
            }
        }).disposed(by: rxbag)
    }
    
    func getBrandList() {
        viewModel.getBrandList().subscribe(onNext: { [self] (response) in
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
                    viewModel.popupType.accept("BRAND")
                   
                }
            }
        }).disposed(by: rxbag)
    }
    
    
    func getBranchList(){
        viewModel.getBranchList().subscribe(onNext: { [self] (response) in
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
                    viewModel.popupType.accept("BRANCH")
                }
            }
        }).disposed(by: rxbag)
    }
    
    
    
}
