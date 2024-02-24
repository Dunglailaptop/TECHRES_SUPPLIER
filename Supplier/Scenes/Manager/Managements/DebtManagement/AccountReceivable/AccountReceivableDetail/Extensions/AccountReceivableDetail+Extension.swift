//
//  DetailReceiptBillDebtViewController+Extension.swift
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

extension AccountReceivableDetailViewController {
    func getDetailSupplierOrders(){
        viewModel.getDetailSupplierOrders().subscribe(onNext: { [self] (response) in
            dLog(response.data)
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var dataFromServer = Mapper<SupplierOrdersDetailResponse>().mapArray(JSONObject: response.data) {
                    viewModel.debtReceivableDataArray.accept(dataFromServer)
                    var data = viewModel.debtReceivable.value
                    data.total_return =  viewModel.debtReceivableDataArray.value.map { Int($0.return_quantity) * $0.price_reality }.reduce(0, +) ?? 0
                    viewModel.debtReceivable.accept(data)
                
                    tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    
    func createPaymentRequest(){
        viewModel.createPaymentRequest().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Đã tạo phiếu yêu cầu thành công",duration: 2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
}

//MARK: REGISTER CELL TABLE VIEW
extension AccountReceivableDetailViewController{
    
    func registerCell(){
        let infoDetailReceiptBillDebtTableViewCell = UINib(nibName: "InfoDetailReceiptBillDebtTableViewCell", bundle: .main)
        tableView.register(infoDetailReceiptBillDebtTableViewCell, forCellReuseIdentifier: "InfoDetailReceiptBillDebtTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindTableView(){
        viewModel.dataSectionArray.asObservable()
            .bind(to: tableView.rx.items){ [self] (tableView, index, element) in
                switch(element){
                    default:
                        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoDetailReceiptBillDebtTableViewCell") as! InfoDetailReceiptBillDebtTableViewCell
                        cell.viewModel = viewModel
                        cell.height_of_tableView.constant = CGFloat(viewModel.debtReceivableDataArray.value.count * 80)
                        cell.lbl_total_material.text = String(viewModel.debtReceivableDataArray.value.count)
                        return cell
                }
        }.disposed(by: rxbag)
    }
}

extension AccountReceivableDetailViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
