//
//  DetailCancelExportInventoryViewController+Extension.swift
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

extension DetailCancelExportInventoryViewController {
    func getDetailSupplierWarehouseSessions(){
        viewModel.getDetailSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierWarehouseSessions>().map(JSONObject: response.data) {

                    viewModel.data.accept(dataFromServer)
                    
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

                    viewModel.dataMaterial.accept(dataFromServer)
                    viewModel.dataArrayMaterial.accept(dataFromServer.data)
                    height_table_view.constant = CGFloat(dataFromServer.data.count * 65)
                    dLog(dataFromServer.toJSON())
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
