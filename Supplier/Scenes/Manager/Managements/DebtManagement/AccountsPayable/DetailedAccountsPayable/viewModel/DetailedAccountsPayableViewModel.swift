//
//  DetailedAccountsPayableViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DetailedAccountsPayableViewModel: BaseViewModel {
    private(set) weak var view: DetailedAccountsPayableViewController?
    private var router: DetailedAccountsPayableRouter?
    var dataArray = BehaviorRelay<[MaterialWarehouseSessions]>(value: [])
    var warehouseReceipt = BehaviorRelay<WarehouseReceipt>(value: WarehouseReceipt())

    
    func bind(view: DetailedAccountsPayableViewController, router: DetailedAccountsPayableRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigatePopViewController()
    }
    
    

}
extension DetailedAccountsPayableViewModel{
    func getSupplierWarehouseSessionsDetail() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierWarehouseSessionsDetail(id: warehouseReceipt.value.id,limit: 500,page: 1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func getDetailSupplierOrders() -> Observable<APIResponse> {
        /*
         status = 0 // Đơn hàng đang chuẩn bị
         status = 1 // Chờ nhà hàng xác nhận
         status = 2 // Chờ giao
         status = 3 // Đang giao
         status = 4 // Hoàn tất - Trạng thái cuối cùng
         status = 5 // Đã hủy - Trạng thái cuối cùng
         status = 6 // Trả hàng về NCC
         status = 7 // Xác nhận hàng bị trả - Trạng thái cuối cùng
         
         ins this case: chỉ lấy nhưng đơn hàng đã hoàn tất
         */

        return appServiceProvider.rx.request(.getDetailSupplierOrders(
            id: warehouseReceipt.value.supplier_order_id,
            status: String(Constants.SUPPLIER_ORDERS_STATUS.COMPLETED),
            limit: 500,
            page: 1))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
    func createPayment() -> Observable<APIResponse> {
        /*
            object_type = 0 -> khác
            object_type = 1 -> đơn hàng
            object_type = 2 -> phiếu nhập kho
            . khi tạo phiếu thu và phiếu chi (chi phí khác ) ta truyển object_type = 0
            . khi tạo phiếu chi (nhập kho) ta truyển object_type = 2
         */
        
        return appServiceProvider.rx.request(.postCreateReceiptAndPayment(
            note: warehouseReceipt.value.note,
            amount: warehouseReceipt.value.amount,
            warehouse_session_ids: [warehouseReceipt.value.id],
            object_type: 2,
            fee_month: Utils.getCurrentDateString(),
            supplier_addition_fee_reason_id:76330)) //do sai nghiệp vụ từ bản figma nên ta hard code supplier_addition_fee_reason_id = 76330, và chờ BA thay đổi nghiệp vụ
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
    }
    
}
