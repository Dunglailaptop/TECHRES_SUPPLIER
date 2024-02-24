//
//  DetailPendingInventoryViewController+Extension.swift
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

extension DetailPendingInventoryViewController {
    func getDetailSupplierWarehouseSessions(){
        viewModel.getDetailSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierWarehouseSessions>().map(JSONObject: response.data) {

                    viewModel.data.accept(dataFromServer)
                    viewModel.total_amount.accept(dataFromServer.total_amount)
                    viewModel.discount_amount.accept(dataFromServer.discount_amount)
                    viewModel.discount_amount_display.accept(dataFromServer.discount_amount)
                    viewModel.discount_percent.accept(dataFromServer.discount_percent)
                    viewModel.vat_amount.accept(dataFromServer.vat_amount)
                    viewModel.vat_percent.accept(dataFromServer.vat)
                    viewModel.note.accept(dataFromServer.note)
                    
                    lbl_discount_percent.isHidden = dataFromServer.discount_percent == 0 ? true : false
                    icon_edit_discount.isHidden = dataFromServer.discount_amount == 0 ? true : false
                    lbl_vat_percent.isHidden = dataFromServer.vat == 0 ? true : false
                    icon_edit_vat.isHidden = dataFromServer.vat == 0 ? true : false
                    icon_check.image = UIImage(named: dataFromServer.discount_amount == 0 ? "icon-uncheck-blue" : "icon-check-blue")
                    icon_check02.image = UIImage(named: dataFromServer.vat_amount == 0 ? "icon-uncheck-blue" : "icon-check-blue")
                    constraint_icon_edit_discount.constant = dataFromServer.discount_percent == 0 ? 0 : 16
                    constraint_discount_percent.constant = dataFromServer.discount_percent == 0 ? 0 : 8
                    
                    lbl_supplier_employee_name.text = dataFromServer.supplier_employee_name
                    lbl_code.text = dataFromServer.code
                    lbl_create_at.text = dataFromServer.created_at
                    lbl_note.text = dataFromServer.note
                    lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.total_amount)
                    lbl_total_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.amount)
                    lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: Int(dataFromServer.total_material))
                    lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.vat_amount)
                    lbl_vat_percent.text = String(dataFromServer.vat) + "%"
                    lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.discount_amount)
                    lbl_discount_percent.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.discount_percent) + "%"
                    
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func getSupplierWarehouseSessionsDetail(){
        viewModel.getSupplierWarehouseSessionsDetail().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialWarehouseSessionsResponse>().map(JSONObject: response.data) {

                    viewModel.dataArray.accept(dataFromServer.data)
                    viewModel.dataArrayMaterial.accept(dataFromServer.data)
                    var heightTableView: CGFloat = 0
                    dataFromServer.data.enumerated().forEach { (index, value) in
                        heightTableView += Utils.getHeightTextContentInView(textString: value.supplier_material_name, maxWidth: self.view.safeAreaLayoutGuide.layoutFrame.width - CGFloat(242), theRest: 32, fontSize: 14, fontName: "Roboto-Regular")
                    }
                    height_table_view.constant = heightTableView
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func updateSupplierOrdersRequest(){
        if viewModel.discount_percent.value != 0 {
            viewModel.discount_amount.accept(0)
        }
        viewModel.updateSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                
                if viewModel.type_dialog.value == 1 { // Mở dialog xác nhận và huỷ
                    changeStatusSupplierOrdersRequest()
                }else{
                    JonAlert.show(message: "Bạn đã cập nhật kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                    viewModel.makePopViewController()
                }
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Cập nhật kho không thành công", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                dLog(response.message ?? "")
            } else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func changeStatusSupplierOrdersRequest(){
        viewModel.changeStatusSupplierOrdersRequest().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                
                if viewModel.status_order.value == Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.COMPLETED{
                    JonAlert.show(message: "Bạn đã xác nhận nhập kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                }else if viewModel.status_order.value == Constants.SUPPLIER_WAREHOUSE_SESSIONS_TYPE.CANCELLED{
                    JonAlert.show(message: "Bạn đã huỷ nhập kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                }
                viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                dLog(response.message ?? "")
            } else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
