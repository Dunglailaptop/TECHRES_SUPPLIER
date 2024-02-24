//
//  ReceiptBillDebtViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class AccountsReceivableViewController: BaseViewController {
    
    var viewModel = AccountsReceivableViewModel()
    var router = AccountsReceivableRouter()
    
    var type_choose_date = 0
    let refreshControl = UIRefreshControl()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_total_debt: UILabel!
    
    @IBOutlet weak var textfield_search: UITextField!
   
    @IBOutlet weak var view_search: UIView!
    
  
    @IBOutlet weak var root_view_empty_data: UIView!
 
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
    
        registerCell()
        bindTableViewData()
    
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
//                       if query!.isEmpty{
//                           btn_show_view_search.isHidden = false
//                       }else {
//                           btn_show_view_search.isHidden = true
//                       }
                       viewModel.key_search.accept(query!)
                       viewModel.clearDataAndCallAPI()
        }).disposed(by: rxbag)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        viewModel.clearDataAndCallAPI()
    

    }
    
 
    
 
    
  
}
