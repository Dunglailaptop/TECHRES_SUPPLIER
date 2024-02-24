//
//  ReceiptAndPaymentCategoryViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import RxSwift
import RxRelay
import ObjectMapper
extension ReceiptAndPaymentCatetoryViewController {
    
    private func mapData(data:[ReceiptPaymentCategory]){
        /*hàm này dùng để filter dữ liệu cần hiển thị, và hiển thị tổng số lượng đang active và deactive trên tab sub-header*/
        viewModel.dataArray.accept(data.filter({(element) in element.is_hidden == viewModel.is_hidden.value}))
        tableView.reloadSections(IndexSet([0]), with: .left)
        //is_hidden = 0 -> ACTIVE,  is_hidden = 1 -> DEACTIVE
        let activeNumber = data.filter({(element) in element.is_hidden == 0}).count
        let deactiveNumber = data.filter({(element) in element.is_hidden == 1}).count
        lbl_active_hint.text = String(format: "%@", activeNumber > 99 ? "99+" : String(activeNumber) )
        lbl_deactive_hint.text = String(format: "%@", deactiveNumber > 99 ? "99+" : String(deactiveNumber) )
    }
    
    func getReceiptAndPaymenCategory(){
        viewModel.getReceiptAndPaymentCategory().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ReceiptPaymentCategory>().mapArray(JSONObject: response.data) {
                    viewModel.adequateDataArray.accept(dataFromServer)
                    mapData(data: dataFromServer)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true : false, view: self.view_empty_data)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    func changeReceiptAndPaymentCategoryStatus(id:Int = 0){
        viewModel.changeReceiptAndPaymentCategoryStatus(id: id).subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message:"Đã thay đổi trạng thái thành công",duration:2.0)
                
                if let position = viewModel.adequateDataArray.value.firstIndex(where: {(element) in element.id == id}){
                    var cloneAdequateDataArray = viewModel.adequateDataArray.value
                    //is_hidden = 0 -> ACTIVE,  is_hidden = 1 -> DEACTIVE
                    cloneAdequateDataArray[position].is_hidden = viewModel.is_hidden.value == 0 ? 1 : 0
                    viewModel.adequateDataArray.accept(cloneAdequateDataArray)
                    
                    mapData(data:  viewModel.adequateDataArray.value)
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
}

extension ReceiptAndPaymentCatetoryViewController{
    func registerCell() {
        let receiptAndPaymentCategoryTableViewCell = UINib(nibName: "ReceiptAndPaymentCategoryTableViewCell", bundle: .main)
        tableView.register(receiptAndPaymentCategoryTableViewCell, forCellReuseIdentifier: "ReceiptAndPaymentCategoryTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        

    }

    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ReceiptAndPaymentCategoryTableViewCell", cellType: ReceiptAndPaymentCategoryTableViewCell.self))
            {(row, category, cell) in
                cell.viewModel = self.viewModel
                cell.data = category
                cell.delegate = self
            }.disposed(by: rxbag)
    }


}

