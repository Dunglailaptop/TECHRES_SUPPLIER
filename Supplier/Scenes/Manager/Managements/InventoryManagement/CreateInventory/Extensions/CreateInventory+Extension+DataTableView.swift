//
//  CreateInventory+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: REGISTER CELL TABLE VIEW
extension CreateInventoryViewController {
    
    func registerCell() {
        
        let materialCreateInventoryTableViewCell = UINib(nibName: "MaterialCreateInventoryTableViewCell", bundle: .main)
        tableView.register(materialCreateInventoryTableViewCell, forCellReuseIdentifier: "MaterialCreateInventoryTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "MaterialCreateInventoryTableViewCell", cellType: MaterialCreateInventoryTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
                cell.btn_supplier_quantity.rx.tap.asDriver()
                            .drive(onNext: { [weak self] in
                                self?.viewModel.type_select_input_quantity.accept(2)
                                self?.presentModalInputQuantityViewController(number: Float(data.total_import_quantity), position: row)
                            }).disposed(by: cell.disposeBag)
            
                cell.btn_retail_price.rx.tap.asDriver()
                            .drive(onNext: { [weak self] in
                                self?.viewModel.type_select_input_money.accept(1)
                                self?.presentModalInputMoneyViewController(current_money: data.price, position: row)
                            }).disposed(by: cell.disposeBag)
            }.disposed(by: rxbag)
    }
    
    func handleDeleteMaterialAction(index: Int) {
        var cloneDataArray = viewModel.dataArray.value
        tableView.performBatchUpdates({
            cloneDataArray.remove(at: index)
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade) // animation when delete temporary not working
            viewModel.dataArray.accept(cloneDataArray)
        }, completion: nil)
        self.checkMaterial()
        Utils.isHideAllView(isHide: cloneDataArray.isEmpty ? false : true, view: root_view_empty_data)
        height_table_view.constant = cloneDataArray.isEmpty == true ? 200 : CGFloat(cloneDataArray.count * 65)
    }
    
    func checkMaterial(){
        let cloneDataArray = viewModel.dataArray.value
        let discountAmount = viewModel.discount_amount_display.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].price) * Double(cloneDataArray[index].total_import_quantity)
        }
        
        if viewModel.discount_percent.value == 0 {
            totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = totalChange + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
        } else {
            discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100 // tính giảm giá theo %
            totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
        }
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
        viewModel.total_price.accept(Int(totalAmount))
        lbl_total_price.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAmount))
        lbl_total_quantity.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: cloneDataArray.count)
        if cloneDataArray.isEmpty == true {
            viewModel.vat_amount.accept(0)
            viewModel.vat_percent.accept(0)
            viewModel.discount_amount.accept(0)
            viewModel.discount_amount_display.accept(0)
            viewModel.discount_percent.accept(0)
            lbl_total_price.text = "0"
            lbl_total_amount.text = "0"
            lbl_discount_amount.text = "0"
            lbl_vat_amount.text = "0"
            lbl_vat_percent.isHidden = true
            lbl_discount_percent.isHidden = true
            icon_check.image = UIImage(named: "icon-uncheck-blue")
            icon_check02.image = UIImage(named: "icon-uncheck-blue")
            icon_edit_vat.isHidden = true
            icon_edit_discount.isHidden = true
        }
    }
}

extension CreateInventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var  configuration : UISwipeActionsConfiguration?
        //Nút xoá
        let cancelAction = UIContextualAction(style: .destructive, title: ""){
            [weak self] (action, view, completionHandler) in
            self?.viewModel.type_dialog.accept(0)
            self?.presentModalDialogAcceptSupplierWarehouse(index: indexPath.row)
            completionHandler(true)
        }
        cancelAction.backgroundColor = ColorUtils.red_transparent_color()
        cancelAction.image = UIImage(named:"icon-deleted-item")
    
        configuration = UISwipeActionsConfiguration(actions: [cancelAction])
        configuration!.performsFirstActionWithFullSwipe = false

        return configuration
    }
}
