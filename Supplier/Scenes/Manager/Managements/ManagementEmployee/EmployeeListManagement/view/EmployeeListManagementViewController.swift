//
//  EmployeeListManagementViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay


class EmployeeListManagementViewController: BaseViewController {
    
    var viewModel = EmployeeListManagementViewModel()
    var router = EmployeeListManagementRouter()
    
    let refreshControl = UIRefreshControl()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var root_view_empty_data: UIView!
    var timer: Timer?
   
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
//        viewModel.clearData()
        registerCell()
        bindTableViewData()
       

        
        textfield_search.rx.controlEvent(.editingChanged)
                           .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                           .withLatestFrom(textfield_search.rx.text)
                           .subscribe(onNext:{ [self] query in
                               
                             
                               viewModel.key_search.accept(query!)
                               viewModel.clearDataAndCallAPI()
                               
                       }).disposed(by: rxbag)
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.clearDataAndCallAPI()
    }


    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func btn_create_employee(_ sender: Any) {
        viewModel.makeDetailEmployeeViewController(isAllowEditing: true)
    }
}
