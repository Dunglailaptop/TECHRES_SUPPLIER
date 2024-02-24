//
//  ReportDayOffViewModel.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class ItemsManagementViewModel: BaseViewModel {
    private(set) weak var view: ItemsManagementViewController?
    private var router: ItemsManagementRouter?
    //status = 0 -> các mặt hàng ngừng cung cấp, status = 1 -> các mặt hàng đang cung cấp
    var status : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    var dataArray : BehaviorRelay<[Material]> = BehaviorRelay(value: [])
    var closure:BehaviorRelay<() -> Void> = BehaviorRelay(value: {})
   

    var pagination = BehaviorRelay<(limit: Int,
                                page:Int,
                                total_record:Int,
                                isGetFullData:Bool,
                                isAPICalling:Bool
    )>(value: (limit:10, page:1, total_record:0,isGetFullData:false,isAPICalling:false))

  
    
    func clearDataAndCallAPI(){
        dataArray.accept([])
        var clonePagination = pagination.value
        clonePagination.page = 1
        clonePagination.isGetFullData = false
        clonePagination.isAPICalling = true
        pagination.accept(clonePagination)
        view?.getItemList()
    }
    
    
    func bind(view: ItemsManagementViewController, router: ItemsManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    /*nếu người dùng vào sử dụng chức năng tạo thì chuyền Material() (rỗng) vào nếu người dùng update.....
        có 3 usecase
            -> case 1: xem chi tiết
            -> case 2: chỉnh sửa (update)
            -> case 3: tạo
     */
    func makeDetailedItemsManagemenTViewController(item:Material = Material(), isAllowEditting:Bool = false){
        router?.navigateToDetailedItemsManagemenTViewController(item:item,isAllowEditting:isAllowEditting)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//MAKR : CALL API
extension ItemsManagementViewModel{
    func getItemList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getMaterialList(status: status.value,key_search: key_search.value,limit: pagination.value.limit, page: pagination.value.page))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func changeMaterialStatus(itemId:Int) -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postChangMaterialStatus(id: itemId))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
}
