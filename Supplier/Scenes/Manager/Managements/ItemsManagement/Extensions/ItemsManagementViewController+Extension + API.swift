//
//  ItemsManagementViewController+Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert
//MARK: CALL API
extension ItemsManagementViewController{
    func getItemList(){
        viewModel.getItemList().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialResponse>().map(JSONObject: response.data) {
              
                    
                    var pagination = viewModel.pagination.value
                    pagination.total_record = dataFromServer.total_record
                    lbl_number_of_material.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.total_record)
                    if(dataFromServer.data.count > 0 && !pagination.isGetFullData){
                        var dataArray = viewModel.dataArray.value
                        dataArray.append(contentsOf: dataFromServer.data)
                        viewModel.dataArray.accept(dataArray)
                        pagination.isGetFullData = viewModel.dataArray.value.count == pagination.total_record ? true: false
                        
                    }
                    
                    pagination.isAPICalling = false
                    viewModel.pagination.accept(pagination)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true : false, view: self.view_empty_data)
                }
            }else{
                dLog(response.message)
               
            }
         
        }).disposed(by: rxbag)
    }
    
    
    func changeItemStatus(item:Material){
        
        viewModel.changeMaterialStatus(itemId:item.id).subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let position = viewModel.dataArray.value.firstIndex(where: {(element) in element.id == item.id}){
                    var cloneDataArray = viewModel.dataArray.value
                    cloneDataArray.remove(at: position)
                    viewModel.dataArray.accept(cloneDataArray)
                    tableView.reloadData()
                    tableView.scrollToRow(at:  IndexPath.init(row: position - 1 > 0 ? position - 1 : 0, section: 0), at: .top, animated: true)
                    //status = 0 -> ở màn hình các mặt hàng ngừng cung cấp , status = 1 -> ở màn hình các mặt hàng đang cung cấp
                    
                    JonAlert.showSuccess(message: viewModel.status.value == 0
                                         ? "Khôi phục thành công"
                                         : "Chuyển trạng thái tạm ngưng thành công",
                    duration:2.0)
                }
            }else if(response.code == RRHTTPStatusCode.resetContent.rawValue){
                if let dataFromServer = Mapper<MaterialStatus>().mapArray(JSONObject: response.data) {
                    self.prensentDialogNotify(content: response.message ??  "",materialStatus: dataFromServer)
                }
            }else{
                JonAlert.show(message: response.message ?? "Thay đổi trạng thái không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            }
        }).disposed(by: rxbag)
    }
}

