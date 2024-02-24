//
//  MaterialInventory+Extension+CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert

extension MaterialInventoryViewController {
    
    func getItemList(){
        viewModel.getItemList().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialResponse>().map(JSONObject: response.data) {
                    
                    var dataArray = dataFromServer.data
                    
                    if(dataArray.count > 0){
                        dataArray.enumerated().forEach({( index, material ) in
                            if dataSelectedMaterial.isEmpty == false { // khi chọn thêm NL bên cập nhật phiếu nhập kho
                                dataSelectedMaterial.enumerated().forEach({( _, selectedMaterial ) in
                                    if (material.id == selectedMaterial.supplier_material_id) {
                                        dataArray[index].isSelected = ACTIVE
                                    }
                                })
                            }else if dataSelected.isEmpty == false{ // khi chọn thêm NL bên tạo phiếu nhập kho
                                dataSelected.enumerated().forEach({( _, selected ) in
                                    if (material.id == selected.id) {
                                        dataArray[index].isSelected = ACTIVE
                                    }
                                })
                            }
                            material_selected.enumerated().forEach({( _, selectedMaterial ) in
                                if (material.id == selectedMaterial.id) {
                                    dataArray[index].isSelected = material_selected[index].isSelected == ACTIVE ? ACTIVE : DEACTIVE
                                }
                            })
                            
                        })
                        self.viewModel.dataFilter.accept(dataArray)
                        self.viewModel.dataArray.accept(dataArray)
                        material_selected = dataArray.filter({ $0.isSelected == ACTIVE})
                        Utils.isHideAllView(isHide: true, view: self.root_view_empty_data)
                    }else{
                        self.viewModel.dataArray.accept([])
                        Utils.isHideAllView(isHide: false, view: self.root_view_empty_data)
                    }
                    lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataArray.count)
                    Utils.isHideAllView(isHide: dataArray.count > 0 ? true: false , view: root_view_empty_data)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
