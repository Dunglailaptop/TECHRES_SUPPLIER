//
//  MaterialInventory+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

extension MaterialInventoryViewController {
    
    func registerCell() {
        let materialInventoryTableViewCell = UINib(nibName: "MaterialInventoryTableViewCell", bundle: .main)
        tableView.register(materialInventoryTableViewCell, forCellReuseIdentifier: "MaterialInventoryTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
   }
  
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "MaterialInventoryTableViewCell", cellType: MaterialInventoryTableViewCell.self))
            {  (row, data, cell) in
    
                cell.data = data
                cell.btnCheck.rx.tap.asDriver()
                       .drive(onNext: { [self] in
                           
                           var dataArray = viewModel.dataArray.value
                           var cloneMaterialSelected = viewModel.selectedDataArray.value
                           var dataFilter = viewModel.dataFilter.value
                           
                           dataArray.enumerated().forEach { (index, value) in
                               if(cell.data?.id == value.id){
                                   dataArray[index].isSelected = cell.data?.isSelected == ACTIVE ? DEACTIVE : ACTIVE
                                   let pos = cloneMaterialSelected.firstIndex(where: {(element) in
                                       return element.id == viewModel.materialIdSelected.value})
                                   if(pos == nil){
                                       cloneMaterialSelected.append(dataArray[index])
                                   }else {
                                       cloneMaterialSelected[pos!] = dataArray[index]
                                   }
                               }else {
                                   viewModel.materialIdSelected.accept(value.id)
                               }
                           }
                           
                           dataFilter.enumerated().forEach { (index, value) in
                               if(data.id == value.id){
                                   dataFilter[index].isSelected = data.isSelected == ACTIVE ? DEACTIVE : ACTIVE
                               }
                           }
                           let selectedItems = dataArray.filter{ $0.isSelected == ACTIVE }
                           viewModel.dataArray.accept(dataArray)
                           viewModel.dataFilter.accept(dataFilter)
                           viewModel.selectedDataArray.accept(cloneMaterialSelected)
                           material_selected = selectedItems
                       }).disposed(by: cell.disposeBag)
            }.disposed(by: rxbag)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
//        getItemList()
        refreshControl.endRefreshing()
    }
}
