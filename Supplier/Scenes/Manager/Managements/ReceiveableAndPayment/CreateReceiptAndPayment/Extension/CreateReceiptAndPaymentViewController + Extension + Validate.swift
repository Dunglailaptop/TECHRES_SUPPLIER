//
//  CreateReceiptAndPaymentViewController + Extension + Validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 19/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension CreateReceiptAndPaymentViewController {
    var isUnitNameValid:Observable<Bool>{
        return viewModel.APIParameter.map{$0.amount}.distinctUntilChanged().asObservable().map(){[self](amount) in
            return true
        }
    }
    
    var isUnitCodeValid:Observable<Bool>{
        return viewModel.APIParameter.map{$0.supplier_addition_fee_reason_id}.distinctUntilChanged().asObservable().map(){[self](supplier_addition_fee_reason_id) in
            
          return true
        }
    }
        

    var isDescriptionValid:Observable<Bool>{
        return viewModel.APIParameter.map{$0.note}.asObservable().map(){[self] (des) in
            
            return true
        }
    }
}
