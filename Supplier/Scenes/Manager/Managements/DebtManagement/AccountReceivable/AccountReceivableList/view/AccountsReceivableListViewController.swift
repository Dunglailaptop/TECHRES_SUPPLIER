//
//  ListReceiptBillDebtViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import MarqueeLabel
class AccountsReceivableListViewController: BaseViewController {
    var from_date:String = "01/" + Utils.getCurrentMonthYearString()
    var to_date:String = Utils.getCurrentDateString()
    var restaurant:RestaurantWithReceipt = RestaurantWithReceipt()
    var viewModel = AccountsReceivableListViewModel()
    var router = AccountsReceivableListRouter()
    
    
    var type_choose_date = 0
    let refreshControl = UIRefreshControl()
    var page = 1
    var totalRecord = 0
    let spinner = UIActivityIndicatorView(style: .medium)
    var checkAll:Bool = false
    
    @IBOutlet weak var restaurant_avatar: UIImageView!
    @IBOutlet weak var lbl_restaurant_name: MarqueeLabel!

    @IBOutlet weak var lbl_brand_name: MarqueeLabel!
    
    @IBOutlet weak var lbl_branch_name: MarqueeLabel!
   
    @IBOutlet weak var Height_view_txt_search: NSLayoutConstraint!
    @IBOutlet weak var Height_view_icon_search: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var lbl_from_date: UILabel!
    @IBOutlet weak var lbl_to_date: UILabel!
    @IBOutlet weak var view_choose_date: UIView!
    @IBOutlet weak var view_search: UIView!
    
    @IBOutlet weak var lbl_total_debt: UILabel!
    @IBOutlet weak var btnCheckAll: UIButton!
    @IBOutlet weak var root_view_empty_data: UIView!
    
    @IBOutlet weak var view_button_close_search: UIView!
    @IBOutlet weak var lbl_total_payment: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        viewModel.from_date.accept(from_date)
        viewModel.to_date.accept(to_date)
        viewModel.restaurant.accept(restaurant)
        firstSetup()
        registerCell()
        bindTableViewData()
   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    private func firstSetup(){
        Height_view_txt_search.constant = 0
        actionChooseRestaurant("")

        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self] query in
                       var data = viewModel.dataArray.value
                       if viewModel.dataArraySearch.value.count == 0 {
                           viewModel.dataArraySearch.accept(data)
                       }
//                       if query!.isEmpty {
//                           view_button_close_search.isHidden = false
//                       } else {
//                           view_button_close_search.isHidden = true
//                       }
                       viewModel.key_search.accept(query!)
                       viewModel.clearDataAndCallAPI()
        }).disposed(by: rxbag)
        
        var avatarLink = Utils.getFullMediaLink(string:  viewModel.restaurant.value.restaurant_logo)
        restaurant_avatar.kf.setImage(with: URL(string:avatarLink),placeholder: UIImage(named: "image_default_logo"))
        
        lbl_restaurant_name.text = viewModel.restaurant.value.restaurant_name
        lbl_from_date.text = viewModel.from_date.value
        lbl_to_date.text = viewModel.to_date.value
 
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionChooseRestaurant(_ sender: Any) {
        showPopup()
    }
    
    @IBAction func actionChooseFromDate(_ sender: Any) {
        self.type_choose_date = 0
        self.showDateTimePicker(dataDateTime : lbl_from_date.text!)
    }
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        self.type_choose_date = 1
        self.showDateTimePicker(dataDateTime : lbl_to_date.text!)
    }
    
    @IBAction func actionSendPaymentRequest(_ sender: Any) {
        viewModel.makeCreatePaymentRequestViewController()
    }
    
    @IBAction func actionShowViewSearch(_ sender: Any) {
        Utils.isHideAllView(isHide: true, view: view_choose_date)
        Utils.isHideAllView(isHide: false, view: view_search)
        Height_view_txt_search.constant = 350
        
    }
    
    @IBAction func actionHideViewSearch(_ sender: Any) {
           Utils.isHideAllView(isHide: false, view: view_choose_date)
            Utils.isHideAllView(isHide: true, view: view_search)
        Height_view_txt_search.constant = 0
      
     
    }
    
    @IBAction func actionCheckAll(_ sender: UIButton) {
        checkAll = !checkAll
        btnCheckAll.setImage(UIImage(named: checkAll ? "icon-check-blue" : "icon-uncheck-blue"), for: .normal)
        var dataCheckAllArray = self.viewModel.dataArray.value
        var dataSearch = self.viewModel.dataArraySearch.value
        checkAll ?
        dataCheckAllArray.enumerated().forEach { (index, value) in
            dataCheckAllArray[index].isSelected = ACTIVE
        }
        :
        dataCheckAllArray.enumerated().forEach { (index, value) in
            dataCheckAllArray[index].isSelected = DEACTIVE
        }
        if viewModel.dataArraySearch.value.count > 0 {
            btnCheckAll.setImage(UIImage(named: !checkAll ? "icon-check-blue" : "icon-uncheck-blue"), for: .normal)
            !checkAll ?
            dataSearch.enumerated().forEach { (index, value) in
                dataSearch[index].isSelected = ACTIVE
            }
            :
            dataSearch.enumerated().forEach { (index, value) in
                dataSearch[index].isSelected = DEACTIVE
            }
            self.viewModel.dataArray.accept(dataSearch)
        }else {
            self.viewModel.dataArray.accept(dataCheckAllArray)
        }
      

       
        self.viewModel.dataArraySearch.accept(dataSearch)

        lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumber(amount:
            viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}
            .flatMap{$0.restaurant_debt_amount}.reduce(0){$0 + $1})
    }
}
