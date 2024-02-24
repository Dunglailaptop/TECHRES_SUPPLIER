//
//  ManagementCustomerViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class ManagementCustomerViewController: BaseViewController {

    @IBOutlet weak var tableview: UITableView!
    var viewModel = ManagementCustomerViewModel()
    var router = ManagementCustomerRouter()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    let refreshControl = UIRefreshControl()
    var lastPosition = false
    
    @IBOutlet weak var root_view_empty_data: UIView!
    
    @IBOutlet weak var txt_search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindingTableViewCell()
     
        txt_search.rx.controlEvent(.editingChanged)
                           .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                           .withLatestFrom(txt_search.rx.text)
                           .subscribe(onNext:{ [self] query in
                               viewModel.clearData()
                               viewModel.key_search.accept(query!)
                               getRestaurant()
                             
                       }).disposed(by: rxbag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.clearDataAndCallAPI()
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.makePopToViewController()
    }
}
