//
//  DetailPendingOrderViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 24/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert

extension DetailPendingOrderViewController {
    func getDetailSupplierOrdersRequest(){
        viewModel.getDetailSupplierOrdersRequest().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<DetailSupplierOrderResponse>().mapArray(JSONObject: response.data) {

                    viewModel.dataArray.accept(dataFromServer)
                    if dataFromServer.count > 0 {
                        lbl_code.text = String(dataFromServer[0].supplier_order_request_id)
                        lbl_create_at.text = dataFromServer[0].created_at
                        lbl_restaurant_brand_name.text = dataFromServer[0].restaurant_brand_name
                        lbl_branch_name.text = dataFromServer[0].branch_name
                        lbl_restaurant_name.text = dataFromServer[0].restaurant_name
                    }
                    var totalAmount:Double = 0
                    var heightTableView: CGFloat = 0
                    dataFromServer.enumerated().forEach { (index, value) in
                        totalAmount += Double(value.retail_price) * value.supplier_quantity
                        heightTableView += Utils.getHeightTextContentInView(textString: value.supplier_material_name, maxWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - CGFloat(242), theRest: 32, fontSize: 14, fontName: "Roboto-Regular")
                    }
                    height_table_view.constant = heightTableView
                    viewModel.total_amount.accept(Int(totalAmount))
                    lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
                    lbl_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataFromServer.count)
                    
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func confirmSupplierOrdersRequest(){
        viewModel.confirmSupplierOrdersRequest().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Bạn đã xác nhận đơn hàng thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                self.viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Xác nhận không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            } else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func changeStatusSupplierOrdersRequest(){
        viewModel.changeStatusSupplierOrdersRequest().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Bạn đã từ chối đơn hàng thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                self.viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Từ chối không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            } else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
