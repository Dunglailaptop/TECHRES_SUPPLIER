//
//  PriceListManagement+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//, UIScrollViewDelegate

import UIKit
import JonAlert


extension PriceListManagementViewController {
    func Register(){
        let supplierTableViewCell = UINib(nibName: "SupplierTableViewCell", bundle: .main)
        tableView.register(supplierTableViewCell, forCellReuseIdentifier: "SupplierTableViewCell")
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
       
        self.refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tableView.addSubview(self.refreshControl) // not required when using UITableViewController
      
    }
    
    func bindingtable() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "SupplierTableViewCell", cellType: SupplierTableViewCell.self))
            {  (row, data, cell) in
                cell.viewModel = self.viewModel
                cell.data = data
//                self.scrollResfeshDown()
               
            }.disposed(by: rxbag)
      
      
    }
    @objc func refresh(_ sender: AnyObject) {
          // Code to refresh table view
           refreshControl.endRefreshing()
          viewModel.ClearDataAndCallApi()
    }
 
}




extension PriceListManagementViewController: UITextFieldDelegate {
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.ClearDataAndCallApi()
        return true
    }
}
extension PriceListManagementViewController: UITableViewDelegate, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var pagination = viewModel.pagination.value
        let tableViewContentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + tableViewHeight >= tableViewContentHeight {
            
            if(viewModel.dataArray.value.count < pagination.total_record && !pagination.isGetFullData && !pagination.isAPICalling){
                pagination.page += 1
                pagination.isAPICalling = true
                viewModel.pagination.accept(pagination)
                getListSupplier()
            }
        }
        
    }
}
