//
//  DetailPendingInventoryViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DetailPendingInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: DetailPendingInventoryViewController?
    private var router: DetailPendingInventoryRouter?
    
    // MARK: GET
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "3")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 1000)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    
    // MARK: POST
    // Change status
    public var status_order : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var supplier_warehouse_session_type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var reason : BehaviorRelay<String> = BehaviorRelay(value: "")

    // Update
    public var note : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var discount_percent : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var vat_percent : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var vat_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_price : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_amount_display : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    public var type_button_discount : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt chọn giảm giá số tiền hay %
    public var type_select_input_quantity : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt chọn nhập % vat hay nhập số lượng nguyên liệu
    public var type_select_input_money : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var type_dialog : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt dialog lưu lại hay xác nhận - 0: update, 1: change status
    public var materialIdSelected : BehaviorRelay<Int> = BehaviorRelay(value: 0) 
    
    public var data : BehaviorRelay<SupplierWarehouseSessions> = BehaviorRelay(value: SupplierWarehouseSessions.init())
    public var material_datas : BehaviorRelay<[SupplierMaterialOrderRequest]> = BehaviorRelay(value: [])
    public var dataArray : BehaviorRelay<[MaterialWarehouseSessions]> = BehaviorRelay(value:[])
    public var dataArrayMaterial : BehaviorRelay<[MaterialWarehouseSessions]> = BehaviorRelay(value:[])

    func bind(view: DetailPendingInventoryViewController, router: DetailPendingInventoryRouter){
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
extension DetailPendingInventoryViewModel{
    
    // MARK: GET
    func getDetailSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getDetailSupplierWarehouseSessions(id: view?.idDetail ?? 0))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    func getSupplierWarehouseSessionsDetail() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessionsDetail(id: view?.idDetail ?? 0, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
    
    // MARK: POST
    func changeStatusSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessionsChangeStatus(id: view?.idDetail ?? 0, status: status_order.value, reason: reason.value, supplier_warehouse_session_type: supplier_warehouse_session_type.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func updateSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postSupplierWarehouseSessionsUpdate(id: view?.idDetail ?? 0, discount_percent: discount_percent.value, discount_amount: discount_amount.value, vat_percent: vat_percent.value, note: note.value, material_datas: material_datas.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
