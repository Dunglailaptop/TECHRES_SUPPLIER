//
//  DialogChooseCategoryViewController + extension + setupView.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension DialogChooseCategoryViewController {
    func firstSetup(){
        switch dialogType {
            case .category:
                setupForCategoryDialog()
            case .measureUnit:
                setupForMeasureUnitDialog()
            case .unitSpecification:
                setupForUnitSpecsDialog()
            case .restaurant:
                break
            
            case .brand:
                break
                
            case .branch:
                break
            
            case .order:
                setupForOrderDialog()
            
            default:
                return
        }
        
        no_data_view.isHidden = false
        viewModel.objectArray.subscribe(onNext: {[weak self](value) in
            self?.no_data_view.isHidden = value.count > 0 ? true : false
                
        }).disposed(by: rxbag)
        
        
    }
    
    private func setupForCategoryDialog(){
        getAllCategoryItems()
        height_of_btn_bar_view.constant = 0
        btn_bar_view.isHidden = true
        
    }
    
    private func setupForMeasureUnitDialog(){
        getAllMaterialMeasureUnits()
        height_of_btn_bar_view.constant = 0
        btn_bar_view.isHidden = true
    }
    
    private func setupForUnitSpecsDialog(){
        dLog(inputList)
        viewModel.fullObjectArray.accept(inputList)
        viewModel.objectArray.accept(inputList)
        height_of_btn_bar_view.constant = 0
        btn_bar_view.isHidden = true
        
    }
    
    
    private func setupForRestaurantDialog(){

    }
    
    private func setupForBrandDialog(){

    }
    
    private func setupForBranchDialog(){
  
    }
    
    private func setupForOrderDialog(){
        viewModel.fullObjectArray.accept(inputList)
        viewModel.objectArray.accept(inputList)
        height_of_btn_bar_view.constant = 60
        btn_bar_view.isHidden = false
    }
    
    
    
    
}
