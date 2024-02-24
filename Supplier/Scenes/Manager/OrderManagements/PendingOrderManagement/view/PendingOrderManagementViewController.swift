//
//  PendingOrderManagementViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class PendingOrderManagementViewController: BaseViewController {
    
    var viewModel = PendingOrderManagementViewModel()
    var router = PendingOrderManagementRouter()
    let formatter = DateFormatter()
    var type_choose_date: Int = 0
    
    let refreshControl = UIRefreshControl()
    var page = 1
    var lastPosition = false
    let spinner = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var view_search: UIView!
    
    @IBOutlet weak var root_view_empty_data: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
        
        registerCell()
        bindTableViewData()
        
        textfield_search.text = ""
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       
                       viewModel.clearData()
                       viewModel.key_search.accept(query!)
                       getSupplierOrdersRequestList()
                       
               }).disposed(by: rxbag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        viewModel.clearDataAndCallAPI()
    }
}
