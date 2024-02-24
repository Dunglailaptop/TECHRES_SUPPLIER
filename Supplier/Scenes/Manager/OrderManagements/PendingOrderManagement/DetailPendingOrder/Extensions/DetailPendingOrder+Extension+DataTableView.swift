//
//  DetailPendingOrder+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: REGISTER CELL TABLE VIEW
extension DetailPendingOrderViewController{
    
    func registerCell() {
        
        let detailPendingOrderTableViewCell = UINib(nibName: "DetailPendingOrderTableViewCell", bundle: .main)
        tableView.register(detailPendingOrderTableViewCell, forCellReuseIdentifier: "DetailPendingOrderTableViewCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func bindTableViewData() {
        viewModel.dataArray.asObservable()
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPendingOrderTableViewCell") as! DetailPendingOrderTableViewCell
                    cell.data = element
                
                    cell.btn_supplier_quantity.rx.tap.asDriver()
                                .drive(onNext: { [weak self] in
                                    self?.viewModel.type_select_input_quantity.accept(2)
                                    self?.presentModalInputQuantityViewController(number: element.supplier_quantity, position: index)
                                }).disposed(by: cell.disposeBag)
                
                    cell.btn_retail_price.rx.tap.asDriver()
                                .drive(onNext: { [weak self] in
                                    self?.viewModel.type_select_input_money.accept(1)
                                    self?.presentModalInputMoneyViewController(current_money: element.retail_price, position: index)
                                }).disposed(by: cell.disposeBag)
                
                return cell
            }.disposed(by: rxbag)
    }
}
