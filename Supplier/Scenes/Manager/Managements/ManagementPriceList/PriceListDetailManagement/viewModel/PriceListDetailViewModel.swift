//
//  PriceListDetailViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class PriceListDetailViewModel: BaseViewModel {
    
    private(set) weak var view: PriceListDetailViewController?
    private var router: PriceListDetailRouter?
    public var key_search: BehaviorRelay<String> = BehaviorRelay(value: "")
    public var dataArray : BehaviorRelay<[MaterialPriceList]> = BehaviorRelay(value: [])
    public var dataFilter : BehaviorRelay<[MaterialPriceList]> = BehaviorRelay(value: [])
    
    var DetailSupplier: BehaviorRelay<Supplier> = BehaviorRelay(value: Supplier())
    var price_money_choose = BehaviorRelay<Int>(value:0)
    var MaterialId = BehaviorRelay<Int>(value: 0)
    
    public var type_select_input_money : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: PriceListDetailViewController, router: PriceListDetailRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func clearData() {
        dataArray.accept([])
    }
    
    func CleardataAndCallAPI() {
        clearData()
        view?.getPriceListDetail()
    }
    
    func makePopViewController() {
        router?.navigationToPopViewController()
    }
    
}
extension PriceListDetailViewModel {
    func getDetailPriceList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierMaterials(Supplier_id: DetailSupplier.value.id,key_search: key_search.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func getUpdatePrice() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.UpdatePriceList(materialsId: String(MaterialId.value), price: price_money_choose.value ,restaurant_id: DetailSupplier.value.id))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
