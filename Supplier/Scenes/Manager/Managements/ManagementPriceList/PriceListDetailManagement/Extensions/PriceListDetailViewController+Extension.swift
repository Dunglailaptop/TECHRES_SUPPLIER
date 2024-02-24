//
//  PriceListDetailViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 18/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa


extension PriceListDetailViewController {
    func registerCell() {
        
        let priceListDetailTableViewCell = UINib(nibName: "PriceListDetailTableViewCell", bundle: .main)
        tableView.register(priceListDetailTableViewCell, forCellReuseIdentifier: "PriceListDetailTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)


        
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "PriceListDetailTableViewCell", cellType: PriceListDetailTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
                cell.viewModel = self.viewModel
//
                
                
                cell.selectionStyle = .none
              
            }.disposed(by: rxbag)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        

      
     }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.CleardataAndCallAPI()
        refreshControl.endRefreshing()
    }
    

}

extension PriceListDetailViewController: UITextFieldDelegate {
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.CleardataAndCallAPI()
        return true
    }
}

extension PriceListDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let order_detail = viewModel.dataArray.value[indexPath.row]
            
            // Create a custom view with an image and label
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 10, width: 35, height: 35))
            imageView.image = UIImage(named: "fi-sr-refresh-green")
            imageView.contentMode = .scaleAspectFit
            imageView.center.x = customView.center.x
            
            let label = UILabel(frame: CGRect(x: 0, y: 45, width: 80, height: 30))
            label.text = "Đổi giá"
            label.textAlignment = .center
            label.textColor = UIColor(hex: "34C759")
            
            customView.addSubview(imageView)
            customView.addSubview(label)
            
            // Create the swipe action using the custom view
            let cancelFood = UIContextualAction(style: .normal, title: "") { [weak self] (action, view, completionHandler) in
                self?.presentModalInputMoneyViewController(current_money: order_detail.retail_price, MaterialPriceList: order_detail)
                completionHandler(true)
            }
            cancelFood.backgroundColor = .UIColorFromRGB("DFEEE2")
            cancelFood.image = UIGraphicsImageRenderer(size: customView.bounds.size).image { _ in
                customView.drawHierarchy(in: customView.bounds, afterScreenUpdates: true)
            }
            
            // Configure the swipe action configuration
            let configuration = UISwipeActionsConfiguration(actions: [cancelFood])
            configuration.performsFirstActionWithFullSwipe = false
            
            return configuration
    }
}


extension PriceListDetailViewController: InputMoneyDelegatePriceList{
    func presentModalInputMoneyViewController(current_money: Int, MaterialPriceList: MaterialPriceList) {
            let dialogInputMoneyViewController = DialogInputMoneyViewController()
            dialogInputMoneyViewController.minMoney = 1000
            dialogInputMoneyViewController.maxMoney = 999999999
            dialogInputMoneyViewController.materialPriceList = MaterialPriceList
            dialogInputMoneyViewController.current_money = current_money
            dialogInputMoneyViewController.delegatePrice = self
            dialogInputMoneyViewController.view.backgroundColor = ColorUtils.blackTransparent()
            let nav = UINavigationController(rootViewController: dialogInputMoneyViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
            present(nav, animated: true, completion: nil)

        }
    

    func callbackInputPriceList(amount: Int, materialPriceList: MaterialPriceList) {
     
        viewModel.price_money_choose.accept(amount)
        self.viewModel.MaterialId.accept(materialPriceList.id)
        dismiss(animated: true)
        self.presentModalDialogAcceptPendingOrder(materialPriceList: materialPriceList)
    }
}
extension PriceListDetailViewController: ShowInputMoneyPriceListDelegate {
  
    func presentModalDialogAcceptPendingOrder(materialPriceList: MaterialPriceList) {
        
        let dialogConfirmUpdateManagementViewController = DialogAccessPriceListViewController()
        dialogConfirmUpdateManagementViewController.viewModel = self.viewModel
        dialogConfirmUpdateManagementViewController.materialPriceList = materialPriceList
        dialogConfirmUpdateManagementViewController.view.backgroundColor = ColorUtils.blackTransparent()
        
        
        let nav = UINavigationController(rootViewController: dialogConfirmUpdateManagementViewController)
        // 1
        nav.modalPresentationStyle = .overCurrentContext
        
        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4
        
        present(nav, animated: true, completion: nil)
    }
    
    
      func callbackShowInputPriceList() {
          dLog(viewModel.MaterialId.value)
          dismiss(animated: true)
          self.getUpdateMaterialPrice()
          self.getPriceListDetail()
      }
    
   
}



