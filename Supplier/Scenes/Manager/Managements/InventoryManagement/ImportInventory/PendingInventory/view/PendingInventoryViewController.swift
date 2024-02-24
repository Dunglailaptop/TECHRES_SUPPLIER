//
//  PendingInventoryViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 15/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class PendingInventoryViewController: BaseViewController {

    var viewModel = PendingInventoryViewModel()
    var router = PendingInventoryRouter()
    
    
    let refreshControl = UIRefreshControl()
    var type_choose_date: Int = 0
    var restaurant_id: Int = 0

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var lbl_from_date: UILabel!
    @IBOutlet weak var lbl_to_date: UILabel!
    @IBOutlet weak var view_choose_date: UIView!
    @IBOutlet weak var view_search: UIView!
    @IBOutlet weak var root_view_empty_data: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.bind(view: self, router: router)
        
        viewModel.from_date.accept("01/" + Utils.getCurrentMonthYearString())
        viewModel.to_date.accept(Utils.getCurrentDateString())
        
        registerCell()
        bindTableViewData()
        
        lbl_from_date.text = "01/" + Utils.getCurrentMonthYearString()
        lbl_to_date.text = Utils.getCurrentDateString()

        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       
                       viewModel.key_search.accept(query!)
                       getSupplierWarehouseSessions()
                       
               }).disposed(by: rxbag)
        textfield_search.text = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        getSupplierWarehouseSessions()
    }
    
    @IBAction func actionChooseFromDate(_ sender: Any) {
        self.type_choose_date = 0
        self.showDateTimePicker(dataDateTime : lbl_from_date.text!)
    }
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        self.type_choose_date = 1
        self.showDateTimePicker(dataDateTime : lbl_to_date.text!)
    }
    
    @IBAction func actionShowViewSearch(_ sender: Any) {
        Utils.isHideAllView(isHide: true, view: view_choose_date)
        Utils.isHideAllView(isHide: false, view: view_search)
    }
    
    @IBAction func actionHideViewSearch(_ sender: Any) {
        Utils.isHideAllView(isHide: true, view: view_search)
        Utils.isHideAllView(isHide: false, view: view_choose_date)
    }
}
