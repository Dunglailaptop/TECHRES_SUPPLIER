//
//  HistoryDayOffViewController.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 13/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class PriceListDetailViewController: BaseViewController {
    
    var viewModel = PriceListDetailViewModel()
    var router = PriceListDetailRouter()
    let FROM_DATE = "FROM_DATE"
    let TO_DATE = "TO_DATE"
    var supplier = Supplier()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var view_access: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_from_date: UILabel!
    
    @IBOutlet weak var lbl_to_date: UILabel!
    
    @IBOutlet weak var textfield_search: UITextField!
    @IBOutlet weak var view_empty_data: UIView!
    
    var listTypeOfFilterDialog = [String]()
    
    @IBOutlet weak var lbl_total_list: UILabel!
    @IBOutlet weak var btn_choose_status: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
//        firstSetup()
        registerCell()
        bindTableViewData()
        firstSetup()
      
    }
    
    private func firstSetup(){
        Utils.isHideAllView(isHide: true, view: self.view_empty_data)
        textfield_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(textfield_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       
                       let cloneDataFilter = viewModel.dataFilter.value
                       if !query!.isEmpty{
                           let filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                       }else{
                           viewModel.dataArray.accept(cloneDataFilter)
                       }
                       
        }).disposed(by: rxbag)
              
    
        
        
//        //setup filter option
//        listTypeOfFilterDialog.append("Tất cả")
//        listTypeOfFilterDialog.append("Đã Duyệt")
//        listTypeOfFilterDialog.append("Đã Từ chối")
   
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dLog(supplier.id)
        viewModel.DetailSupplier.accept(supplier)
        getPriceListDetail()
//        if (viewModel.dataArray.value.count > 0){
     
//        }
        
    }
    
    
    @IBAction func actionFilterStatus(_ sender: Any) {
//        self.showChooseType()
    }
    
    
    @IBAction func actionChooseDateFrom(_ sender: Any) {
//        viewModel.dateType.accept(FROM_DATE)
//        dLog(viewModel.to_date.value)
//        self.showDateTimePicker(dateTimeData:viewModel.from_date.value)
    }
    
    
    @IBAction func actionChooseDateTo(_ sender: Any) {
//        viewModel.dateType.accept(TO_DATE)
//        dLog(viewModel.to_date.value)
//        self.showDateTimePicker(dateTimeData:viewModel.to_date.value)
    }
    
    @IBAction func btnBackView(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func btn_cancel(_ sender: Any) {
        Utils.isHideAllView(isHide: true, view: view_access)
    }
    
    @IBAction func btn_access(_ sender: Any) {
        
    }
}
