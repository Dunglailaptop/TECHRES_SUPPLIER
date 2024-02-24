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
extension RemainingCategoryReportViewController {
    func registerCell(){
        let listRemainingCategoryReportTableViewCell = UINib(nibName: "ListRemainingCategoryReportTableViewCell", bundle: .main)
        tableView.register(listRemainingCategoryReportTableViewCell, forCellReuseIdentifier: "ListRemainingCategoryReportTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableView(){
        viewModel.dataArray.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "ListRemainingCategoryReportTableViewCell", cellType: ListRemainingCategoryReportTableViewCell.self))
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
        let colorsRemainingCategoryReportTableViewCell = UINib(nibName: "ColorsRemainingCategoryReportTableViewCell", bundle: .main)
        tableItemView.register(colorsRemainingCategoryReportTableViewCell, forCellReuseIdentifier: "ColorsRemainingCategoryReportTableViewCell")
        
        self.tableItemView.estimatedRowHeight = 80
        self.tableItemView.rowHeight = UITableView.automaticDimension
        tableItemView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableItemView(){
        viewModel.dataArray.bind(to: tableItemView.rx.items(cellIdentifier: "ColorsRemainingCategoryReportTableViewCell", cellType: ColorsRemainingCategoryReportTableViewCell.self))
            { [self] (row, data, cell) in
                    
                cell.back_ground_index.backgroundColor = self.colors[row]
                cell.lbl_index.text = String(row + 1)
                cell.data = data
                
            }.disposed(by: rxbag)
    }
}
