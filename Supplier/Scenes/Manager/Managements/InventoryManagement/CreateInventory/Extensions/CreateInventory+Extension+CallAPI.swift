//
//  CreateInventory+Extension+CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert

extension CreateInventoryViewController {
    func createSupplierWarehouseSessions(){
        viewModel.createSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Tạo phiếu nhập kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                lbl_total_amount.text = "0"
                lbl_total_quantity.text = "0"
                NotificationCenter.default
                            .post(name:NSNotification.Name("backCreateInventory"),
                             object: nil,
                             userInfo: nil)
                viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Tạo phiếu không thành công", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                viewModel.material_datas.accept([])
                dLog(response.message ?? "")
            } else{
                viewModel.material_datas.accept([])
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func createCancelSupplierWarehouseSessions(){
        viewModel.createCancelSupplierWarehouseSessions().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Tạo phiếu huỷ kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                lbl_total_amount.text = "0"
                lbl_total_quantity.text = "0"
                NotificationCenter.default
                            .post(name:NSNotification.Name("backCreateInventory"),
                             object: nil,
                             userInfo: nil)
                viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Tạo phiếu không thành công", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                viewModel.material_datas.accept([])
                dLog(response.message ?? "")
            } else{
                viewModel.material_datas.accept([])
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
