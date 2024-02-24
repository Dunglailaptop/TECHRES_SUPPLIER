//
//  NotificationViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 20/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxRelay
import RxCocoa
import RxSwiftExt

//MARK: REGISTER CELL TABLE VIEW
extension NotificationViewController{
    func registerCell() {
        let notificationRestaurantTableViewCell = UINib(nibName: "NotificationTableViewCell", bundle: .main)
        tableView.register(notificationRestaurantTableViewCell, forCellReuseIdentifier: "NotificationTableViewCell")

        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
//        tableView
//            .rx.setDelegate(self)
//            .disposed(by: rxbag)
        
        
        tableView.rx.reachedBottom(offset: CGFloat(self.viewModel.limit.value))
                   .subscribe(onNext:  {

                       if(self.viewModel.dataArray.value.count < self.totalRecord){
                           self.spinner.color = ColorUtils.main_color()
                           self.spinner.startAnimating()
                           self.spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.tableView.bounds.width, height: CGFloat(55))
                           self.tableView.tableFooterView = self.spinner
                           self.tableView.tableFooterView?.isHidden = false

                           // query the db on a background thread
                           DispatchQueue.main.async { [self] in
                               self.page += 1
                               self.viewModel.page.accept(page)
                               self.notifications()
                           }


                       }
                   }).disposed(by: rxbag)

        
    }

    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "NotificationTableViewCell", cellType: NotificationTableViewCell.self))
            {  (row, notification, cell) in
                cell.data = notification

            }.disposed(by: rxbag)
    }
}

