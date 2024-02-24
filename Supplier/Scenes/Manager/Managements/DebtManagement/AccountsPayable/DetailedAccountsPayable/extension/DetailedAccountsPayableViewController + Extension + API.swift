//
//  DetailedAccountsPayableViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import ObjectMapper
extension DetailedAccountsPayableViewController {
    func getDetailSupplierWarehouseSessions(){
        viewModel.getSupplierWarehouseSessionsDetail().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<MaterialWarehouseSessionsResponse>().map(JSONObject: response.data) {
                    viewModel.dataArray.accept(dataFromServer.data)
                    height_of_table_view.constant = CGFloat(dataFromServer.data.count * 50)
                    tableView.reloadData()
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    func getDetailSupplierOrders(){
        viewModel.getDetailSupplierOrders().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierOrdersDetailResponse>().mapArray(JSONObject: response.data) {}
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    

    func createPayment(){
        viewModel.createPayment().subscribe(onNext: { (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Bạn đã xác nhận nhập kho thành công", andIcon: UIImage(named: "icon-check-success"), duration: 2.0)
                self.dismiss(animated: true)
                self.viewModel.makePopViewController()
            } else if(response.code == RRHTTPStatusCode.badRequest.rawValue){
                JonAlert.show(message: response.message ?? "Xác nhận không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
                self.dismiss(animated: true)
            } else{
                dLog(response.message ?? "")
                JonAlert.show(message: response.message ?? "Xác nhận không thành công" , andIcon: UIImage(named: "icon-warning"), duration: 2.0)
            }
        }).disposed(by: rxbag)
    }
    
}

//MARK: REGISTER CELL TABLE VIEW
extension DetailedAccountsPayableViewController{
    
    func registerCell(){
        let detailedAccountsPayableTableViewCell = UINib(nibName: "DetailedAccountsPayableTableViewCell", bundle: .main)
        tableView.register(detailedAccountsPayableTableViewCell, forCellReuseIdentifier: "DetailedAccountsPayableTableViewCell")
        
        self.tableView.rowHeight = 50
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
    
    func bindTableView(){
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "DetailedAccountsPayableTableViewCell", cellType: DetailedAccountsPayableTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
            }.disposed(by: rxbag)

    }
}


