//
//  DetailPendingOrder+Extension+DataTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

//MARK: REGISTER CELL TABLE VIEW
extension DetailPendingInventoryViewController{
    
    func registerCell() {
        
        let detailPendingInventoryTableViewCell = UINib(nibName: "DetailPendingInventoryTableViewCell", bundle: .main)
        tableView.register(detailPendingInventoryTableViewCell, forCellReuseIdentifier: "DetailPendingInventoryTableViewCell")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)    }
    
    func bindTableViewData() {
        viewModel.dataArray.asObservable()
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailPendingInventoryTableViewCell") as! DetailPendingInventoryTableViewCell
                    cell.data = element
                
                    cell.btn_supplier_input_quantity.rx.tap.asDriver()
                                .drive(onNext: { [weak self] in
                                    self?.viewModel.type_select_input_quantity.accept(2)
                                    self?.presentModalInputQuantityViewController(number: Float(element.supplier_input_quantity), position: index)
                                }).disposed(by: cell.disposeBag)
                
                    cell.btn_supplier_input_price.rx.tap.asDriver()
                                .drive(onNext: { [weak self] in
                                    self?.viewModel.type_select_input_money.accept(1)
                                    self?.presentModalInputMoneyViewController(current_money: element.supplier_input_price, position: index)
                                }).disposed(by: cell.disposeBag)
                return cell
            }.disposed(by: rxbag)
    }
}

extension DetailPendingInventoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var  configuration : UISwipeActionsConfiguration?
        //Nút xoá
        let cancelAction = UIContextualAction(style: .destructive, title: ""){
            [weak self] (action, view, completionHandler) in
            self?.viewModel.type_dialog.accept(2)
            self?.presentModalDialogAcceptPendingOrder(index: indexPath.row)
            completionHandler(true)
        }
        cancelAction.backgroundColor = ColorUtils.red_transparent_color()
        cancelAction.image = UIImage(named:"icon-deleted-item")
    
        configuration = UISwipeActionsConfiguration(actions: [cancelAction])
        configuration!.performsFirstActionWithFullSwipe = false

        return configuration
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
        height_table_view.constant = cloneDataArray.isEmpty == true ? 250 : CGFloat(cloneDataArray.count * 65)
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
            totalAmount += Double(cloneDataArray[index].supplier_input_price) * Double(cloneDataArray[index].supplier_input_quantity)
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
        viewModel.total_price.accept(Int(totalAmount))
        lbl_total_price.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAmount))
        lbl_total_quantity.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: cloneDataArray.count)
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
        if cloneDataArray.isEmpty == true {
            viewModel.vat_amount.accept(0)
            viewModel.vat_percent.accept(0)
            viewModel.discount_amount.accept(0)
            viewModel.discount_amount_display.accept(0)
            viewModel.discount_percent.accept(0)
            viewModel.total_amount.accept(0)
            viewModel.total_price.accept(0)
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
            Utils.isHideAllView(isHide: true, view: view_btn_update)
        }
    }
}
