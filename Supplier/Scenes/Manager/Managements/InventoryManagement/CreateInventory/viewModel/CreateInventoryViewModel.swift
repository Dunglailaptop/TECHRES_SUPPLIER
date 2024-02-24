//
//  CreateInventoryViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class CreateInventoryViewModel: BaseViewModel {
    
    private(set) weak var view: CreateInventoryViewController?
    private var router: CreateInventoryRouter?
        
    // MARK: POST
    public var type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var note : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var discount_percent : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var vat_percent : BehaviorRelay<Float> = BehaviorRelay(value: 0)
    public var vat_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_amount : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var total_price : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var discount_amount_display : BehaviorRelay<Int> = BehaviorRelay(value: 0) // số tiền giảm giá để hiển thị

    public var type_button_discount : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt chọn giảm giá số tiền hay %
    public var type_select_input_quantity : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt chọn nhập % vat hay nhập số lượng nguyên liệu
    public var type_select_input_money : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var type_dialog : BehaviorRelay<Int> = BehaviorRelay(value: 0) // phân biệt loại dialog - 0: dialog XN xoá, 1: dialog XN tạo phiếu, 2: nút back
    
    public var material_datas : BehaviorRelay<[SupplierMaterialOrderRequest]> = BehaviorRelay(value: [])
    public var dataArray : BehaviorRelay<[Material]> = BehaviorRelay(value: [])
    
    func bind(view: CreateInventoryViewController, router: CreateInventoryRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

// MARK: Call API
extension CreateInventoryViewModel{
    func createSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postSupplierWarehouseSessionsCreate(type: type.value, discount_percent: discount_percent.value, discount_amount: discount_amount.value, vat_percent: Int(vat_percent.value), note: note.value, material_datas: material_datas.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func createCancelSupplierWarehouseSessions() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postSupplierWarehouseSessionsCreateCancel(type: type.value, note: note.value, material_datas: material_datas.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
