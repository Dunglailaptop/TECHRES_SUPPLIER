//
//  TotalAmountOrderManagementViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import RxSwift

class TotalAmountOrderManagementViewController: BaseViewController {

    var viewModel = TotalAmountOrderManagementViewModel()
    var router = TotalAmountOrderManagementRouter()
    
    let refreshControl = UIRefreshControl()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    var checkAll:Bool = false
    var isCheckSpam:Bool = false
    var material_selected = [Material]()
    
    @IBOutlet weak var btnCheckAll: UIButton!
    @IBOutlet weak var icon_check_all: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var root_view_empty_data: UIView!
    @IBOutlet weak var lbl_total_quantity: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var textfield_search: UITextField!
    
    // Variable of button
    @IBOutlet weak var view_btn: UIView!
    @IBOutlet weak var lbl_btn: UILabel!
    @IBOutlet weak var icon_btn: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        
        registerCell()
        bindTableViewData()
        getItemList()
        
        textfield_search.rx.text
            .orEmpty // convert to non-optional string
            .map { $0.prefix(255) } // limit to max length
            .subscribe(onNext: { [weak self] newText in
                self?.textfield_search.text = String(newText)
            })
            .disposed(by: rxbag)
        
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       
                       let dataSearch = self.viewModel.dataFilter.value
                       if !query!.isEmpty {
                           let filterData = dataSearch.filter({
                              (value) -> Bool in
                              let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                              let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                              return str2.contains(str1)
                           })
                           self.viewModel.dataArray.accept(filterData)
                           lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: filterData.count)
                       }else{
                           self.viewModel.dataArray.accept(dataSearch)
                           lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataSearch.count)
                       }
                       self.viewModel.dataArray.isCollectionEmpty(isHide: true, view: self.root_view_empty_data)
               }).disposed(by: rxbag)
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.notificationMaterial),
            name: NSNotification.Name("backCreateInventory"),
            object: nil)
    }
    
    @objc private func notificationMaterial(notification: NSNotification){
        var dataCheckAllArray = self.viewModel.dataArray.value
        var dataCheckAllFilter = self.viewModel.dataFilter.value
        dataCheckAllArray.enumerated().forEach { (index, value) in
            dataCheckAllArray[index].isSelected = DEACTIVE
        }
        dataCheckAllFilter.enumerated().forEach { (index, value) in
            dataCheckAllFilter[index].isSelected = DEACTIVE
        }
        lbl_total_amount.text = "0"
        self.viewModel.dataArray.accept(dataCheckAllArray)
        self.viewModel.dataFilter.accept(dataCheckAllFilter)
        self.viewModel.selectedDataArray.accept(dataCheckAllArray)
        material_selected = dataCheckAllFilter
        icon_check_all.image = UIImage(named: "icon-uncheck-blue")
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    }
    
    @IBAction func actionCheckAll(_ sender: UIButton) {
        var dataCheckAllArray = self.viewModel.dataArray.value
        var dataCheckAllFilter = self.viewModel.dataFilter.value
        var totalAmount = 0
        if(checkAll == false){
            dataCheckAllArray.enumerated().forEach { (index, value) in
                dataCheckAllArray[index].isSelected = ACTIVE
                totalAmount += dataCheckAllArray[index].total_amount_from_quantity_import
            }
            dataCheckAllFilter.enumerated().forEach { (index, value) in
                dataCheckAllFilter[index].isSelected = ACTIVE
            }
            icon_check_all.image = UIImage(named: "icon-check-blue")
            checkAll = true
        }else{
            dataCheckAllArray.enumerated().forEach { (index, value) in
                dataCheckAllArray[index].isSelected = DEACTIVE
            }
            dataCheckAllFilter.enumerated().forEach { (index, value) in
                dataCheckAllFilter[index].isSelected = DEACTIVE
            }
            icon_check_all.image = UIImage(named: "icon-uncheck-blue")
            checkAll = false
        }
        material_selected = dataCheckAllFilter
        let selectedItems = dataCheckAllArray.filter{ $0.isSelected == ACTIVE }
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: totalAmount)
        self.viewModel.dataArray.accept(dataCheckAllArray)
        self.viewModel.dataFilter.accept(dataCheckAllFilter)
        self.viewModel.selectedDataArray.accept(selectedItems)
    }
    
    @IBAction func actionCreateSupplierWarehouse(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
            }
        if viewModel.dataFilter.value.filter({$0.isSelected == ACTIVE}).count == 0 {
            JonAlert.show(message: "Vui lòng chọn ít nhất 1 mặt hàng", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        }else{
            self.viewModel.makeCreateInventoryViewController(dataArrayMaterial: viewModel.dataFilter.value.filter{ $0.isSelected == ACTIVE })
        }
    }
}
