//
//  DialogChooseCategory + extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension DialogChooseCategoryViewController{
    
    
    func registerCellAndBindTableView(){
        registerCell()
        bindTableViewData()
    }
    
    private func registerCell(){
        let dialogChooseCategoryTableViewCell = UINib(nibName: "DialogChooseCategoryTableViewCell", bundle: .main)
        tableView.register(dialogChooseCategoryTableViewCell, forCellReuseIdentifier: "DialogChooseCategoryTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
  
    }

    
    private func bindTableViewData() {
        viewModel.objectArray.bind(to: tableView.rx.items(cellIdentifier: "DialogChooseCategoryTableViewCell", cellType: DialogChooseCategoryTableViewCell.self))
            {(row, object, cell) in
                cell.viewModel = self.viewModel
                cell.object = object
        }.disposed(by: rxbag)
    }
    

}
