//
//  ListCompleteOrderViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ListCompleteOrderViewModel: BaseViewModel {
    
    private(set) weak var view: ListCompleteOrderViewController?
    private var router: ListCompleteOrderRouter?
    
    public var restaurant_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var brand_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    
    public var dataRestaurant: BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBrand : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBranch : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var payment_status : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "4,6,7")
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var is_return_material : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var is_return_all_total_material : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierOrdersResponse> = BehaviorRelay(value: SupplierOrdersResponse.init()!)
    public var dataArray : BehaviorRelay<[SupplierOrders]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: ListCompleteOrderViewController, router: ListCompleteOrderRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func clearData(){
        dataArray.accept([])
        page.accept(1)
        isGetFullData.accept(false)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
    func clearDataAndCallAPI(){
        clearData()
        view!.getSupplierOrdersRequestList()
    }
  
    func makeDetailCompleteOrderViewController(dataDetail: SupplierOrders){
        router?.navigateToDetailCompleteOrderViewController(dataDetail: dataDetail)
    }
}

//MARK: CALL API
extension ListCompleteOrderViewModel{
    func getSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierOrders(restaurant_id: view?.restaurant_id ?? 0, brand_id: brand_id.value, branch_id: branch_id.value, payment_status: payment_status.value, status: status.value, key_search: key_search.value, from_date: from_date.value, to_date: to_date.value, is_return_material: is_return_material.value, is_return_all_total_material: is_return_all_total_material.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
