//
//  CreatePaymentRequest + Extension + registerCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
extension CreatePaymentRequestViewController {
    
    func registerCellAndBindTable(){
        registerCell()
        bindTableView()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        text_field.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .allEditingEvents)
        
        
    
        text_field.rx.controlEvent(.editingChanged).withLatestFrom(text_field.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let fullData = viewModel.fullReceivableList.value
                       if !query!.isEmpty{
                           var filteredDataArray = fullData.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.code.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.receivableList.accept(filteredDataArray)
                       }else{
                           viewModel.receivableList.accept(fullData)
                       }
                       
        }).disposed(by: rxbag)
        
    }
    
    private func registerCell(){
        let itemsManagementTableViewCell = UINib(nibName: "ItemTableViewCell", bundle: .main)
        
        tableView.register(itemsManagementTableViewCell, forCellReuseIdentifier: "ItemTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = 45

        tableView.rx.modelSelected(SupplierDebtReceivable.self).subscribe(onNext: { [self] element in
            view_of_tag_list.isHidden = false
            var receivableList = viewModel.receivableList.value
            
            if let position = receivableList.firstIndex(where: {$0.id==element.id}){
                receivableList[position].isSelected =  receivableList[position].isSelected == ACTIVE ? DEACTIVE : ACTIVE
                
                
                if receivableList[position].isSelected == ACTIVE{
                    tag_list.addTag(receivableList[position].code)
                }else if receivableList[position].isSelected == DEACTIVE  {
                    tag_list.removeTag(element.code)
                }
            }
            height_of_unit_specs_view.constant = tag_list.intrinsicContentSize.height <= 150
            ? tag_list.intrinsicContentSize.height
            : 150
            
            viewModel.receivableList.accept(receivableList)
            viewModel.updateFullReceivableList()
            
            var sum:Int = viewModel.receivableList.value.filter{$0.isSelected == ACTIVE}.map{$0.restaurant_debt_amount}.reduce(0, +)
            
            lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: sum)
        }).disposed(by: rxbag)
        
        
    }
    
    
    private func bindTableView(){
        viewModel.receivableList.bind(to: tableView.rx.items(cellIdentifier: "ItemTableViewCell", cellType: ItemTableViewCell.self))
            {(row, data, cell) in
                cell.lbl_name.text = data.code
                cell.icon_check.image = UIImage(named: data.isSelected == ACTIVE ? "icon-check" : "")
            }.disposed(by: rxbag)
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if text_field.isFirstResponder{
            view_of_table.isHidden = false
        }
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.tableView)

        if !tableView.bounds.contains(tapLocation){
            view_of_table.isHidden = true
        }

    }
    
}
