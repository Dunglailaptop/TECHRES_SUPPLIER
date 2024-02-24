//
//  DetailedItemsManagementViewController + Extension + Validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 11/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension DetailedItemsManagementViewController {
    
    var isItemNameValid:Observable<Bool>{
        return viewModel.item.map{$0.name}.distinctUntilChanged().asObservable().map(){ [self](name) in
            if name.isEmpty{
                lbl_item_name_err.text = "Không được bỏ trống trường Tên mặt hàng"
                lbl_item_name_err.isHidden = false
                return false
            }else if(name.count < 2){
                lbl_item_name_err.text = "Độ dài tối thiểu 2 ký tự"
                lbl_item_name_err.isHidden = false
                return false
            }else if(name.count > 50){
                lbl_item_name_err.text = "Độ dài tối đa 50 ký tự"
                lbl_item_name_err.isHidden = false
                return false
            }else {
                lbl_item_name_err.text = ""
                lbl_item_name_err.isHidden = true
                return true
            }
        }
    }
    
    
    var isItemCodeValid:Observable<Bool>{
        return viewModel.item.map{$0.code}.distinctUntilChanged().asObservable().map(){ [self](code) in
            if code.isEmpty{
                lbl_item_code_err.text = "Không được bỏ trống trường Mã mặt hàng"
                lbl_item_code_err.isHidden = false
                return false
            }else if(code.count < 2){
                lbl_item_code_err.text = "Độ dài tối thiểu 2 ký tự"
                lbl_item_code_err.isHidden = false
                return false
            }else if(code.count > 50){
                lbl_item_code_err.text = "Độ dài tối đa 50 ký tự"
                lbl_item_code_err.isHidden = false
                return false
            }else {
                lbl_item_code_err.text = ""
                lbl_item_code_err.isHidden = true
                return true
            }
         
        }
    }
    
    
    var isPriceValid:Observable<Bool>{
        return viewModel.item.map{$0.price}.distinctUntilChanged().asObservable().map(){ [self](price) in
            if(price >= 100 && price <= 100000000){
                lbl_imported_price_err.text = ""
                lbl_imported_price_err.isHidden = true
                return true
            }else if(price > 0 && price < 100) {
                lbl_imported_price_err.text = "Giá trị tối thiểu là 0 hoặc 100"
                lbl_imported_price_err.isHidden = false
                return false
            }else {
                lbl_imported_price_err.text = ""
                lbl_imported_price_err.isHidden = true
                return true
            }

        }
    }
    
    
    var isRetailedPriceValid:Observable<Bool>{
        return viewModel.item.map{$0.retail_price}.distinctUntilChanged().asObservable().map(){ [self](retail_price) in
            if(retail_price >= 100 && item.retail_price <= 100000000){
                lbl_retailed_price_err.text = ""
                lbl_retailed_price_err.isHidden = true
                return true
            }else if(retail_price > 0 && retail_price < 100) {
                lbl_retailed_price_err.text = "Giá trị tối thiểu là 0 hoặc 100"
                lbl_retailed_price_err.isHidden = false
                return false
            }else{
                lbl_retailed_price_err.text = ""
                lbl_retailed_price_err.isHidden = true
                return true
            }
        }
    }
    
    
    var isOutOfStockAlertQuantityValid:Observable<Bool>{
        return viewModel.item.map{$0.out_stock_alert_quantity}.distinctUntilChanged().asObservable().map(){ [self](out_stock_alert_quantity) in
            if(out_stock_alert_quantity >= 0 && out_stock_alert_quantity <= 100000){
                lbl_out_of_stock_alert_quan_err.text = ""
                lbl_out_of_stock_alert_quan_err.isHidden = true
                return true
            }
            lbl_retailed_price_err.text = "Số lượng để báo sắp hết hàng là 100,000"
            lbl_out_of_stock_alert_quan_err.isHidden = false
            return false
        }
    }
    
    
    var isWastageRateValid:Observable<Bool>{
        return viewModel.item.map{$0.wastage_rate}.distinctUntilChanged().asObservable().map(){ [self](wastage_rate) in
            if(wastage_rate >= 0 && wastage_rate <= 100){
                lbl_wastage_ratio_err.text = ""
                lbl_wastage_ratio_err.isHidden = true
                return true
            }
            lbl_retailed_price_err.text = "Hao hụt cho phép  là 100"
            lbl_wastage_ratio_err.isHidden = false
            return false
        }
    }
    
    
    var isCategoryValid:Observable<Bool>{
        return viewModel.item.map{$0.material_category_id}.distinctUntilChanged().asObservable().map(){ [self](category_id) in
            if(category_id <= 0){
                lbl_category_err.text = "Không được bỏ trống Danh mục"
                lbl_category_err.isHidden = false
                return false
            }
            lbl_category_err.text = ""
            lbl_category_err.isHidden = true
            return true
        }
    }
    
    
    var isMaterialUnitValid:Observable<Bool>{
        return viewModel.item.map{$0.material_unit_id}.distinctUntilChanged().asObservable().map(){ [self](material_unit_id) in
            if(material_unit_id <= 0){
                lbl_unit_err.text = "Không được bỏ trống Đơn vị"
                lbl_unit_err.isHidden = false
                return false
            }
            lbl_unit_err.text = ""
            lbl_unit_err.isHidden = true
            return true
        }
    }
    
    
    
    var isUnitSpecsValid:Observable<Bool>{
        return viewModel.item.map{$0.material_unit_specification_id}.distinctUntilChanged().asObservable().map(){ [self](material_unit_specification_id) in
            if(material_unit_specification_id <= 0){
                lbl_measure_specs_err.text = "Không được bỏ trống Quy cách"
                lbl_measure_specs_err.isHidden = false
                return false
            }
            lbl_measure_specs_err.text = ""
            lbl_measure_specs_err.isHidden = true
            return true
        }
    }
    
    
}



