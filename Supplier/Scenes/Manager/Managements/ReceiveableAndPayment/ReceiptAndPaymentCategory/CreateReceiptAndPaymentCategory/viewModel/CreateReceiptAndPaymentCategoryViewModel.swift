//
//  CreateReceiptAndPaymentCategoryViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class CreateReceiptAndPaymentCategoryViewModel: BaseViewModel {
    private(set) weak var view: CreateReceiptAndPaymentCategoryViewController?
    private var router: CreateReceiptAndPaymentCategoryRouter?
   
    /*
        filterType = 0 -> loại phiếu
        filterType = 1 -> hạng mục
     */
    var filterType = BehaviorRelay<Int>(value: 0)
    /*
        type = 0 -> phiếu thu
        type = 1 -> phiếu chi
     */
    var noteTypeArray = BehaviorRelay<[(type:Int,description:String)]>(value:[(type:0,description:"Phiếu thu"),(type:1,description:"Phiếu chi")])
    var receiptPaymentCategory = BehaviorRelay<ReceiptPaymentCategory>(value: ReceiptPaymentCategory())
    var categoryTypeList = BehaviorRelay<[ReceiptPaymentCategoryType]>(value: [])
    
    func bind(view: CreateReceiptAndPaymentCategoryViewController, router: CreateReceiptAndPaymentCategoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
  
    func makePopViewController(){
        router?.navigateToPopViewController()
        
    }
    
}

extension CreateReceiptAndPaymentCategoryViewModel{
    
    func getReceiptAndPaymentCategory() -> Observable<APIResponse> {
        //is_hidden = 0 -> ACTIVE,  is_hidden = 1 -> DEACTIVE
        let active = 0
        return appServiceProvider.rx.request(.getReceiptAndPaymentCategoryType(
            supplier_addition_fee_type: receiptPaymentCategory.value.id > 0 ? receiptPaymentCategory.value.supplier_addition_fee_type : -1,
            is_hidden: active,
            is_system_auto_generate: -1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
        
    func createReceiptAndPaymentCategory() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postCreateReceiptAndPaymentCategory(name: receiptPaymentCategory.value.name, supplier_addition_fee_reason_category_id: receiptPaymentCategory.value.supplier_addition_fee_reason_category_id, supplier_addition_fee_type: receiptPaymentCategory.value.supplier_addition_fee_type))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func updateReceiptAndPaymentCategory() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postUpdateReceiptAndPaymentCategory(id: receiptPaymentCategory.value.id, name: receiptPaymentCategory.value.name))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
