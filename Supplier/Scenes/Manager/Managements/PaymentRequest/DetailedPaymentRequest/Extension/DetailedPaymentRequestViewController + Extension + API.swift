//
//  DetailedPaymentRequestViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 23/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import ObjectMapper
import JonAlert

extension DetailedPaymentRequestViewController {

    func getSupplierOrdersByIds(){
        viewModel.getSupplierOrdersByIds().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierOrders>().mapArray(JSONObject: response.data) {
                    dLog(dataFromServer)
                    viewModel.detailedOrders.accept(dataFromServer)
            
                    
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    func getSupplierDebtPaymentUpdate() {
        viewModel.getSupplierDebtPaymentUpdate().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                viewModel.makePopViewController()
                Toast.show(message: "Huỷ thành công", controller: self)
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}
//MARK: REGISTER CELL TABLE VIEW
extension DetailedPaymentRequestViewController{
    func registerCell() {
        let detailedPaymentRequestTableViewCell = UINib(nibName: "DetailedPaymentRequestTableViewCell", bundle: .main)
        tableView.register(detailedPaymentRequestTableViewCell, forCellReuseIdentifier: "DetailedPaymentRequestTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = 50
    }
    
    func bindTableViewData() {
        viewModel.detailedOrders.bind(to: tableView.rx.items(cellIdentifier: "DetailedPaymentRequestTableViewCell", cellType: DetailedPaymentRequestTableViewCell.self))
            {(row, order, cell) in
                cell.data = order
            }.disposed(by: rxbag)
    }
    
}
