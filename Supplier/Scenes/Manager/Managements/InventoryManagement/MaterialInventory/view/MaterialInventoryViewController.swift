//
//  MaterialInventoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import RxSwift

class MaterialInventoryViewController: BaseViewController {
    
    var viewModel = MaterialInventoryViewModel()
    var router = MaterialInventoryRouter()
    
    let refreshControl = UIRefreshControl()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    var checkAll:Bool = false
    var requestSupplierMarerialDelegate: SupplierRequestMaterialDelegate?
    var dataSelectedMaterial = [MaterialWarehouseSessions]()
    var dataSelected = [Material]()
    var material_selected = [Material]()
    
    @IBOutlet weak var btnCheckAll: UIButton!
    @IBOutlet weak var icon_check_all: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var root_view_empty_data: UIView!
    @IBOutlet weak var lbl_total_quantity: UILabel!
    @IBOutlet weak var textfield_search: UITextField!
    
    @IBOutlet weak var root_view: UIView!
    @IBOutlet weak var view_header: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 10)
        view_header.round(with: .top, radius: 10)
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
        
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
                       lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: viewModel.dataArray.value.count)
                       self.viewModel.dataArray.isCollectionEmpty(isHide: true, view: self.root_view_empty_data)
               }).disposed(by: rxbag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getItemList()
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
        self.viewModel.dataArray.accept(dataCheckAllArray)
        self.viewModel.dataFilter.accept(dataCheckAllFilter)
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        let dataFilter = viewModel.dataFilter.value.filter{$0.isSelected == ACTIVE}
        var materialRequest = viewModel.material_request.value
        
        if (dataFilter.count == 0){
            JonAlert.show(message: "Vui lòng chọn nguyên liệu trước khi lưu", andIcon: UIImage(named: "icon-cancel"), duration: 2.5)
        } else {
            dataFilter.enumerated().forEach{( index, value ) in
                var item = Material()
                item.id = value.id
                item.name = value.name
                item.material_unit_name = value.material_unit_name
                item.remain_quantity = value.remain_quantity
                item.total_import_quantity = value.total_import_quantity
                item.total_quantity_from_order = value.total_quantity_from_order
                item.price = value.price
                item.total_amount_from_quantity_import = value.total_amount_from_quantity_import
                materialRequest.append(item)
            }
            self.requestSupplierMarerialDelegate?.callBackToAcceptRequestSupplierMaterial(dataMaterial: materialRequest)
            self.dismiss(animated: true)
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
