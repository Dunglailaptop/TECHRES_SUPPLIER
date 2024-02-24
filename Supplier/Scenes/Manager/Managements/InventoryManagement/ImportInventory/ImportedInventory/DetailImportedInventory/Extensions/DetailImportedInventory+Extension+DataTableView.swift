//
//  DetailImportedInventory+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: REGISTER CELL TABLE VIEW
extension DetailImportedInventoryViewController{
    
    func registerCell() {
        
        let detailImportedInventoryTableViewCell = UINib(nibName: "DetailImportedInventoryTableViewCell", bundle: .main)
        tableView.register(detailImportedInventoryTableViewCell, forCellReuseIdentifier: "DetailImportedInventoryTableViewCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableViewData() {
        viewModel.dataArrayMaterial.asObservable()
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImportedInventoryTableViewCell") as! DetailImportedInventoryTableViewCell
                    cell.data = element
                return cell
            }.disposed(by: rxbag)
    }
}
