//
//  DialogChooseRestaurantBranch+Extension+DataTable.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 19/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: register cell and binding data
extension DialogFilterRestaurantBranchViewController {
    
    func registerCell() {
        let dialogFilterRestaurantBranchTableViewCell = UINib(nibName: "DialogFilterRestaurantBranchTableViewCell", bundle: .main)
        tableView.register(dialogFilterRestaurantBranchTableViewCell, forCellReuseIdentifier: "DialogFilterRestaurantBranchTableViewCell")
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.rx.modelSelected(Restaurant.self).subscribe(onNext: { [self] element in
            if viewModel.data_type.value == 0{
                lbl_title_table.text = "CHỌN THƯƠNG HIỆU"
                viewModel.restaurant_id.accept(element.id)
                viewModel.dataRestaurant.accept(element)
                lbl_restaurant.text = element.name
                viewModel.data_type.accept(1)
                viewModel.clearData()
                getBrandList()
            }else if viewModel.data_type.value == 1 {
                lbl_title_table.text = "CHỌN CHI NHÁNH"
                viewModel.restaurant_brand_id.accept(element.id)
                viewModel.dataBrand.accept(element)
                lbl_brand.text = element.name
                viewModel.data_type.accept(2)
                viewModel.clearData()
                getBranchList()
            } else {
                viewModel.branch_id.accept(element.id)
                viewModel.dataBranch.accept(element)
                lbl_branch.text = element.name
                Utils.isHideAllView(isHide: true, view: root_view_table)
                Utils.isHideAllView(isHide: false, view: root_view_choose_filter)
            }
            
        }).disposed(by: rxbag)
    }
    
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "DialogFilterRestaurantBranchTableViewCell", cellType: DialogFilterRestaurantBranchTableViewCell.self))
        {(row, data, cell) in
            cell.data = data
        }.disposed(by: rxbag)
    }
    
}

extension DialogFilterRestaurantBranchViewController:UITextFieldDelegate{
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.clearData()
        
        return true
    }
}
