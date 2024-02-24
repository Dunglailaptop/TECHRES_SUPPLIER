//
//  UnitManagementViewController + Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

extension UnitManagementViewController:UITableViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.dataArray.accept(viewModel.dataFilter.value)
        return true
    }
    
    
    func registerCell() {
        let unitManagementTableViewCell = UINib(nibName: "UnitManagementTableViewCell", bundle: .main)
        tableView.register(unitManagementTableViewCell, forCellReuseIdentifier: "UnitManagementTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.rx.modelSelected(MaterialUnit.self).subscribe(onNext: { [self] element in
            self.viewModel.makeCreateMaterialUnitViewController(materialUnit:element,isAllowToEdit:false)
        }).disposed(by: rxbag)
        
        tableView.rx.setDelegate(self).disposed(by: rxbag)
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "UnitManagementTableViewCell", cellType: UnitManagementTableViewCell.self))
            {(row, materialUnit, cell) in
                cell.data = materialUnit
                cell.holder_view.backgroundColor = self.viewModel.status.value == ACTIVE ? ColorUtils.blue_700() : ColorUtils.orange_700()
            }.disposed(by: rxbag)
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var  configuration : UISwipeActionsConfiguration?
        
        switch viewModel.status.value{
            case ACTIVE:
                //Nút chỉnh sửa
                let editBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.viewModel.makeCreateMaterialUnitViewController(materialUnit: self!.viewModel.dataArray.value[indexPath.item])
                    completionHandler(true)
                }
                editBtn.backgroundColor = ColorUtils.blue_000()
                editBtn.image = UIImage(named: "icon-edit-blue")
        
        
                let stopUsingBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.prensentDialogConfirm(content: String(format: "Tạm ngưng Đơn vị %@", self!.viewModel.dataArray.value[indexPath.item].name))
                    self!.viewModel.closure.accept({})
                    self!.viewModel.closure.accept(
                        {self!.changeMaterialUnitStatus(unitId: self!.viewModel.dataArray.value[indexPath.item].id)}
                    )
                    
                    completionHandler(true)
                }
                stopUsingBtn.backgroundColor = ColorUtils.gray_200()
                stopUsingBtn.image = UIImage(named: "icon-stop-using")
                configuration = UISwipeActionsConfiguration(actions: [stopUsingBtn,editBtn])
                configuration!.performsFirstActionWithFullSwipe = false
            
            case DEACTIVE:
                //Nút khôi phục
                let restoreBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
               
                    self!.prensentDialogConfirm(content: String(format: "Bật hoạt động Đơn vị %@", self!.viewModel.dataArray.value[indexPath.item].name))
                    self!.viewModel.closure.accept({})
                    self!.viewModel.closure.accept(
                        {self!.changeMaterialUnitStatus(unitId: self!.viewModel.dataArray.value[indexPath.item].id)}
                    )
                    completionHandler(true)
                }
                restoreBtn.backgroundColor =  ColorUtils.orange_000()
                restoreBtn.image = UIImage(named: "icon-restore-orange")
                configuration = UISwipeActionsConfiguration(actions: [restoreBtn])
                configuration!.performsFirstActionWithFullSwipe = false
                break
            
            default:
                break
        }

        return configuration
    }
}
