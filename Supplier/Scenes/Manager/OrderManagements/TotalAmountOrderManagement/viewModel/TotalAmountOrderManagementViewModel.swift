//
//  TotalAmountOrderManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class TotalAmountOrderManagementViewModel: BaseViewModel {
    
    private(set) weak var view: TotalAmountOrderManagementViewController?
    private var router: TotalAmountOrderManagementRouter?
    
    //status = 0 -> các mặt hàng ngừng cung cấp, status = 1 -> các mặt hàng đang cung cấp
    // MARK: GET
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 1000)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var materialIdSelected : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData : BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    public var dataArray : BehaviorRelay<[Material]> = BehaviorRelay(value: [])
    public var dataFilter : BehaviorRelay<[Material]> = BehaviorRelay(value: [])
    public var selectedDataArray : BehaviorRelay<[Material]> = BehaviorRelay(value: [])

    public var material_datas : BehaviorRelay<[SupplierMaterialOrderRequest]> = BehaviorRelay(value: [])
    
    func bind(view: TotalAmountOrderManagementViewController, router: TotalAmountOrderManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeCreateInventoryViewController(dataArrayMaterial: [Material]){
        router?.navigateToCreateInventoryViewController(dataArrayMaterial: dataArrayMaterial)
    }
}

// MARK: CALL API
extension TotalAmountOrderManagementViewModel{
    func getItemList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getMaterialList(status: status.value, key_search: key_search.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
