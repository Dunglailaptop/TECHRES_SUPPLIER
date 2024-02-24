//
//  DetailedItemsManagementViewController+Extension + CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
//MARK: CALL API
extension DetailedItemsManagementViewController{
    func createItem(){
        viewModel.createItem().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Thêm mới Mặt hàng thành công")
                viewModel.makePopViewController()
            }else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Thêm mới Mặt hàng không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                dLog(response.message ?? "")
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    

    func updateItem(){
        viewModel.updateItem().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Chỉnh sửa mặt hàng thành công")
                viewModel.makePopViewController()
            }else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Chỉnh sửa mặt hàng không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            }else{
                JonAlert.show(message: response.message ?? "Chỉnh sửa mặt hàng không thành công", andIcon: UIImage(named: "icon-warning"),duration: 2.0)
            }
         
        }).disposed(by: rxbag)
    }
    
    
    func getAllCategoryItems() {
        viewModel.getAllCategoryItems().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var categoryList = Mapper<MaterialCategory>().mapArray(JSONObject: response.data) {

                    if categoryList.count > 0{
                        
                        
                        if viewModel.item.value.id > 0{
                            if let position = categoryList.firstIndex(where: {$0.id == viewModel.item.value.material_category_id}){
                               
                                categoryList[position].isSelect = ACTIVE
                            }
                        }
                        
                        
                        viewModel.categories.accept(categoryList)
                        viewModel.fullCategories.accept(categoryList)
                        hideAllError()
                        height_of_view_of_table1.constant = CGFloat(viewModel.categories.value.count*45)
                        
                    }

                }
            }else{
                dLog(response.message ?? "")
            }

        }).disposed(by: rxbag)
    }

    func getAllMaterialMeasureUnits(){
        viewModel.getAllMaterialMeasureUnits().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var measureUnitList = Mapper<MaterialMeasureUnit>().mapArray(JSONObject: response.data) {
                    measureUnitList = measureUnitList.filter{$0.status == ACTIVE}


                    if measureUnitList.count > 0{
                        
                        if viewModel.item.value.id > 0{
                            if let position = measureUnitList.firstIndex(where: {$0.id == viewModel.item.value.material_unit_id}){
                                measureUnitList[position].isSelect = ACTIVE
                                
                                var unitSpecs = measureUnitList[position].material_unit_specifications
                                if let pos = unitSpecs.firstIndex(where: {$0.id == viewModel.item.value.material_unit_specification_id}){
                                    unitSpecs[pos].isSelect = ACTIVE
                                    viewModel.measureUnitSpecifications.accept(unitSpecs)
                                }
                                

                            }
                        }
                       
                        viewModel.fullMeasureUnits.accept(measureUnitList)
                        viewModel.measureUnits.accept(measureUnitList)
                        height_of_tableView2.constant = CGFloat(viewModel.measureUnits.value.count*45)
                        hideAllError()
                    }

                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }

}

