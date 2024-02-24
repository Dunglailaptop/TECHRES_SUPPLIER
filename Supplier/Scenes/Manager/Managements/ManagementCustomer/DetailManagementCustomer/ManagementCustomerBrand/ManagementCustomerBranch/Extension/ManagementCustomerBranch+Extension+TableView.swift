//
//  ManagementListBranchesCustomerViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

extension ManagementCustomerBranchViewController {
    func resgisterCell() {
        let managementCustomerBranchTableViewCell = UINib(nibName: "ManagementCustomerBranchTableViewCell", bundle: .main)
        tableview.register(managementCustomerBranchTableViewCell, forCellReuseIdentifier: "ManagementCustomerBranchTableViewCell")
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableView(){
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ManagementCustomerBranchTableViewCell", cellType: ManagementCustomerBranchTableViewCell.self)){ [self]
            (row, data, cell) in
           
            cell.data = data
            cell.viewModel = viewModel
        }.disposed(by: rxbag)
        
        tableview.rx.reachedBottom(offset: CGFloat(self.viewModel.limit.value))
                   .subscribe(onNext:  {

                       if(!self.lastPosition){
                           self.spinner.color = ColorUtils.main_color()
                           self.spinner.startAnimating()
                           self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableview.bounds.width, height: CGFloat(55))
                           self.tableview.tableFooterView = self.spinner
                           self.tableview.tableFooterView?.isHidden = false

                           // query the db on a background thread
                           DispatchQueue.main.async { [self] in
                               self.page += 1
                               self.viewModel.page.accept(page)
                               self.getBranchCustomer()
                           }
                       }
                   }).disposed(by: rxbag)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableview.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.clearDataAndCallAPI()
        refreshControl.endRefreshing()
    }
}
