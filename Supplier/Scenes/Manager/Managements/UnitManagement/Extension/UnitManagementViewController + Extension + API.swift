//
//  UnitManagementViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
extension UnitManagementViewController{
    func getMaterialUnitList(){
        viewModel.getMaterialUnitList().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialUnit>().mapArray(JSONObject: response.data) {
                    viewModel.dataArray.accept(dataFromServer)
                    viewModel.dataFilter.accept(dataFromServer)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true : false, view: self.no_data_view)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
            
        }).disposed(by: rxbag)
    }
    
    
    func changeMaterialUnitStatus(unitId:Int){
        viewModel.unitId.accept(unitId)
        viewModel.changeMaterialUnitStatus().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){

                if let position = viewModel.dataArray.value.firstIndex(where: {(element) in element.id == unitId}){
                    var cloneDataArray = viewModel.dataArray.value
                    cloneDataArray.remove(at: position)
                    viewModel.dataArray.accept(cloneDataArray)
                    tableView.reloadData()
                    tableView.scrollToRow(at: IndexPath.init(row: position - 1 > 0 ? position - 1 : 0, section: 0), at: .top, animated: true)
                }
                
                if let position = viewModel.dataFilter.value.firstIndex(where: {(element) in element.id == unitId}){
                    var cloneDataArray = viewModel.dataFilter.value
                    cloneDataArray.remove(at: position)
                    viewModel.dataArray.accept(cloneDataArray)
                }
                
                
                JonAlert.showSuccess(message: viewModel.status.value == DEACTIVE
                                     ? "Khôi phục trạng thái thành công"
                                     : "Chuyển trạng thái tạm ngưng thành công",
                duration:2.0)
                
            }else if(response.code == RRHTTPStatusCode.resetContent.rawValue){
                if let dataFromServer = Mapper<MaterialUnitStatus>().mapArray(JSONObject: response.data) {
                    self.prensentDialogNotify(content: response.message ??  "",materialUnitStatus: dataFromServer)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }

}

