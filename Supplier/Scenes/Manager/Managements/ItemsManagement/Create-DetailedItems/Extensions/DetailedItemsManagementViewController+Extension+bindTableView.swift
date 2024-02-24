//
//  DetailedItemsManagementViewController+Extension+bindTableView.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import TagListView
import RxSwift
extension DetailedItemsManagementViewController:UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if text_field_category.isFirstResponder {
            viewModel.categories.accept(viewModel.fullCategories.value)
        }else if text_field_measure_unit.isFirstResponder{
            viewModel.measureUnits.accept(viewModel.fullMeasureUnits.value)
        }else if text_field_measure_specification.isFirstResponder{
            viewModel.measureUnitSpecifications.accept(viewModel.fullMeasureUnitSpecifications.value)
        }
        return true
    }
    
    @IBAction func actionShowCategoryList(_ sender: Any) {
        categoryListSwitcher = !categoryListSwitcher
        categoryListSwitcher ? showViewOfTable(view: view_of_table1) : hideViewOfTable(view: view_of_table1)
    }
    
    
    @IBAction func actionShowMeasureUnitList(_ sender: Any) {
        measureUnitListSwitcher = !measureUnitListSwitcher
        measureUnitListSwitcher ? showViewOfTable(view: view_of_table2) : hideViewOfTable(view: view_of_table2)
    }
    
    
    @IBAction func actionShowUnitSpecs(_ sender: Any) {
   
        if viewModel.item.value.material_unit_id <= 0 {
            lbl_measure_specs_err.text = "Không được bỏ trống Quy cách"
            lbl_measure_specs_err.isHidden = false
        }else {
            lbl_measure_specs_err.text = ""
            lbl_measure_specs_err.isHidden = true
            unitSpecsListSwitcher = !unitSpecsListSwitcher
            unitSpecsListSwitcher ? showViewOfTable(view: view_of_table3) : hideViewOfTable(view: view_of_table3)
        }
        
    }
    
    func registerCellAndBindTable(){
        registerCell()
        bindTableView()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
        

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window

        
        
        text_field_category.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .allEditingEvents)
        text_field_measure_unit.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .allEditingEvents)
        text_field_measure_specification.addTarget(self, action: #selector(textFieldDidChange(_:)),for: .allEditingEvents)
        
        category_tag_list.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        category_tag_list.delegate = self
        
        unit_tag_list.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        unit_tag_list.delegate = self
        
        measure_spces_tag_list.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        measure_spces_tag_list.delegate = self
        
        
        
        text_field_category.rx.controlEvent(.editingChanged).withLatestFrom(text_field_category.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let fullData = viewModel.fullCategories.value
                       if !query!.isEmpty{
                           var filteredDataArray = fullData.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.categories.accept(filteredDataArray)
                       }else{
                           viewModel.categories.accept(fullData)
                       }
                       
                       height_of_view_of_table1.constant = CGFloat(viewModel.categories.value.count*45)
                       self.view.layoutIfNeeded()
        }).disposed(by: rxbag)
        
        
        
        text_field_measure_unit.rx.controlEvent(.editingChanged).withLatestFrom(text_field_measure_unit.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let fullData = viewModel.fullMeasureUnits.value
                       if !query!.isEmpty{
                           var filteredDataArray = fullData.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })

                           viewModel.measureUnits.accept(filteredDataArray)
                       }else{
                           viewModel.measureUnits.accept(fullData)
                       }
                       
                       height_of_tableView2.constant = CGFloat(viewModel.measureUnits.value.count*45)
                       self.view.layoutIfNeeded()
        }).disposed(by: rxbag)
        
        
        
        
        
        
        text_field_measure_specification.rx.controlEvent(.editingChanged).withLatestFrom(text_field_measure_specification.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let fullData = viewModel.fullMeasureUnitSpecifications.value
                       if !query!.isEmpty{
                           var filteredDataArray = fullData.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.measureUnitSpecifications.accept(filteredDataArray)
                       }else{
                           viewModel.measureUnitSpecifications.accept(fullData)
                       }
                       
                       height_of_tableView3.constant = CGFloat(viewModel.measureUnitSpecifications.value.count*45)
                       self.view.layoutIfNeeded()
                       
        }).disposed(by: rxbag)
        
        
    }
    
    
    private func registerCell(){
        let itemsManagementTableViewCell = UINib(nibName: "ItemTableViewCell", bundle: .main)
        
        table1.register(itemsManagementTableViewCell, forCellReuseIdentifier: "ItemTableViewCell")
        table1.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table1.rowHeight = 45
        table1.isScrollEnabled = false
        
        table1.rx.modelSelected(MaterialCategory.self).subscribe(onNext: { [self] element in
            var categories = viewModel.categories.value
            var item = viewModel.item.value
            item.material_category_id = element.id
            categories = categories.map{(value) in
                var category = value
                category.isSelect = value.id == element.id ? ACTIVE : DEACTIVE
                return category
            }
            category_tag_list.removeAllTags()
            category_tag_list.addTag(element.name,id:element.id)
            viewModel.categories.accept(categories)
            viewModel.item.accept(item)
            view_of_category_tag_list.isHidden = false
        }).disposed(by: rxbag)
        
        
        table2.register(itemsManagementTableViewCell, forCellReuseIdentifier: "ItemTableViewCell")
        table2.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table2.rowHeight = 45
        table2.isScrollEnabled = false
        table2.rx.modelSelected(MaterialMeasureUnit.self).subscribe(onNext: { [self] element in
            var units = viewModel.measureUnits.value
            var item = viewModel.item.value
            
            units = units.map{(value) in
                var unit = value
                unit.isSelect = value.id == element.id ? ACTIVE : DEACTIVE
                return unit
            }
            
            if element.id != viewModel.item.value.material_unit_id{
                item.material_unit_id = element.id
                unit_tag_list.removeAllTags()
                unit_tag_list.addTag(element.name,id:element.id)
                viewModel.measureUnitSpecifications.accept(element.material_unit_specifications)
                viewModel.fullMeasureUnitSpecifications.accept(element.material_unit_specifications)
                height_of_tableView3.constant = CGFloat(viewModel.measureUnitSpecifications.value.count*45)
                
                item.material_unit_specification_id = 0
                measure_spces_tag_list.removeAllTags()
            }
         
            viewModel.measureUnits.accept(units)
            view_of_unit_tag_list.isHidden = false
            viewModel.item.accept(item)
        }).disposed(by: rxbag)
        
        
        

        table3.register(itemsManagementTableViewCell, forCellReuseIdentifier: "ItemTableViewCell")
        table3.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        table3.rowHeight = 45
        table3.isScrollEnabled = false
        table3.rx.modelSelected(MaterialUnitSpecification.self).subscribe(onNext: { [self] element in
            var item = viewModel.item.value
            item.material_unit_specification_id = element.id
            var unitSpecs = viewModel.measureUnitSpecifications.value
            unitSpecs = unitSpecs.map{(value) in
                var unitSpec = value
                unitSpec.isSelect = value.id == element.id ? ACTIVE : DEACTIVE
                return unitSpec
            }
            view_of_measure_specs_tag_list.isHidden = false
            measure_spces_tag_list.removeAllTags()
            measure_spces_tag_list.addTag(element.name,id:element.id)
            viewModel.measureUnitSpecifications.accept(unitSpecs)
            viewModel.item.accept(item)
        }).disposed(by: rxbag)
    }
    
    
    private func bindTableView(){
        viewModel.categories.bind(to: table1.rx.items(cellIdentifier: "ItemTableViewCell", cellType: ItemTableViewCell.self))
            {(row, data, cell) in
                cell.lbl_name.text = data.name
                cell.icon_check.image = UIImage(named: data.isSelect == ACTIVE ? "icon-check" : "")
            }.disposed(by: rxbag)
        
        viewModel.measureUnits.bind(to: table2.rx.items(cellIdentifier: "ItemTableViewCell", cellType: ItemTableViewCell.self))
            {(row, data, cell) in
                cell.lbl_name.text = data.name
                cell.icon_check.image = UIImage(named: data.isSelect == ACTIVE ? "icon-check" : "")
            }.disposed(by: rxbag)
        
        viewModel.measureUnitSpecifications.bind(to: table3.rx.items(cellIdentifier: "ItemTableViewCell", cellType: ItemTableViewCell.self))
            {(row, data, cell) in
                cell.lbl_name.text = data.name
                cell.icon_check.image = UIImage(named: data.isSelect == ACTIVE ? "icon-check" : "")
            }.disposed(by: rxbag)
        
    }
    
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if text_field_category.isFirstResponder{
            viewModel.categories.value.count > 0 ? showViewOfTable(view: view_of_table1) : hideViewOfTable(view: view_of_table1)
 
        }else if text_field_measure_unit.isFirstResponder{
            viewModel.measureUnits.value.count > 0 ? showViewOfTable(view: view_of_table2) : hideViewOfTable(view: view_of_table2)

        }else if text_field_measure_specification.isFirstResponder{
            viewModel.measureUnitSpecifications.value.count > 0 ? showViewOfTable(view: view_of_table3) : hideViewOfTable(view: view_of_table3)
            
            if viewModel.item.value.material_unit_id <= 0 {
                lbl_measure_specs_err.text = "Không được bỏ trống Quy cách"
                lbl_measure_specs_err.isHidden = false
            }else {
                lbl_measure_specs_err.text = ""
                lbl_measure_specs_err.isHidden = true
            }
          
        }
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocationOfTable1 = gesture.location(in: self.table1)
        let tapLocationOfTable2 = gesture.location(in: self.table2)
        let tapLocationOfTable3 = gesture.location(in: self.table3)
        
        
        if text_field_category.isFirstResponder && !table1.bounds.contains(tapLocationOfTable1){
            view_of_table1.isHidden = true
        }else if text_field_measure_unit.isFirstResponder && !table2.bounds.contains(tapLocationOfTable2){
            view_of_table2.isHidden = true

        }else if text_field_measure_specification.isFirstResponder && !table3.bounds.contains(tapLocationOfTable3){
            view_of_table3.isHidden = true
        }

    }
    
    @objc private func keyboardWillShow(notification: NSNotification ) {

        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if text_field_category.isFirstResponder {
                main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height / 1.35)
            }else if text_field_measure_unit.isFirstResponder{
                main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height / 1.35)
            }else if text_field_measure_specification.isFirstResponder{
                main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height / 1.35)
            }
            
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if text_field_category.isFirstResponder || text_field_measure_unit.isFirstResponder || text_field_measure_specification.isFirstResponder {
            main_view.transform = .identity
            view_of_table1.isHidden = true
            view_of_table2.isHidden = true
            view_of_table3.isHidden = true
        }
        
     
    }
    
    
    private func showViewOfTable(view:UIView){
        view_of_table1.isHidden = true
        view_of_table2.isHidden = true
        view_of_table3.isHidden = true
        view.isHidden = false
    }
    
    
    private func hideViewOfTable(view:UIView){
        view.isHidden = true
    }
    
}


extension DetailedItemsManagementViewController:TagListViewDelegate{
    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        if sender.tag == 1{
            let categories = viewModel.categories.value
            if let position = categories.firstIndex(where: {$0.id == tagView.tag}){
                category_tag_list.removeTag(title)
                view_of_category_tag_list.isHidden = true
                var item = viewModel.item.value
                item.material_category_id = 0
                viewModel.item.accept(item)
                
                
                var categories = viewModel.categories.value
                categories = categories.map{(value) in
                    var category = value
                    category.isSelect = DEACTIVE
                    return category
                }
                
                viewModel.categories.accept(categories)
                
            }
        }else if sender.tag == 2{
            let units = viewModel.measureUnits.value
            if let position = units.firstIndex(where: {$0.id == tagView.tag}){
                category_tag_list.removeTag(title)
                view_of_unit_tag_list.isHidden = true
                viewModel.measureUnitSpecifications.accept([])
                measure_spces_tag_list.removeAllTags()
                var item = viewModel.item.value
                item.material_unit_id = 0
                item.material_unit_specification_id = 0
                viewModel.item.accept(item)
                measure_spces_tag_list.removeAllTags()
                
                var units = viewModel.measureUnits.value
                units = units.map{(value) in
                    var unit = value
                    unit.isSelect = DEACTIVE
                    return unit
                }
                
                viewModel.measureUnits.accept(units)

            }
        }else if sender.tag == 3{
            let unitSpecs = viewModel.measureUnitSpecifications.value
            if let position = unitSpecs.firstIndex(where: {$0.id == tagView.tag}){
                measure_spces_tag_list.removeTag(title)
                view_of_measure_specs_tag_list.isHidden = true
                measure_spces_tag_list.removeAllTags()
                var item = viewModel.item.value
                item.material_unit_specification_id = 0
                viewModel.item.accept(item)
                
                
                var unitSpecs = viewModel.measureUnitSpecifications.value
                unitSpecs = unitSpecs.map{(value) in
                    var unitSpec = value
                    unitSpec.isSelect = DEACTIVE
                    return unitSpec
                }
                viewModel.measureUnitSpecifications.accept(unitSpecs)
            }
        }
    }
}
