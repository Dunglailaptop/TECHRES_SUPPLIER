//
//  ReportDayOffViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert

//MARK: REGISTER CELL TABLE VIEW
extension ItemsManagementViewController{
    func registerCell() {
        let itemsManagementTableViewCell = UINib(nibName: "ItemsManagementTableViewCell", bundle: .main)
        tableView.register(itemsManagementTableViewCell, forCellReuseIdentifier: "ItemsManagementTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView.rx.modelSelected(Material.self).subscribe(onNext: { [self] element in
            viewModel.makeDetailedItemsManagemenTViewController(item: element,isAllowEditting: false)
        })
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UItableViewController
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ItemsManagementTableViewCell", cellType: ItemsManagementTableViewCell.self))
            {(row, material, cell) in
                cell.data = material
                cell.viewModel = self.viewModel
                cell.handle_view.backgroundColor = self.viewModel.status.value == ACTIVE ? ColorUtils.blue_700() : ColorUtils.orange_700()
            }.disposed(by: rxbag)
    }
    
    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        viewModel.clearDataAndCallAPI()
    }
    
}

extension ItemsManagementViewController: UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var pagination = viewModel.pagination.value
        let tableViewContentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + tableViewHeight >= tableViewContentHeight {
            
            if(viewModel.dataArray.value.count < pagination.total_record && !pagination.isGetFullData && !pagination.isAPICalling){
                pagination.page += 1
                pagination.isAPICalling = true
                viewModel.pagination.accept(pagination)
                getItemList()
            }
        }
        
    }

    
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var  configuration : UISwipeActionsConfiguration?
        switch viewModel.status.value{
            case ACTIVE:
              
                //Nút chỉnh sửa
                let editBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.viewModel.makeDetailedItemsManagemenTViewController(
                        item: self!.viewModel.dataArray.value[indexPath.row],
                        isAllowEditting: true)
                    completionHandler(true)
                }
                editBtn.backgroundColor = ColorUtils.blue_000()
                editBtn.image = UIImage(named: "icon-edit-blue")
            
                //Nút ngưng
                let stopUsingBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                        self!.prensentDialogConfirm(content: String(format: "%@ sẽ tạm ngưng?", self!.viewModel.dataArray.value[indexPath.row].name) )
                        self!.viewModel.closure.accept {self!.changeItemStatus(item: (self?.viewModel.dataArray.value[indexPath.row])!)}
                    completionHandler(true)
                }
                stopUsingBtn.backgroundColor = ColorUtils.gray_200()
                stopUsingBtn.image = UIImage(named:"icon-stop-using")
            
                configuration = UISwipeActionsConfiguration(actions: [stopUsingBtn,editBtn])
                configuration!.performsFirstActionWithFullSwipe = false
            
            case DEACTIVE:
                //Nút khôi phục
                let restoreBtn = UIContextualAction(style: .destructive, title: ""){
                    [weak self] (action, view, completionHandler) in
                    self!.prensentDialogConfirm(content: String(format: "%@ sẽ được khôi phục", self!.viewModel.dataArray.value[indexPath.row].name))
                    self!.viewModel.closure.accept {
                        self!.changeItemStatus(item: (self?.viewModel.dataArray.value[indexPath.row])!)
                    }
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





