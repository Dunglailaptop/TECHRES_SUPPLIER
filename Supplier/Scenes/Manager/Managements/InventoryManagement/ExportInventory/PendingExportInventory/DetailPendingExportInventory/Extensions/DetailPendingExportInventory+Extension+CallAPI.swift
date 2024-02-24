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

extension DetailPendingExportInventoryViewController {
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
                    lbl_supplier_employee_name.text = dataFromServer.supplier_employee_name
                    
                    lbl_discount_percent.isHidden = dataFromServer.discount_percent == 0 ? true : false
                    lbl_vat_percent.isHidden = dataFromServer.vat == 0 ? true : false
                    
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
}
