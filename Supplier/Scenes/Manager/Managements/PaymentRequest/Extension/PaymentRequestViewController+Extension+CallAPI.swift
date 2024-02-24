//
//  RequestPaymentViewController + extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import ObjectMapper
extension PaymentRequestViewController {
    
    func mapData(data:[SupplierDebtPayment]){
        /*
            status = 1 -> đang chờ xử lý
            status = 2 -> đã hoàn thành
            status = 3 -> đã huỷ
         */
        /*hàm này dùng để filter dữ liệu cần hiển thị, và hiển thị tổng số lượng đang waiting and completed and cancel trên tab sub-header*/
        viewModel.dataArray.accept(data.filter({(element) in element.status == viewModel.status.value}))
        tableView.reloadSections(IndexSet([0]), with: .none)
        no_data_view.isHidden = viewModel.dataArray.value.count > 0 ? true : false
    }
    

    func getSupplierDebtPayment(){
        viewModel.getSupplierDebtPayment().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                dLog(response.data)
                if let dataFromServer = Mapper<SupplierDebtPaymentResponse>().map(JSONObject: response.data) {
                    viewModel.clearData()
                    var pagination = viewModel.pagination.value
                    pagination.total_record = dataFromServer.total_record
              
                    if(dataFromServer.data.count > 0 && !pagination.isGetFullData){
                        var fullDataArray = viewModel.fullDataArray.value
                        fullDataArray.append(contentsOf: dataFromServer.data)
                        viewModel.fullDataArray.accept(fullDataArray)
                        pagination.isGetFullData = viewModel.fullDataArray.value.count == pagination.total_record ? true: false
                    }
                    pagination.isAPICalling = false
                    viewModel.pagination.accept(pagination)
                    mapData(data: viewModel.fullDataArray.value)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
}

extension PaymentRequestViewController: UITextFieldDelegate,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var pagination = viewModel.pagination.value
        let tableViewContentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + tableViewHeight >= tableViewContentHeight {
            
            if(viewModel.fullDataArray.value.count < pagination.total_record && !pagination.isGetFullData && !pagination.isAPICalling){
                pagination.page += 1
                pagination.isAPICalling = true
                viewModel.pagination.accept(pagination)
                getSupplierDebtPayment()
            }
        }
    }
    
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        var cloneAPIParameter = viewModel.APIParameter.value
        cloneAPIParameter.key_search = ""
        viewModel.APIParameter.accept(cloneAPIParameter)
        viewModel.clearDataAndCallAPI()
        return true
    }
}

extension PaymentRequestViewController{
    func registerCell() {
        let paymentRequestTableViewCell = UINib(nibName: "PaymentRequestTableViewCell", bundle: .main)
        tableView.register(paymentRequestTableViewCell, forCellReuseIdentifier: "PaymentRequestTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.modelSelected(SupplierDebtPayment.self).subscribe(onNext: { [self] element in
            viewModel.makeDetailedPaymentRequestViewController(supplierDebtPayment: element)
        }).disposed(by: rxbag)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UItableViewController
    }

    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "PaymentRequestTableViewCell", cellType: PaymentRequestTableViewCell.self))
            {(row, debtpayment, cell) in
                cell.data = debtpayment
            }.disposed(by: rxbag)
    }

    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        viewModel.clearDataAndCallAPI()
    }
}
