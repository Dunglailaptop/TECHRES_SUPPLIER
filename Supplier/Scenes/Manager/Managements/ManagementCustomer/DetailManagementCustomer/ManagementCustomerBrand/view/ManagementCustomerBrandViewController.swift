//
//  ManagementCustomerBrandViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class ManagementCustomerBrandViewController: BaseViewController {

    var viewModel = ManagementCustomerBrandViewModel()
    var router = ManagementCustomerBrandRouter()
    
    var restaurantId = 0
    var page = 0
    var totalRecord = 0
    var lastPosition = false
    let spinner = UIActivityIndicatorView(style: .medium)
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var root_view_empty_data: UIView!
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var view_detail_branches: UIView!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var height_view: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        resgisterCell()
        bindTableView()
       
        txt_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       viewModel.clearData()
                       viewModel.key_search.accept(query!)
                      
                       self.getBrandCustomer()
                     
       }).disposed(by: rxbag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if restaurantId > 0 {
            height_view.constant = 0
            view_detail_branches.isHidden = true
            viewModel.restaurant_id.accept(restaurantId)
            viewModel.clearDataAndCallAPI()
        }
    }
    
    @IBAction func makepopToViewController(_ sender: Any) {
        viewModel.MakePopToViewController()
    }
}
