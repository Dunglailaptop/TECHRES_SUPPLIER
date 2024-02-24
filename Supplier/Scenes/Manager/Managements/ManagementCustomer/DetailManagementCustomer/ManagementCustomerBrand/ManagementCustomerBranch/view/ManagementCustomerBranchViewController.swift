//
//  ManagementCustomerBranchViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay

class ManagementCustomerBranchViewController: BaseViewController {

    var viewModel = ManagementCustomerBranchViewModel()
    var router = ManagementCustomerBranchRouter()
    var brandRestaurantInfo = Brand()
    var page = 0
    var totalRecord = 0
    var lastPosition = false
    let spinner = UIActivityIndicatorView(style: .medium)
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var image_brand_logo: UIImageView!
    @IBOutlet weak var lbl_brand_name: UILabel!
    @IBOutlet weak var lbl_brand_phone: UILabel!
    
    @IBOutlet weak var root_view_empty_data: UIView!
    
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
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
                               
                               self.getBranchCustomer()
                             
                       }).disposed(by: rxbag)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if brandRestaurantInfo != nil {
            viewModel.clearData()
            viewModel.restaurant_id.accept(brandRestaurantInfo.restaurant_id)
            viewModel.restaurant_brand_id.accept(brandRestaurantInfo.id)
            setup()
        }
        getBranchCustomer()
    }

    func setup() {
        lbl_brand_name.text = Utils().capitalizeString(inputString: brandRestaurantInfo.name)
        lbl_brand_phone.text = brandRestaurantInfo.phone
        image_brand_logo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: brandRestaurantInfo.logo_url)), placeholder: UIImage(named: "icon-logo-gray"))
    }

    @IBAction func btn_makePopToViewController(_ sender: Any) {
        viewModel.MakePopToViewController()
    }
    
    @IBAction func actionChooseBrand(_ sender: Any) {
        showPopupFilter()
    }
}
