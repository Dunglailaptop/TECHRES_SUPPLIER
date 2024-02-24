//
//  PaymentRequestViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
class PaymentRequestViewController: BaseViewController {
    var viewModel = PaymentRequestViewModel()
    var router = PaymentRequestRouter()
    let refreshControl = UIRefreshControl()
    var turnOnSearchBar:Bool = false
    
    @IBOutlet weak var btn_get_waiting_data: UIButton!
    @IBOutlet weak var btn_get_completed_data: UIButton!
    @IBOutlet weak var btn_get_cancel_data: UIButton!
    
    
    @IBOutlet weak var choose_date_view: UIView!
    @IBOutlet weak var search_view: UIView!
    
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var utility_bar_view: UIView!
    
    
    @IBOutlet weak var lbl_from_date: UILabel!
    @IBOutlet weak var lbl_to_date: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var no_data_view: UIView!
    var btn_array:[UIButton] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        btn_array = [btn_get_waiting_data,btn_get_completed_data,btn_get_cancel_data]
        firstSetup()
    }
    
    private func firstSetup(){
        no_data_view.isHidden = true
        registerCell()
        bindTableViewData()
    
        actionGetWaitingData("")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.clearDataAndCallAPI()
        lbl_to_date.text = viewModel.APIParameter.value.to_date
        lbl_from_date.text = viewModel.APIParameter.value.from_date
        self.text_field_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(text_field_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       var APIParameter = viewModel.APIParameter.value
                       APIParameter.key_search = query ?? ""
                       viewModel.APIParameter.accept(APIParameter)
                       viewModel.clearDataAndCallAPI()
        }).disposed(by: rxbag)
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func actionGetWaitingData(_ sender: Any) {
        changeHeader(btn: btn_get_waiting_data)
        viewModel.status.accept(1)
//        mapData(data: viewModel.fullDataArray.value)
        viewModel.clearDataAndCallAPI()
    }
    
    @IBAction func actionGetCompletedData(_ sender: Any) {
        changeHeader(btn: btn_get_completed_data)
        viewModel.status.accept(2)
//        mapData(data: viewModel.fullDataArray.value)
        viewModel.clearDataAndCallAPI()
    }
    
    
    @IBAction func actionGetCancelData(_ sender: Any) {
        changeHeader(btn: btn_get_cancel_data)
        viewModel.status.accept(0)
//        mapData(data: viewModel.fullDataArray.value)
        viewModel.clearDataAndCallAPI()
    }
    
    
    @IBAction func actionShowSearchBar(_ sender: Any) {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            turnOnSearchBar = !turnOnSearchBar

            if(turnOnSearchBar){
                
                choose_date_view.isHidden = true
                NSLayoutConstraint(
                item: choose_date_view,
                attribute: .width,
                relatedBy: .equal,
                toItem: utility_bar_view,
                attribute: .width,
                multiplier: 0.05,
                constant: 0).isActive = true
                self.view.layoutIfNeeded()
                
                
                search_view.isHidden = false
                NSLayoutConstraint(
                item: search_view,
                attribute: .width,
                relatedBy: .equal,
                toItem: utility_bar_view,
                attribute: .width,
                multiplier: 0.9,
                constant: 0).isActive = true
                self.view.layoutIfNeeded()
                
                
            }else{
                search_view.isHidden = true
                NSLayoutConstraint(
                item: search_view,
                attribute: .width,
                relatedBy: .equal,
                toItem: utility_bar_view,
                attribute: .width,
                multiplier: 0.05,
                constant: 0).isActive = true
                self.view.layoutIfNeeded()
                
                choose_date_view.isHidden = false
                NSLayoutConstraint(
                item: choose_date_view,
                attribute: .width,
                relatedBy: .equal,
                toItem: utility_bar_view,
                attribute: .width,
                multiplier: 0.9,
                constant: 0).isActive = true
                self.view.layoutIfNeeded()
            }
            
        })
    }
    
    @IBAction func actionChooseFromDate(_ sender: Any) {
        viewModel.dateType.accept(1)
        showDateTimePicker(dateTimeData: lbl_from_date.text!)
    }
    
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        viewModel.dateType.accept(2)
        showDateTimePicker(dateTimeData: lbl_to_date.text!)
    }
    
    @IBAction func actionDialogFilter(_ sender: Any) {
        self.presentModalDialogFilterRestaurantBranch()
    }
    
    @IBAction func actionNavigateToCreatePaymentRequestViewController(_ sender: Any) {
        viewModel.makeCreatePaymentRequestViewController()
    }
    
     private func changeHeader(btn:UIButton){
         btn_array.forEach{
             $0.backgroundColor = ColorUtils.gray_200()
             $0.setTitleColor(ColorUtils.gray_600(),for: .normal)
         }
         btn.backgroundColor = ColorUtils.blue_000()
         btn.setTitleColor(ColorUtils.blue_700(),for: .normal)
     }
}
