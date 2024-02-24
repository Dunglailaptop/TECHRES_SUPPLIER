//
//  CreateReceiptAndPaymentCategoryViewController + extension + validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 16/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension CreateReceiptAndPaymentCategoryViewController {
    
    var isCategoryNameValid:Observable<Bool>{
        return viewModel.receiptPaymentCategory.map{$0.name}.distinctUntilChanged().asObservable().map(){[self](name) in
            if name.isEmpty{
                lbl_category_name_err.text = "Không được bỏ trống trường tên hạng mục"
                lbl_category_name_err.isHidden = false
                return false
            }else if name.count < 2{
                lbl_category_name_err.text = "Độ dài tối thiểu 2 ký tự"
                lbl_category_name_err.isHidden = false
                return false
            }else if name.count > 50 {
                lbl_category_name_err.text = "Độ dài tối đa 50 ký tự"
                lbl_category_name_err.isHidden = false
                return false
            }else{
        
                lbl_category_name_err.text = ""
                lbl_category_name_err.isHidden = true
                return true
            }
        }
    }
    
    
    var isasdasdValid:Observable<Bool>{
        return viewModel.receiptPaymentCategory.map{$0.name}.distinctUntilChanged().asObservable().map(){[self](name) in
            return true
        }
    }
    
   
    
    
    
}
