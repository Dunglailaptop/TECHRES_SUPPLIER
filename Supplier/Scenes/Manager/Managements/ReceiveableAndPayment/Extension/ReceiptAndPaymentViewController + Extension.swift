//
//  ReceiptAndPaymentViewController + Extension + A{I.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 19/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
import RxSwift
import RxRelay
extension ReceiptAndPaymentViewController: SambagDatePickerViewControllerDelegate{
    func sambagDatePickerDidSet(_ viewController: SambagDatePickerViewController, result: SambagDatePickerResult){
        switch viewModel.dateType.value{
            case 1:
                if(isDateValid(fromDate: result.description, toDate: viewModel.to_date.value)){
                    viewModel.from_date.accept(result.description)
                    lbl_from_date.text = result.description
                    viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày bắt đầu không được lớn hơn ngày kết thúc",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                    lbl_from_date.text = viewModel.from_date.value
                }
                break

            case 2:
                if(isDateValid(fromDate: viewModel.from_date.value, toDate:result.description)){
                    viewModel.to_date.accept(result.description)
                    lbl_to_date.text = result.description
                    viewModel.clearDataAndCallAPI()
                }else {
                    JonAlert.show(
                        message: "Ngày kết thúc không được bé hơn ngày bắt đầu",
                        andIcon: UIImage(named: "icon-warning"),
                        duration: 2.0)
                    lbl_to_date.text = viewModel.to_date.value
                }
                break

            default:
                break
        }
      
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func sambagDatePickerDidCancel(_ viewController: SambagDatePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    func showDateTimePicker(dateTimeData:String){
        let vc = SambagDatePickerViewController()
        var limit = SambagSelectionLimit()
        
        var dateNow = Date()
        let dateString = dateTimeData
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateNow = dateFormatter.date(from: dateString)!
        limit.selectedDate = dateNow

        // Set the minimum and maximum selectable dates
        let calendar = Calendar.current
        let currentDate = Date()
        let minDate = calendar.date(byAdding: .year, value: -1000, to: currentDate) // One year ago
        let maxDate = calendar.date(byAdding: .year, value: 1000, to: currentDate) // One year from now

        limit.minDate = minDate
        limit.maxDate = maxDate
        vc.limit = limit
        vc.delegate = self
        present(vc, animated: true, completion: nil)
       }
    
    
    private func isDateValid(fromDate:String, toDate:String)-> Bool{
        let from_date = fromDate.components(separatedBy: "/")
        let to_date = toDate.components(separatedBy: "/")
        let from_date_in = String(format: "%@%@%@", from_date[2], from_date[1], from_date[0])
        let to_date_in = String(format: "%@%@%@", to_date[2], to_date[1], to_date[0])
        return from_date_in <= to_date_in
    }
    
    
}


extension ReceiptAndPaymentViewController{
    func registerCell() {
        let receiptAndPaymentTableViewCell = UINib(nibName: "ReceiptAndPaymentTableViewCell", bundle: .main)
        tableView.register(receiptAndPaymentTableViewCell, forCellReuseIdentifier: "ReceiptAndPaymentTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView.rx.modelSelected(ReceiptPayment.self).subscribe(onNext: { [self] element in
            viewModel.makeDetailedReceiptAndPaymentViewController(receiptPayment: element)
        })
        
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UItableViewController
    }

    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ReceiptAndPaymentTableViewCell", cellType: ReceiptAndPaymentTableViewCell.self))
            {(row, receiptPayment, cell) in
                cell.viewModel = self.viewModel
                cell.data = receiptPayment
            }.disposed(by: rxbag)
    }

    @objc func refresh(sender: AnyObject) {
        // Code to refresh table view
        refreshControl.endRefreshing()
        viewModel.clearDataAndCallAPI()
    }

}


extension ReceiptAndPaymentViewController: UITextFieldDelegate,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    

    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        var pagination = viewModel.pagination.value
        let tableViewContentHeight = tableView.contentSize.height
        let tableViewHeight = tableView.frame.size.height
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset + tableViewHeight >= tableViewContentHeight {
            
            if(viewModel.dataArray.value.count < pagination.total_record && !pagination.isGetFullData && !pagination.isAPICalling){
                pagination.page += 1
                pagination.isAPICalling = true
                viewModel.pagination.accept(pagination)
                getReceiptAndPaymentList()
            }
        }
        
    }
    
    
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
    
    
}

