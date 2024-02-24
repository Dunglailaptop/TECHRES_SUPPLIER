//
//  DetailPendingOrderViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailPendingOrderViewModel: BaseViewModel {
    
    private(set) weak var view: DetailPendingOrderViewController?
    private var router: DetailPendingOrderRouter?
    
    public var type_select_input_money : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var type_select_input_quantity : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0) // tổng thanh toán ban đầu
    public var vat_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0) // số tiền vat
    public var discount_amount_display : BehaviorRelay<Int> = BehaviorRelay(value: 0) // số tiền giảm giá để hiển thị

    // MARK: GET
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "3")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 1000)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    // MARK: POST
    // Confirm
    public var vat : BehaviorRelay<Float> = BehaviorRelay(value: 0)
    public var restaurant_material_order_request_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var supplier_order_request_id : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_percent : BehaviorRelay<Float> = BehaviorRelay(value: 0)
    public var expected_delivery_time : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var list_material : BehaviorRelay<[ListMaterialResquest]> = BehaviorRelay(value: [])
    // Change status
    public var status_order : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var reason : BehaviorRelay<String> = BehaviorRelay(value: "")

    
    public var dataArray : BehaviorRelay<[DetailSupplierOrderResponse]> = BehaviorRelay(value:[])
    public var dataArrayMaterial : BehaviorRelay<[DetailSupplierOrderResponse]> = BehaviorRelay(value:[])

    func bind(view: DetailPendingOrderViewController, router: DetailPendingOrderRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
    var isValidReason: Observable<Bool> {
        return self.reason.asObservable().map { reason in
            reason.count >= Constants.NOTE_FORM_REQUIRED.requiredNoteLengthMin &&
            reason.count <= Constants.NOTE_FORM_REQUIRED.requiredNoteLengthMax
        }
    }

   var isValid: Observable<Bool> {
       return isValidReason

   }
}

//MARK: Call API
extension DetailPendingOrderViewModel{
    
    // MARK: GET
    func getDetailSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierOrdersRequest(id: view?.dataDetail.id ?? 0, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    // MARK: POST
    func confirmSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postSupplierOrdersConfirm(vat: vat.value, restaurant_material_order_request_id: restaurant_material_order_request_id.value, supplier_order_request_id: supplier_order_request_id.value, expected_delivery_time: expected_delivery_time.value, discount_percent: discount_percent.value, discount_amount: discount_amount.value, list_material: list_material.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func changeStatusSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postSupplierOrdersRequestChangeStatus(id: view?.dataDetail.id ?? 0, status: status_order.value, reason: reason.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
