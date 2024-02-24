//
//  DetailedReceiptAndPaymentViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DetailedReceiptAndPaymentViewModel: BaseViewModel {
    private(set) weak var view: DetailedReceiptAndPaymentViewController?
    private var router: DetailedReceiptAndPaymentRouter?
    var receiptPaymentDetail = BehaviorRelay<ReceiptPayment>(value: ReceiptPayment())
    var orderList = BehaviorRelay<[SupplierOrders]>(value: [])
    

    var pagination = BehaviorRelay<(limit: Int, page:Int, total_record:Int)>(value: (limit:10, page:1, total_record:0))
    
    
    
    
    func bind(view: DetailedReceiptAndPaymentViewController, router: DetailedReceiptAndPaymentRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }

    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}


//MAKR : CALL API
extension DetailedReceiptAndPaymentViewModel{
    func getReceiptAndPaymentDetail() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getReceiptAndPaymentDetail(id: receiptPaymentDetail.value.id ?? 0))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getReceiptList(id:Int) -> Observable<APIResponse> {
        /*
            statuus đơn hàng :
            PENDING(0), // Đơn hàng đang chuẩn bị
            WAITTING_RESTAURANT_CONFIRM(1), // Chờ nhà hàng xác nhận
            WAITTING_DELIVERY(2), // Chờ giao
            DELIVERING(3), // Đang giao
            COMPLETED(4), // Hoàn tất - Trạng thái cuối cùng
            CANCELED(5), // Đã hủy - Trạng thái cuối cùng
            RETURN_TO_SUPPLIER(6), // Trả hàng về NCC
            CONFIRM_RETURN(7); // Xác nhận hàng bị trả - Trạng thái cuối cùng
         */
        return appServiceProvider.rx.request(.getOrderDetail(id: id, status: 4, is_return_material: 0,page:pagination.value.page,limit: pagination.value.limit))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func changeReceiptAndPaymentStatus(status:Int,reason:String) -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.postChangReceiptAndPaymentStatus(id: receiptPaymentDetail.value.id, status: status, reason: reason))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    
    


}
