//
//  DebtReportTableViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxRelay
import RxCocoa
import RxSwift
import JonAlert

class DebtReportTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    
    @IBOutlet weak var view_nodata_2: UIView!
    
    @IBOutlet weak var view_nodata_1: UIView!
    
    @IBOutlet weak var lbl_fromDate: UILabel!
    @IBOutlet weak var lbl_ToDate: UILabel!
    var type_choose_date: Int = 0
    var viewModel = DebtReportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       resgisterCell()
        bindTableView()
        setup()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 
    }
   
    
    func setup() {

        lbl_ToDate.text = Utils.getCurrentDateString()
        lbl_fromDate.text = Utils.getCurrentDateString()
        // accept get list supplier ware house seasions
        viewModel.fromDate.accept(Utils.getCurrentDateString())
        viewModel.toDate.accept(Utils.getCurrentDateString())
        getSupplierDebtPayment()
    }
    
    @IBAction func btn_actionChooseFromDate(_ sender: Any) {
        type_choose_date = 0
        showDateTimePicker(dataDateTime: lbl_fromDate.text!)
    }
    
    @IBAction func btn_actionChooseToDate(_ sender: Any) {
        type_choose_date = 1
        showDateTimePicker(dataDateTime: lbl_ToDate.text!)
    }
    
}

extension DebtReportTableViewController{
    func resgisterCell() {
        let DebtTableItemTableViewCell = UINib(nibName: "DebtTableItemTableViewCell", bundle: .main)
        tableView.register(DebtTableItemTableViewCell, forCellReuseIdentifier: "DebtTableItemTableViewCell")
        let DebtExportTableViewCell = UINib(nibName: "DebtExportTableViewCell", bundle: .main)
        tableView2.register(DebtExportTableViewCell, forCellReuseIdentifier: "DebtExportTableViewCell")
        
        
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView2.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView2.rx.setDelegate(self).disposed(by: rxbag)
   
      
    }
    func bindTableView(){
        viewModel.dataSupplierDebtReportArray.bind(to: tableView.rx.items(cellIdentifier: "DebtTableItemTableViewCell", cellType: DebtTableItemTableViewCell.self)){ [self]
            (row, data, cell) in
           
            cell.data = data
            cell.viewModel = viewModel
       
        }.disposed(by: rxbag)
        bindTableView2()
    }
 

    func bindTableView2(){
        viewModel.dataSupplierWarehouseSeasionsArray.bind(to: tableView2.rx.items(cellIdentifier: "DebtExportTableViewCell", cellType: DebtExportTableViewCell.self)){ [self]
            (row, data, cell) in
            
            cell.data = data
            cell.viewModel = viewModel
            
        }.disposed(by: rxbag)
    }
   
 
}

extension DebtReportTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


extension DebtReportTableViewController: SambagDatePickerViewControllerDelegate {
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult) {
        dLog(result.description)
      viewModel.ClearData()
      if(type_choose_date == 0) {
          viewModel.fromDate.accept(result.description)
          lbl_fromDate.text = result.description
//          viewModel.ClearData()
//          getSupplierDebtPayment()
      } else {
          viewModel.toDate.accept(result.description)
          lbl_ToDate.text = result.description
//          viewModel.ClearData()
//          getSupplierDebtPayment()
      }
    
      
        let from_date = viewModel.fromDate.value.components(separatedBy: "/")
        let to_date =  viewModel.toDate.value.components(separatedBy: "/")
//
      let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
      let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
      
      // MARK: Xét điều kiện ngày bắt đầu ko được lớn hơn ngày kết thúc
      if(from_date_in > to_date_in){
          JonAlert.show(message: "Ngày bắt đầu không được lớn hơn ngày kết thúc!", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
          if(type_choose_date == 0){
              lbl_fromDate.text = Utils.getCurrentDateString()
              viewModel.fromDate.accept(Utils.getCurrentDateString())
          }else{
              lbl_ToDate.text = Utils.getCurrentDateString()
              viewModel.toDate.accept(Utils.getCurrentDateString())
          }
         
//          viewModel.ClearData()
//          getSupplierDebtPayment()
      }
        viewModel.ClearData()
        getSupplierDebtPayment()
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    

    
    func showDateTimePicker(dataDateTime : String){
        let vc = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()
        var dateNow = Date()
        let dateString = dataDateTime
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateNow = dateFormatter.date(from: dateString)!
        limit.selectedDate = dateNow
        
        let currentDate = Date()
        let minDate = Calendar.current.date(byAdding: .year, value: -1000, to: currentDate)
        let maxDate = Calendar.current.date(byAdding: .year, value: 1000, to: currentDate)
        
        limit.minDate = minDate
        limit.maxDate = maxDate
        vc.limit = limit
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
}

// CALL MARK: API
extension DebtReportTableViewController {
    private func getSupplierDebtPayment(){
        viewModel.getListSupplierDebtPayment().subscribe(onNext: { [self](response) in
                if(response.code == RRHTTPStatusCode.ok.rawValue){
                    if let debtReport = Mapper<SupplierDebtPaymentResponse>().map(JSONObject: response.data) {
                        dLog(debtReport)
                        viewModel.dataSupplierDebtReportArray.accept([])
                        var dataNew = viewModel.dataSupplierDebtReportArray.value
                        dataNew.append(contentsOf: debtReport.data)
                        viewModel.dataSupplierDebtReportArray.accept(dataNew)
                     
                        Utils.isHideAllView(isHide: viewModel.dataSupplierDebtReportArray.value.count > 0 ? true: false, view: view_nodata_1)
                    }
                }else{
                    JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
                }
            }).disposed(by: rxbag)
        getSupplierWarehouseSeasions()
    }
    private func getSupplierWarehouseSeasions(){
        viewModel.getListSupplierWareHouseSessions().subscribe(onNext: { [self](response) in
                if(response.code == RRHTTPStatusCode.ok.rawValue){
                    if let SupplierWarehouseseasions = Mapper<SupplierWarehouseSessionsResponse>().map(JSONObject: response.data) {
                        dLog(SupplierWarehouseseasions)
                        viewModel.dataSupplierWarehouseSeasionsArray.accept([])
                        var dataNew = viewModel.dataSupplierWarehouseSeasionsArray.value
                        dataNew.append(contentsOf: SupplierWarehouseseasions.data)
                        viewModel.dataSupplierWarehouseSeasionsArray.accept(dataNew)
                        Utils.isHideAllView(isHide: viewModel.dataSupplierWarehouseSeasionsArray.value.count > 0 ? true: false, view: view_nodata_2)
                    }
                }else{
                    JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
                }
            }).disposed(by: rxbag)
    }
}
