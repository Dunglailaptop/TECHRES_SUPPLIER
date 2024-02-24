//
//  ListReceiptBillDebtViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import JonAlert
//MARK: CALL API
extension AccountsReceivableListViewController{
    
    func getSupplierDebtPayment(){
        viewModel.getSupplierDebtPayment().subscribe(onNext: { [self] (response) in
            dLog(response.toJSON())
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<SupplierDebtReceivableResponse>().map(JSONObject: response.data) {
                    
                    viewModel.dataArray.accept(dataFromServer.data)
                    var data = viewModel.dataArray.value
                    if viewModel.dataArraySearch.value.count > 0 {
                        var datasearch = viewModel.dataArraySearch.value
                        datasearch.enumerated().forEach{ (index,value) in
                            data.enumerated().forEach{(index1,value1) in
                                if value.id == value1.id && value.isSelected == ACTIVE{
                                    data[index1].isSelected = ACTIVE
                                }
                            }
                        }
                        viewModel.dataArray.accept(data)
                    }
                    lbl_total_debt.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: dataFromServer.total_amount)
                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false , view: root_view_empty_data)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    
    func createSupplierDebtPayment(supplierDebtReceivable: SupplierDebtReceivable){
        viewModel.createSupplierDebtPayment(supplierDebtReceivable: supplierDebtReceivable).subscribe(onNext: {[self] (response) in
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
extension AccountsReceivableListViewController{
  
   
    
    
    func registerCell() {
        let accountsReceivableListTableViewCell = UINib(nibName: "AccountsReceivableListTableViewCell", bundle: .main)
        tableView.register(accountsReceivableListTableViewCell, forCellReuseIdentifier: "AccountsReceivableListTableViewCell")
        
        tableView.rx.modelSelected(SupplierDebtReceivable.self).subscribe(onNext: { [self] element in
            self.viewModel.makeDetailReceiptBillDebtViewController(debtReceivable: element)
        }).disposed(by: rxbag)
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "AccountsReceivableListTableViewCell", cellType: AccountsReceivableListTableViewCell.self))
            {  (row, data, cell) in
                cell.viewModel = self.viewModel
                cell.data = data
            }.disposed(by: rxbag)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController

    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getSupplierDebtPayment()
        refreshControl.endRefreshing()
    }
}
