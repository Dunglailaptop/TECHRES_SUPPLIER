//
//  CancelExportInventoryViewController+Extension+DataTableView.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 19/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension CancelExportInventoryViewController{
    func registerCell() {
        
        let cancelExportInventoryTableViewCell = UINib(nibName: "CancelExportInventoryTableViewCell", bundle: .main)
        tableView.register(cancelExportInventoryTableViewCell, forCellReuseIdentifier: "CancelExportInventoryTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.rx.modelSelected(SupplierWarehouseSessions.self).subscribe(onNext: { [self] element in
            dLog("Selected \(element)")
            self.viewModel.makeDetailCancelExportInventoryViewController(idDetail: element.id)
        }).disposed(by: rxbag)
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "CancelExportInventoryTableViewCell", cellType: CancelExportInventoryTableViewCell.self))
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
