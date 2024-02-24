//
//  ListPendingOrderViewController+Extension+DataTableView.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 19/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension ListPendingOrderViewController{
    func registerCell() {
        
        let listPendingOrderTableViewCell = UINib(nibName: "ListPendingOrderTableViewCell", bundle: .main)
        tableView.register(listPendingOrderTableViewCell, forCellReuseIdentifier: "ListPendingOrderTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.rx.modelSelected(SupplierOrdersRequest.self).subscribe(onNext: { [self] element in
            dLog("Selected \(element)")
            self.viewModel.makeDetailPendingOrderViewController(dataDetail: element)
        }).disposed(by: rxbag)
        
        tableView.rx.reachedBottom(offset: CGFloat(self.viewModel.limit.value))
                   .subscribe(onNext:  {

                       if(!self.lastPosition){
                           self.spinner.color = ColorUtils.main_color()
                           self.spinner.startAnimating()
                           self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(55))
                           self.tableView.tableFooterView = self.spinner
                           self.tableView.tableFooterView?.isHidden = false

                           // query the db on a background thread
                           DispatchQueue.main.async { [self] in
                               self.page += 1
                               self.viewModel.page.accept(page)
                               self.getSupplierOrdersRequestList()
                           }
                       }
                   }).disposed(by: rxbag)
    }

    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ListPendingOrderTableViewCell", cellType: ListPendingOrderTableViewCell.self))
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
    
}
