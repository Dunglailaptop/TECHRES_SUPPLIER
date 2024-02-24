//
//  ManagementInfoCustomerViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import RxRelay
 
class ManagementInfoCustomerViewModel:BaseViewModel {
    private(set) weak var view: ManagementInfoCustomerViewController?
    private var router: ManagementInfoCustomerRouter?
    
   
    public var restaurant_id:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var dataArray:BehaviorRelay<CustomerReport> = BehaviorRelay(value: CustomerReport())
    
    func bind(view: ManagementInfoCustomerViewController, router: ManagementInfoCustomerRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
}
extension ManagementInfoCustomerViewModel{
    func getDetailCustomerReport() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailRestaurantReport(restaurantId: restaurant_id.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
