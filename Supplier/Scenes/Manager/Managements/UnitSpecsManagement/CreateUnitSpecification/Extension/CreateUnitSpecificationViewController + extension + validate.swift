//
//  CreateUnitSpecificationViewController + extension + validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 16/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension CreateUnitSpecificationViewController{
    var isUnitSpecsName:Observable<Bool>{
        return viewModel.unitSpecification.map{$0.name}.distinctUntilChanged().asObservable().map(){[weak self](name) in
            
            if name.isEmpty {
                self!.lbl_unit_specs_name_error.text =  "Không được bỏ trống trường Tên Quy cách"
                self!.lbl_unit_specs_name_error.isHidden = false
                return false
            }else if name.count < 2 {
                self!.lbl_unit_specs_name_error.text =  "Độ dài tối thiểu 2 ký tự"
                self!.lbl_unit_specs_name_error.isHidden = false
                return false
            }else if name.count > 50{
                self!.lbl_unit_specs_name_error.text =  "Độ dài tối đa 50 ký tự"
                self!.lbl_unit_specs_name_error.isHidden = false
                return false
            }
            
            self!.lbl_unit_specs_name_error.text =  ""
            self!.lbl_unit_specs_name_error.isHidden = true
            return true
        }
    }
    
    var isExchangeValueValid:Observable<Bool>{
        return viewModel.unitSpecification.map{$0.exchange_value}.distinctUntilChanged().asObservable().map(){[weak self](exchange_value) in
            if(exchange_value < 1){
                self!.lbl_exchange_value_error.text =  "Gía tối thiểu 1"
                self!.lbl_exchange_value_error.isHidden = false
                return false
            }
            self!.lbl_exchange_value_error.text =  ""
            self!.lbl_exchange_value_error.isHidden = true
            return true
        }
    }
    
    var isExchangeUnitValid:Observable<Bool>{
        return viewModel.unitSpecification.map{$0.material_unit_specification_exchange_name_id}.distinctUntilChanged().asObservable().map(){[weak self](material_unit_specification_exchange_name_id) in
            if(material_unit_specification_exchange_name_id <= 0){
                self!.lbl_exchange_unit_error.text =  "Không được bỏ trống Đơn vị quy đổi"
                self!.lbl_exchange_unit_error.isHidden = false
                return false
            }
            self!.lbl_exchange_unit_error.text =  ""
            self!.lbl_exchange_unit_error.isHidden = true
            return true
        }
    }
    
    
}
