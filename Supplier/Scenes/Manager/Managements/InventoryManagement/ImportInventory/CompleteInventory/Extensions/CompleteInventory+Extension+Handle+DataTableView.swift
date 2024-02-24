//
//  CompleteInventoryViewController+Extension+DataTableView.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 19/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension CompleteInventoryViewController{
    func registerCell() {
        
        let completeInventoryTableViewCell = UINib(nibName: "CompleteInventoryTableViewCell", bundle: .main)
        tableView.register(completeInventoryTableViewCell, forCellReuseIdentifier: "CompleteInventoryTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.rx.modelSelected(SupplierWarehouseSessions.self).subscribe(onNext: { [self] element in
            dLog("Selected \(element)")
            self.viewModel.makeDetailCompleteInventoryViewController(idDetail: element.id)
        }).disposed(by: rxbag)
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "CompleteInventoryTableViewCell", cellType: CompleteInventoryTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
                
            }.disposed(by: rxbag)
   
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        getSupplierWarehouseSessions()
        refreshControl.endRefreshing()
   
    }
    
}
