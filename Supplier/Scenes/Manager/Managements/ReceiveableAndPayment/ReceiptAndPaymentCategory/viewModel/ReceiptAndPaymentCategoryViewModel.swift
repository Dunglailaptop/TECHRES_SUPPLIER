//
//  ReceiptAndPaymentCategoryViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class ReceiptAndPaymentCategoryViewModel: BaseViewModel {
    private(set) weak var view: ReceiptAndPaymentCatetoryViewController?
    private var router: ReceiptAndPaymentCategoryRouter?
    var adequateDataArray = BehaviorRelay<[ReceiptPaymentCategory]>(value: [])
    var dataArray = BehaviorRelay<[ReceiptPaymentCategory]>(value: [])
    //is_hidden = 0 -> ACTIVE,  is_hidden = 1 -> DEACTIVE
    var is_hidden = BehaviorRelay<Int>(value: 0)
    var closure = BehaviorRelay<() -> Void>(value: {})
    
    
    
    func bind(view: ReceiptAndPaymentCatetoryViewController, router: ReceiptAndPaymentCategoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
  
    func makePopViewController(){
        router?.navigateToPopViewController(callBackToPopViewController: view!.callBackToPopViewController)
    }
    
    func makeCreateReceiptAndPaymentCategoryViewController(receiptAndPaymentCategory:ReceiptPaymentCategory = ReceiptPaymentCategory()){
        router?.navigateToCreateReceiptAndPaymentCategoryViewController(receiptAndPaymentCategory:receiptAndPaymentCategory)
    }
    
    
    func makeReceiptAndPaymentViewController(screenType:Int = 0){
        router?.navigateToReceiptAndPaymentViewController(screenType: screenType)
    }

}
//MARK:Call API
extension ReceiptAndPaymentCategoryViewModel {
    
    func getReceiptAndPaymentCategory() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getReceiptAndPaymentCategory(supplier_addition_fee_reason_category_id: -1, supplier_addition_fee_type: -1, is_hidden: -1, key_search: "", is_system_auto_generate: -1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
        
    func changeReceiptAndPaymentCategoryStatus(id:Int) -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postChangeReceiptAndPaymentCategoryStatus(id: id))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}
