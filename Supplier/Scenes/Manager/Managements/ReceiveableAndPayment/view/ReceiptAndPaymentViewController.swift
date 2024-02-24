//
//  ReportDayOffViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
class ReceiptAndPaymentViewController: BaseViewController {
    var viewModel = ReceiptAndPaymentViewModel()
    var router = ReceiptAndPaymentRouter()
    let refreshControl = UIRefreshControl()
    var searchBarSwitch:Bool = false
    //-----IBOutlet of header

    @IBOutlet weak var btn_get_receipt_data: UIButton!
    @IBOutlet weak var btn_get_payment_data: UIButton!
    @IBOutlet weak var btn_get_category_data: UIButton!
    
    
    
    //-----IBOutlet of sub-header
    @IBOutlet weak var lbl_waiting_hint: UILabel!
    @IBOutlet weak var lbl_completed_hint: UILabel!
    @IBOutlet weak var lbl_cancel_hint: UILabel!
    @IBOutlet weak var lbl_waiting: UILabel!
    @IBOutlet weak var lbl_completed: UILabel!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var waiting_bottomLine: UILabel!
    @IBOutlet weak var completed_bottomLine: UILabel!
    @IBOutlet weak var cancel_bottomLine: UILabel!
    
    
    //-----IBOutlet of utility-bar
    @IBOutlet weak var utility_bar_view: UIView!
    @IBOutlet weak var search_view: UIView!
    @IBOutlet weak var choose_date_view: UIView!
    @IBOutlet weak var lbl_from_date: UILabel!
    @IBOutlet weak var lbl_to_date: UILabel!
    @IBOutlet weak var text_field_search: UITextField!
    
    //-----IBOutlet of tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view_empty_data: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        firstSetup()
        registerCell()
        bindTableViewData()
        
        lbl_waiting_hint.isHidden = true
        lbl_completed_hint.isHidden = true
        lbl_cancel_hint.isHidden = true
        
    }
    
    private func firstSetup(){
        view_empty_data.isHidden = true
        
        lbl_from_date.text = viewModel.from_date.value

        lbl_to_date.text = viewModel.to_date.value
    
        search_view.isHidden = true
        
    
        self.text_field_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(text_field_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       viewModel.key_search.accept(query!)
                       viewModel.clearDataAndCallAPI()
        }).disposed(by: rxbag)
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /*
            type = 0 -> phiếu thu
            type = 1 -> phiếu chi
         */
        viewModel.type.value == 1 ? actionToGetPaymentList("") : actionToGetReceiptList("")
        
    }
    
    @IBAction func actionNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionCreateReceiptPayment(_ sender: Any) {
        viewModel.makeCreateReceiptAndPaymentViewController()
    }
    
    //--------ACTION OF GET RECEIPT-PAYMENT-CATEGORY DATA
    /*
        type = 0 -> phiếu thu
        type = 1 -> phiếu chi
     */
    @IBAction func actionToGetReceiptList(_ sender: Any) {
        changeHeader(btn: btn_get_receipt_data)
        viewModel.type.accept(0)

        /*
            status = 1 -> đang chờ xử lý
            status = 2 -> đã hoàn thành
            status = 3 -> đã huỷ
         */
        switch viewModel.status.value{
            case 1:
                actionToGetWaitingData("")
                break
            case 2:
                actionToGetCompletedData("")
                break
            case 3:
                actionToGetCanCelData("")
                break
            default:
                actionToGetWaitingData("")
                break
        }

    }
    
    @IBAction func actionToGetPaymentList(_ sender: Any) {
        changeHeader(btn: btn_get_payment_data)
        viewModel.type.accept(1)
        
        /*
            status = 1 -> đang chờ xử lý
            status = 2 -> đã hoàn thành
            status = 3 -> đã huỷ
         */
        switch viewModel.status.value{
            case 1:
                actionToGetWaitingData("")
                break
            case 2:
                actionToGetCompletedData("")
                break
            case 3:
                actionToGetCanCelData("")
                break
            default:
                actionToGetCompletedData("")
                break
        }

    }
    
    @IBAction func actionToGetCategory(_ sender: Any) {
        changeHeader(btn: btn_get_category_data)
        viewModel.makeReceiptAndPaymentCatetoryViewController()
    }
    
    //--------ACTION OF GET WAITING-COMPLETE-CANCEL DATA
    /*
        status = 1 -> đang chờ xử lý
        status = 2 -> đã hoàn thành
        status = 3 -> đã huỷ
     */
    @IBAction func actionToGetWaitingData(_ sender: Any) {
        changeSubHeader(bottomLine: waiting_bottomLine, label: lbl_waiting,labelHint: lbl_waiting_hint)
        viewModel.status.accept(1)
        viewModel.clearDataAndCallAPI()
    }
    
    @IBAction func actionToGetCompletedData(_ sender: Any) {
        changeSubHeader(bottomLine: completed_bottomLine, label: lbl_completed,labelHint: lbl_completed_hint)
        viewModel.status.accept(2)
        viewModel.clearDataAndCallAPI()
    }
    
    @IBAction func actionToGetCanCelData(_ sender: Any) {
        changeSubHeader(bottomLine: cancel_bottomLine, label: lbl_cancel,labelHint: lbl_cancel_hint)
        viewModel.status.accept(3)
        viewModel.clearDataAndCallAPI()
    }
    
    
    
    //-----------ACTION OF UTILITY BAR----
    
    @IBAction func actionShowSearchBar(_ sender: Any) {
        UIView.animate(withDuration: 0.5, delay: 0,usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveLinear, animations: { [self] in
            searchBarSwitch = !searchBarSwitch
            choose_date_view.isHidden = searchBarSwitch ? true : false
            search_view.isHidden = searchBarSwitch ? false : true
            NSLayoutConstraint(
            item: search_view,
            attribute: .width,
            relatedBy: .equal,
            toItem: utility_bar_view,
            attribute: .width,
            multiplier: searchBarSwitch ? 0.9 : 0.05,
            constant: 0).isActive = true
            self.view.layoutIfNeeded()
        })
    }
    
    
    @IBAction func actionChoseFromDate(_ sender: Any) {
        viewModel.dateType.accept(1)
        showDateTimePicker(dateTimeData: lbl_from_date.text ?? Utils.getCurrentDateString())
    }
    
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        viewModel.dateType.accept(2)
        showDateTimePicker(dateTimeData: lbl_to_date.text ?? Utils.getCurrentDateString())
    }
    
    
    private func changeSubHeader(bottomLine:UILabel, label:UILabel,labelHint:UILabel){
        waiting_bottomLine.backgroundColor = .white
        completed_bottomLine.backgroundColor = .white
        cancel_bottomLine.backgroundColor = .white
        lbl_waiting.textColor = ColorUtils.gray_600()
        lbl_completed.textColor = ColorUtils.gray_600()
        lbl_cancel.textColor = ColorUtils.gray_600()
        lbl_cancel_hint.backgroundColor = ColorUtils.gray_400()
        lbl_waiting_hint.backgroundColor = ColorUtils.gray_400()
        lbl_completed_hint.backgroundColor = ColorUtils.gray_400()
        labelHint.backgroundColor = ColorUtils.orange_700()
        label.textColor = ColorUtils.blue_700()
        bottomLine.backgroundColor = ColorUtils.blue_700()
        bottomLine.roundCorners([.topLeft,.topRight], radius: 8)
    }
    
   
    private func changeHeader(btn:UIButton){
        btn_get_payment_data.backgroundColor = ColorUtils.gray_200()
        btn_get_receipt_data.backgroundColor = ColorUtils.gray_200()
        btn_get_category_data.backgroundColor = ColorUtils.gray_200()
        btn_get_payment_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        btn_get_receipt_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        btn_get_category_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        
        btn.backgroundColor = ColorUtils.blue_000()
        btn.setTitleColor(ColorUtils.blue_700(),for: .normal)
    }
    
}
