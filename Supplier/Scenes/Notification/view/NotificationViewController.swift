//
//  NotificationViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class NotificationViewController: BaseViewController {
    var viewModel = NotificationViewModel()
    var router = NotificationViewRouter()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
        
        registerCell()
        bindTableViewData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.type.accept(ACTIVE)
        viewModel.page.accept(page)
        viewModel.dataArray.accept([])
        
        self.notifications()
    }
}
