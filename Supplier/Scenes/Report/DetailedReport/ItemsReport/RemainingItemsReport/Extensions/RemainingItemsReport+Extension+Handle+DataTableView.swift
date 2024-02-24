//
//  ImportItemsReportViewController+Extension+Handle+DataTableView.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

//MARK: Register Cells As You want
extension RemainingItemsReportViewController {
    func registerCell(){
        let listRemainingItemsReportTableViewCell = UINib(nibName: "ListRemainingItemsReportTableViewCell", bundle: .main)
        tableView.register(listRemainingItemsReportTableViewCell, forCellReuseIdentifier: "ListRemainingItemsReportTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableView(){
        viewModel.dataArray.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "ListRemainingItemsReportTableViewCell", cellType: ListRemainingItemsReportTableViewCell.self))
        { [self] (row, data, cell) in
            cell.indexItem = row
            cell.view_color_category.backgroundColor = self.colors[row]
            cell.lbl_percent_category.textColor = self.colors[row]
            cell.viewModel = viewModel
            cell.data = data
            }.disposed(by: rxbag)
    }
    
    //MARK: Register Cells list area item
    func registerCellItem(){
        let colorsRemainingItemsReportTableViewCell = UINib(nibName: "ColorsRemainingItemsReportTableViewCell", bundle: .main)
        tableItemView.register(colorsRemainingItemsReportTableViewCell, forCellReuseIdentifier: "ColorsRemainingItemsReportTableViewCell")
        
        self.tableItemView.estimatedRowHeight = 80
        self.tableItemView.rowHeight = UITableView.automaticDimension
        tableItemView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableItemView(){
        viewModel.dataArray.bind(to: tableItemView.rx.items(cellIdentifier: "ColorsRemainingItemsReportTableViewCell", cellType: ColorsRemainingItemsReportTableViewCell.self))
            { [self] (row, data, cell) in
                    
                cell.back_ground_index.backgroundColor = self.colors[row]
                cell.lbl_index.text = String(row + 1)
                cell.data = data
                
            }.disposed(by: rxbag)
    }
}
