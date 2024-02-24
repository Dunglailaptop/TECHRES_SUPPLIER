//
//  CreatePaymentRequestViewController + extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
//MARK: Call API
extension CreatePaymentRequestViewController{
    
    private func checkTagList(){
        tag_list.removeAllTags()
        
        for data in viewModel.fullReceivableList.value{
            if data.isSelected == ACTIVE{
                tag_list.addTag(data.code)
            }
        }
        view_of_tag_list.isHidden = viewModel.fullReceivableList.value.filter{$0.isSelected == ACTIVE}.count > 0 ? false : true
        
        if let debtReceivables = debtReceivables{
            if debtReceivables.count > 0{
                height_of_unit_specs_view.constant = tag_list.intrinsicContentSize.height
            }
        }
    }
    
    func getSupplierOrder(){
        viewModel.getSupplierOrders().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var dataFromServer = Mapper<SupplierDebtReceivableResponse>().map(JSONObject: response.data) {
                    
                    for data in viewModel.fullReceivableList.value.filter{$0.isSelected == ACTIVE}{
                        if let pos = dataFromServer.data.firstIndex(where: {$0.id == data.id}){
                            dataFromServer.data[pos].isSelected = ACTIVE
                        }
                    }
                    
                    if let debtReceivables = debtReceivables{
                        if debtReceivables.count > 0{
                            for data in debtReceivables{
                                if let pos = dataFromServer.data.firstIndex(where: {$0.id == data.id}){
                                    dataFromServer.data[pos].isSelected = ACTIVE
                                }
                            }
                        }
                    }
       
                    
                    
                            
                    lbl_no_data.isHidden = dataFromServer.data.count <= 0 ? false : true
                    viewModel.receivableList.accept(dataFromServer.data)
                    viewModel.fullReceivableList.accept(dataFromServer.data)
                    checkTagList()
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    
    func createSupplierDebtPayment(){
        viewModel.createSupplierDebtPayment().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Đã tạo phiếu yêu cầu thành công",duration: 2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
}
 
