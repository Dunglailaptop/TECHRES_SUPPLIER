//
//  CreateMaterialUnitViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit
import ObjectMapper
import JonAlert
import TagListView
//MARK:call API
extension CreateMaterialUnitViewController{
    
    
    func updateMaterialUnit(){
        viewModel.updateMaterialUnit().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "chỉnh sửa đơn vị thành công",duration:2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }

    
    

    func CreateMaterialUnit(){
        viewModel.CreateMaterialUnit().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "đã thêm đơn vị thành công",duration:2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }

    

    func getMaterialUnitSpecifications(){
        viewModel.getMaterialUnitSpecifications().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<UnitSpecification>().mapArray(JSONObject: response.data) {
                    //danh sách hiển thị ở filter view
                    
                    
                    var unitSpecsList:[UnitSpecification] = dataFromServer.map({(element) in
                        var cloneElement = element
                        cloneElement.isSelected = DEACTIVE
                        return cloneElement
                    })
                    
                    
                    
                    if materialUnit!.id > 0 {
                        /*
                            Nếu module này là dành cho việc chỉnh sửa thì
                            ta add thêm những tag dẵ có sẵn vào tag_list_view để hiển thị lên màn hình
                            loại trừ các tag có sẵn (selectedUnitSpecs) ra khỏi list hiển thị trong filter view
                            */
                    
                        for index in 0..<unitSpecsList.count{

                            for selectedUnitSpecs in materialUnit?.material_unit_specifications ?? []{
            
                                if unitSpecsList[index].id == selectedUnitSpecs.id{
                                    unitSpecsList[index].isSelected = ACTIVE
                                    tag_list_view.addTag(String(format: "%@ (%@ %@)",
                                                                selectedUnitSpecs.name,
                                                                Utils.stringQuantityFormatWithNumber(amount: selectedUnitSpecs.exchange_value),
                                                                selectedUnitSpecs.material_unit_specification_exchange_name
                                                               ),
                                                         id:selectedUnitSpecs.id)
                                    self.height_of_tag_view.constant = tag_list_view.intrinsicContentSize.height
                                    lbl_no_data.isHidden = true
                                }
                
                            }
                        }
                
                    }

                    dropDown.optionArray = unitSpecsList.filter{$0.isSelected == DEACTIVE}.map{String(format: "%@ (%@ %@)",
                                                                                                      $0.name,
                                                                                                      Utils.stringQuantityFormatWithNumber(amount: $0.exchange_value),
                                                                                                      $0.material_unit_specification_exchange_name)}
                    dropDown.optionIds = unitSpecsList.filter{$0.isSelected == DEACTIVE}.map{$0.id}
                    viewModel.unitSpecsList.accept(unitSpecsList)
                    
                    hideAllError()
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
            
        }).disposed(by: rxbag)
    }
        
}



extension CreateMaterialUnitViewController:TagListViewDelegate{
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        var cloneunitSpecsList = viewModel.unitSpecsList.value
        if let position = cloneunitSpecsList.firstIndex(where: {(element) in element.id == tagView.tag}){
            cloneunitSpecsList[position].isSelected = DEACTIVE
        }
        viewModel.unitSpecsList.accept(cloneunitSpecsList)
        tag_list_view.removeTag(title)
        dropDown.placeholder = sender.tagViews.count > 0 ? "" : "Vui lòng chọn"
       
        dropDown.optionArray = viewModel.unitSpecsList.value.filter{$0.isSelected == DEACTIVE}.map{String(format: "%@ (%@ %@)",
                                                                                          $0.name,
                                                                                          Utils.stringQuantityFormatWithNumber(amount: $0.exchange_value),
                                                                                          $0.material_unit_specification_exchange_name)}
        dropDown.optionIds = viewModel.unitSpecsList.value.filter{$0.isSelected == DEACTIVE}.map{$0.id}
        lbl_no_data.isHidden = viewModel.unitSpecsList.value.filter{$0.isSelected == ACTIVE}.count > 0 ? true : false
        self.height_of_tag_view.constant = 30
        self.view.layoutIfNeeded()
    }
}






