//
//  DialogChooseCategoryViewController + extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
//MARK: call API
extension DialogChooseCategoryViewController{
    
    func getAllCategoryItems() {
        viewModel.getAllCategoryItems().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let categoryList = Mapper<MaterialCategory>().mapArray(JSONObject: response.data) {

                    
                    if categoryList.count > 0{
                        
                        let mapping:(MaterialCategory) -> GeneralObject = {(category) in GeneralObject.init(id:category.id,name:category.name)!}
                        
                        var objectArray = categoryList.map(mapping)
                        if let position = objectArray.firstIndex(where: {(element) in element.id == selectedOption.id}){
                            objectArray[position].isSelected = ACTIVE
                        }
                        
                        
                        viewModel.objectArray.accept(objectArray)
                        viewModel.fullObjectArray.accept(objectArray)
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
                    
                    
                    if measureUnitList.count > 0{
                        let mapping:(MaterialMeasureUnit) -> GeneralObject = {(unit) in GeneralObject.init(id:unit.id,name:unit.name)!}
                        var objectArray = measureUnitList.map(mapping)
                        if let position = objectArray.firstIndex(where: {(element) in element.id == selectedOption.id}){
                            objectArray[position].isSelected = ACTIVE
                        }
                        
                        viewModel.objectArray.accept(objectArray)
                        viewModel.fullObjectArray.accept(objectArray)
                    }
                  
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
}




