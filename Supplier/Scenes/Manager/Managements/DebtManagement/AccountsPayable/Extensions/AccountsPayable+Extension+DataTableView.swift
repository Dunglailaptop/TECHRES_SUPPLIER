//
//  PaymentBillDebt+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

extension AccountsPayableViewController:UITextFieldDelegate,UITableViewDelegate {
    
    func registerCell() {
        let accountsPayableTableViewCell = UINib(nibName: "AccountsPayableTableViewCell", bundle: .main)
        tableView.register(accountsPayableTableViewCell, forCellReuseIdentifier: "AccountsPayableTableViewCell")
        tableView.rx.modelSelected(WarehouseReceipt.self).subscribe(onNext: { [self] element in
            self.viewModel.makeDetailedAccountsPayableViewController(receipt: element)
        }).disposed(by: rxbag)
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by:rxbag)
   
   }
  
    
    func bindTableViewData() {
        viewModel.warehouseReceiptList.bind(to: tableView.rx.items(cellIdentifier: "AccountsPayableTableViewCell", cellType: AccountsPayableTableViewCell.self))
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
        viewModel.clearDataAndCallAPI()
        refreshControl.endRefreshing()
    }
    
    
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var pagination = viewModel.pagination.value
        let tableViewContentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        
        
        if(viewModel.warehouseReceiptList.value.count < pagination.totalRecord && !pagination.isGetFullData && !pagination.isAPICalling){
            pagination.page += 1
            pagination.isAPICalling = true
            viewModel.pagination.accept(pagination)
            getSupplierWarehouseSession()
        }
    }
    
    
 
    func textFieldShouldClear(_: UITextField) -> Bool{
        var searchUtility = viewModel.search.value
        searchUtility.key_search = ""
        viewModel.search.accept(searchUtility)
        viewModel.clearDataAndCallAPI()
        return true
    }
}




