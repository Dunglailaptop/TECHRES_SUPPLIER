//
//  ReceiptBillDebt+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: REGISTER CELL TABLE VIEW
extension AccountsReceivableViewController:UITextFieldDelegate {
    
    func registerCell() {
        
        let accountsReceivableTableViewCell = UINib(nibName: "AccountsReceivableTableViewCell", bundle: .main)
        tableView.register(accountsReceivableTableViewCell, forCellReuseIdentifier: "AccountsReceivableTableViewCell")
        
        self.tableView.estimatedRowHeight = 60
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        
        tableView.rx.modelSelected(RestaurantWithReceipt.self).subscribe(onNext: { [self] element in
            self.viewModel.makeListReceiptBillDebtViewController(restaurant: element)
            dLog(element)
        }).disposed(by: rxbag)
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "AccountsReceivableTableViewCell", cellType: AccountsReceivableTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
            }.disposed(by: rxbag)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.clearDataAndCallAPI()
        refreshControl.endRefreshing()
   
    }
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
}
