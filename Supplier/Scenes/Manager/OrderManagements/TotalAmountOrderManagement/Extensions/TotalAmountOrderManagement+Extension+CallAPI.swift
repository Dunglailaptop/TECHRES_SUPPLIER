//
//  TotalAmountOrderManagement+Extension+CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert

extension TotalAmountOrderManagementViewController {
    
    func getItemList(){
        viewModel.getItemList().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialResponse>().map(JSONObject: response.data) {
                    
                    var dataArray = dataFromServer.data
                    if(dataArray.count > 0){
                        dataArray.enumerated().forEach({( index, material ) in
                            material_selected.enumerated().forEach({( _, selectedMaterial ) in
                                if (material.id == selectedMaterial.id) {
                                    dataArray[index].isSelected = material_selected[index].isSelected == ACTIVE ? ACTIVE : DEACTIVE
                                }
                            })
                        })
                        viewModel.dataFilter.accept(dataArray)
                        viewModel.dataArray.accept(dataArray)
                        viewModel.selectedDataArray.accept(dataArray.filter({ $0.isSelected == ACTIVE}))
                        material_selected = dataArray.filter({ $0.isSelected == ACTIVE})
                        Utils.isHideAllView(isHide: true, view: root_view_empty_data)
                    }else{
                        viewModel.dataFilter.accept([])
                        viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: root_view_empty_data)
                    }
//                    dLog(dataFromServer.data)
                    lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.data.count)
                    Utils.isHideAllView(isHide: dataFromServer.data.count > 0 ? true : false, view: root_view_empty_data)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
