//
//  ManagementCustomerBrandViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

extension ManagementCustomerBrandViewController {
    func resgisterCell() {
        let managementCustomerBrandTableViewCell = UINib(nibName: "ManagementCustomerBrandTableViewCell", bundle: .main)
        tableview.register(managementCustomerBrandTableViewCell, forCellReuseIdentifier: "ManagementCustomerBrandTableViewCell")
        tableview.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableview.rx.modelSelected(Brand.self).subscribe(onNext: { [self] element in
            dLog("Selected \(element)")
            viewModel.makeToManagementListBranchesCustomerViewController(BrandDetail: element)
        }).disposed(by: rxbag)
    }
    
    func bindTableView(){
        viewModel.dataArray.bind(to: tableview.rx.items(cellIdentifier: "ManagementCustomerBrandTableViewCell", cellType: ManagementCustomerBrandTableViewCell.self)){ [self]
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
                               self.getBrandCustomer()
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
