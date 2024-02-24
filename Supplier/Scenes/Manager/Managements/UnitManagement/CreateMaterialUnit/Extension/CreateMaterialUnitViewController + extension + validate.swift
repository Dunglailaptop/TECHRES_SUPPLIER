//
//  CreateMaterialUnitViewController + extension + validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
extension CreateMaterialUnitViewController {
    
    
    
    var isUnitNameValid:Observable<Bool>{
        return viewModel.newMaterialUnit.map{$0.name}.distinctUntilChanged().asObservable().map(){[self](name) in
            if name.isEmpty{
                lbl_unit_name_error.text = "Không được bỏ trống trường Tên Đơn vị"
                lbl_unit_name_error.isHidden = false
                return false
            }else if name.count < 2{
                lbl_unit_name_error.text = "Độ dài tối thiểu 2 ký tự"
                lbl_unit_name_error.isHidden = false
                return false
            }else if name.count > 50 {
                lbl_unit_name_error.text = "Độ dài tối đa 50 ký tự"
                lbl_unit_name_error.isHidden = false
                return false
            } else{
                lbl_unit_name_error.text = ""
                lbl_unit_name_error.isHidden = true
                return true
            }
        }
    }
    
    var isUnitCodeValid:Observable<Bool>{
        return viewModel.newMaterialUnit.map{$0.code}.distinctUntilChanged().asObservable().map(){[self](code) in
            
            if code.isEmpty{
                lbl_unit_code_error.text = "Không được bỏ trống trường Mã Đơn vị"
                lbl_unit_code_error.isHidden = false
                return false
            }else if code.count < 2{
                lbl_unit_code_error.text = "Độ dài tối thiểu 2 ký tự"
                lbl_unit_code_error.isHidden = false
                return false
            }else if code.count > 50 {
                lbl_unit_code_error.text = "Độ dài tối đa 50 ký tự"
                lbl_unit_code_error.isHidden = false
                return false
            }else{
                lbl_unit_code_error.text = ""
                lbl_unit_code_error.isHidden = true
                return true
            }
        }
    }
    
    
    
    var isUnitSpecsQuantityValid:Observable<Bool>{
        
        return viewModel.unitSpecsList.map{$0.filter{$0.isSelected == ACTIVE}}.asObservable().map(){[self] (list) in
            dLog(list.count)
            if list.count < 1{
                lbl_tag_view_err.text = "Không được để trống Quy cách"
                lbl_tag_view_err.isHidden = false
                return false
            }

            lbl_tag_view_err.text = ""
            lbl_tag_view_err.isHidden = true
            return true
        }
    }
    
    
    var isDescriptionValid:Observable<Bool>{
        return viewModel.newMaterialUnit.map{$0.description}.asObservable().map(){[self] (des) in
            if des.count > 1000{
                lbl_description_err.text = "Độ dài tối đa 1000 ký tự"
                lbl_description_err.isHidden = false
                return false
            }
            
            lbl_description_err.text = ""
            lbl_description_err.isHidden = true
            return true
        }
    }
}
