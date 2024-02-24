//
//  ListPendingOrderViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ListPendingOrderViewModel: BaseViewModel {
    
    private(set) weak var view: ListPendingOrderViewController?
    private var router: ListPendingOrderRouter?
    
    public var restaurant_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var restaurant_brand_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var branch_id : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    
    public var dataRestaurant : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBrand : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    public var dataBranch : BehaviorRelay<Restaurant> = BehaviorRelay(value: Restaurant.init())
    
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var status : BehaviorRelay<String> = BehaviorRelay(value: "1,5")
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: 20)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)

    public var data : BehaviorRelay<SupplierOrdersRequestResponse> = BehaviorRelay(value: SupplierOrdersRequestResponse.init()!)
    public var dataArray : BehaviorRelay<[SupplierOrdersRequest]> = BehaviorRelay(value: [])
    
    public var totalRecord : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var isGetFullData:BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    func bind(view: ListPendingOrderViewController, router: ListPendingOrderRouter){
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
  
    func makeDetailPendingOrderViewController(dataDetail: SupplierOrdersRequest){
        router?.navigateToDetailPendingOrderViewController(dataDetail: dataDetail)
    }
}

//MARK: CALL API
extension ListPendingOrderViewModel{
    func getSupplierOrdersRequest() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierOrdersRequest(restaurant_id: view?.restaurant_id ?? 0, restaurant_brand_id: restaurant_brand_id.value, branch_id: branch_id.value, from_date: from_date.value, to_date: to_date.value, status: status.value, key_search: key_search.value, limit: limit.value, page: page.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
