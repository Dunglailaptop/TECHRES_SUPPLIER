//
//  PaymentBillDebtViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
class AccountsPayableViewController: BaseViewController {

    var viewModel = AccountsPayableViewModel()
    var router = AccountsPayableRouter()
    let refreshControl = UIRefreshControl()

    var checkAll:Bool = false
    
  
    @IBOutlet weak var width_view_search: NSLayoutConstraint!
    @IBOutlet weak var width_button_search: NSLayoutConstraint!
   
    @IBOutlet weak var view_choose_date: UIView!
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_from_date: UILabel!
    
    @IBOutlet weak var btn_button_close_search: UIButton!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var lbl_to_date: UILabel!
    @IBOutlet weak var btnCheckAll: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_total_payment: UILabel!
    
    @IBOutlet weak var no_data_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
        width_view_search.constant = 0
        getReceiptAndPaymenCategory()
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       var datas = viewModel.warehouseReceiptList.value
                       if viewModel.warehouseReceiptListHisory.value.count == 0{
                           viewModel.warehouseReceiptListHisory.accept(datas)
                       }
//                       if query!.isEmpty {
//                           btn_button_close_search.isHidden = false
//                       }else {
//                           btn_button_close_search.isHidden = true
//                       }
                       var data = viewModel.search.value
                       data.key_search = query!
                       viewModel.search.accept(data)
                       viewModel.clearDataAndCallAPI()
                       
               }).disposed(by: rxbag)
     
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.clearDataAndCallAPI()
        lbl_to_date.text = viewModel.search.value.to_date
        lbl_from_date.text = viewModel.search.value.from_date
    }
    
    @IBAction func actionCheckAll(_ sender: UIButton) {
        checkAll = !checkAll
        btnCheckAll.setImage(UIImage(named: checkAll ? "icon-check-blue" : "icon-uncheck-blue"), for: .normal)
        
        var warehouseReceiptList = viewModel.warehouseReceiptList.value
        warehouseReceiptList.enumerated().forEach { (index, value) in
            warehouseReceiptList[index].isSelected = checkAll ? ACTIVE : DEACTIVE
        }
        
        var warehouseReceiptListSearch = viewModel.warehouseReceiptListHisory.value
        warehouseReceiptListSearch.enumerated().forEach { (index, value) in
            warehouseReceiptListSearch[index].isSelected = checkAll ? ACTIVE : DEACTIVE
        }
        
        lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount:warehouseReceiptList.filter{$0.isSelected == ACTIVE}.map{$0.total_amount}.reduce(0, +))
        viewModel.warehouseReceiptList.accept(warehouseReceiptList)
        viewModel.warehouseReceiptListHisory.accept(warehouseReceiptListSearch)

    }
    
    @IBAction func actionCreateSupplierWarehouse(_ sender: Any) {
       if viewModel.warehouseReceiptList.value.filter{$0.isSelected == ACTIVE}.count > 0 {self.presentModalDialogAcceptSupplierWarehouse()}
    }
    
    
    
    @IBAction func actionChooseFromDate(_ sender: Any) {
        var searchUtility = viewModel.search.value
        searchUtility.dateType = 1
        viewModel.search.accept(searchUtility)
        showDateTimePicker(dateTimeData: viewModel.search.value.from_date)
    }
    
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        var searchUtility = viewModel.search.value
        searchUtility.dateType = 2
        viewModel.search.accept(searchUtility)
        showDateTimePicker(dateTimeData: viewModel.search.value.to_date)
    }
    
    
    @IBAction func btn_showtextsearch(_ sender: Any) {
        Utils.isHideAllView(isHide: true, view: view_choose_date)
        Utils.isHideAllView(isHide: false, view: view_search)
        width_view_search.constant = 350
        
       
    }
    
    @IBAction func btn_closetextsearch(_ sender: Any) {
        Utils.isHideAllView(isHide: false, view: view_choose_date)
            Utils.isHideAllView(isHide: true, view: view_search)
            width_view_search.constant = 0
          
         
       
     
    }
}
