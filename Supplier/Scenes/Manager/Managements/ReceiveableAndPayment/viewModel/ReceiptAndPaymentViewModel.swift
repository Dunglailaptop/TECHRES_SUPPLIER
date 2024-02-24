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

class ReceiptAndPaymentViewModel: BaseViewModel {
    private(set) weak var view: ReceiptAndPaymentViewController?
    private var router: ReceiptAndPaymentRouter?
    
    /*
        status = 1 -> đang chờ xử lý
        status = 2 -> đã hoàn thành
        status = 3 -> đã huỷ
     */
    public var status : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    /*
        type = 0 -> phiếu thu
        type = 1 -> phiếu chi
     */
    public var type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var from_date : BehaviorRelay<String> = BehaviorRelay(value: String(format: "01/%@", Utils.getCurrentMonthYearString()))
    public var to_date : BehaviorRelay<String> = BehaviorRelay(value: Utils.getCurrentDateString())
    public var dateType : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    public var key_search : BehaviorRelay<String> = BehaviorRelay(value: "")
    
    
    // dataArray danh sách chỉ hiển thị theo status yêu cầu
    public var dataArray:BehaviorRelay<[ReceiptPayment]> = BehaviorRelay(value: [])
    
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
        view?.getReceiptAndPaymentList()
    }
    
    
    
    func bind(view: ReceiptAndPaymentViewController, router: ReceiptAndPaymentRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    func makeDetailedReceiptAndPaymentViewController(receiptPayment:ReceiptPayment = ReceiptPayment.init()){
        router?.navigateToDetailedReceiptAndPaymentViewController(receiptPayment: receiptPayment)
    }
    
    func makeCreateReceiptAndPaymentViewController(){
        router?.navigateToCreateReceiptAndPaymentViewController(noteType: type.value)
    }
    
    func makeReceiptAndPaymentCatetoryViewController(){
        router?.navigateToReceiptAndPaymentCatetoryViewController()
    }
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//MAKR : CALL API
extension ReceiptAndPaymentViewModel{
    func getReceiptAndPaymentList() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getReceiptAndPaymentList(type: type.value, status: status.value, from_date: from_date.value, to_date: to_date.value, key_search: key_search.value,limit: pagination.value.limit, page: pagination.value.page))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    

}
