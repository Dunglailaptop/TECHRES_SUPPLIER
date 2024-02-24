//
//  EmployeeListManagementViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import RxRelay
import RxCocoa
import JonAlert

//MARK: CALL API
extension EmployeeListManagementViewController{
    func getEmployees(){
        viewModel.getEmployees().subscribe(onNext: { [self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<EmployeeData>().map(JSONObject: response.data) {
                    var pagination = self.viewModel.pagination.value
                    pagination.total_record = dataFromServer.total_record
                    if(dataFromServer.employees.count > 0 && !pagination.isGetFullData){
                        var datas = viewModel.dataArray.value
                        datas.append(contentsOf: dataFromServer.employees)
                        viewModel.dataArray.accept(datas)
                        pagination.isGetFullData = self.viewModel.dataArray.value.count == pagination.total_record ? true : false
                    }
                    pagination.isAPICalling = false
                    viewModel.pagination.accept(pagination)
                  
                    dLog(response.toJSON())
                    dLog(dataFromServer.employees)

                    Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false , view: root_view_empty_data)
                }
            }else{
                JonAlert.show(message: "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
         
        }).disposed(by: rxbag)
    }
}
//MARK: REGISTER CELL TABLE VIEW
extension EmployeeListManagementViewController{
    func registerCell() {
        
        let employeeManagementTableViewCell = UINib(nibName: "EmployeeManagementTableViewCell", bundle: .main)
        tableView.register(employeeManagementTableViewCell, forCellReuseIdentifier: "EmployeeManagementTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        
       
        
//        tableView.rx.contentOffset
//            .map { [weak self] contentOffset in
//                guard let self = self else { return false }
//                var offset: CGFloat = 0.0
//                let visibleHeight = self.tableView.frame.height - self.tableView.contentInset.top - self.tableView.contentInset.bottom
//                let scrolledDistance = contentOffset.y + self.tableView.contentInset.top
//                let distanceToBottom = max(offset,self.tableView.contentSize.height - visibleHeight)
//                return scrolledDistance >= distanceToBottom
//            }
//            .distinctUntilChanged()
//            .filter { $0 }
//            .subscribe(onNext: { [weak self] _ in
//                guard let self = self else { return }
//                dLog(self.viewModel.dataArray.value.count)
//                dLog(self.totalRecord)
//                if self.viewModel.dataArray.value.count < self.totalRecord {
//                    self.spinner.color = ColorUtils.main_color()
//                    self.spinner.startAnimating()
//                    self.spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 55)
//                    self.tableView.tableFooterView = self.spinner
//                    self.tableView.tableFooterView?.isHidden = false
//
//                    DispatchQueue.main.async { [weak self] in
//                        guard let self = self else { return }
//                        dLog(self.page)
//                        self.page += 1
//                        self.viewModel.page.accept(self.page)
//                        self.getEmployees()
//                    }
//                }
//            })
//            .disposed(by: rxbag)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)        
    }
    
    @objc func refresh(_ sender: AnyObject) {
          // Code to refresh table view
//        if(self.page > 1){
//            dLog("21321")
//            self.page = 1
//            self.viewModel.page.accept(page)
//            self.viewModel.clearData()
//            self.getEmployees()
//        }
       
           refreshControl.endRefreshing()
        viewModel.clearDataAndCallAPI()
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "EmployeeManagementTableViewCell", cellType: EmployeeManagementTableViewCell.self))
            {  (row, employees, cell) in
                dLog(employees)
                cell.data = employees
                cell.viewModel = self.viewModel
                cell.btnLock.rx.tap.asDriver()
                            .drive(onNext: { [weak self] in
                                self?.presentModalDialogLockEmployee(position: row,lockId: employees.id, type: 1) // Type = 1: Khoá tài khoản nhân viên
                            }).disposed(by: cell.disposeBag)
                
                cell.btnUnLock.rx.tap.asDriver()
                            .drive(onNext: { [weak self] in
                                self?.presentModalDialogLockEmployee(position: row,lockId: employees.id, type: 2) //Type = 2: Mở khoá tài khoản nhân viên
                            }).disposed(by: cell.disposeBag)
                
                cell.btn_changepassword_employee.rx.tap.asDriver().drive(onNext: { [weak self] in
                    self?.presentModalDialogChangePasswordEmployee(IdEmployeeResetPassword: employees.id,type: 1, username: "",note_noty: "")
                    
                }).disposed(by: cell.disposeBag)
            }.disposed(by: rxbag)
        
        
    }
}

extension EmployeeListManagementViewController: UITextFieldDelegate {
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.key_search.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
}
extension EmployeeListManagementViewController: UITableViewDelegate, UIScrollViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
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
                getEmployees()
            }
        }
        
    }
    
    
}

extension EmployeeListManagementViewController: ResetPasswordDelegate {
    
    func callBackResetPasswordEmployee(Employee:Account) {
        if Employee.id > 0 {
            dismiss(animated: true)
            presentModalDialogAccessResetPasswordEmployee(Employeeinfo: Employee)
        }else {
            JonAlert.show(message: "Reset mật khẩu không thành công")
        }
    }
    
    func presentModalDialogChangePasswordEmployee(IdEmployeeResetPassword:Int,type:Int,username:String,note_noty:String) {
        let dialogchangepasswordEmployeeViewController = DialogChangePasswordEmployeeViewController()
        dialogchangepasswordEmployeeViewController.view.backgroundColor = ColorUtils.blackTransparent()
        dialogchangepasswordEmployeeViewController.employeeId = IdEmployeeResetPassword
        dialogchangepasswordEmployeeViewController.delegate = self
        dialogchangepasswordEmployeeViewController.usernames = username
        dialogchangepasswordEmployeeViewController.type = type
        dialogchangepasswordEmployeeViewController.note_noty = note_noty
            let nav = UINavigationController(rootViewController: dialogchangepasswordEmployeeViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
   
            present(nav, animated: true, completion: nil)

    }
}
extension EmployeeListManagementViewController {
    
   
    
    func presentModalDialogAccessResetPasswordEmployee(Employeeinfo:Account) {
        let DialogAccessChangePasswordEmployeeViewController = DialogAccessChangePasswordEmployeeViewController()
        DialogAccessChangePasswordEmployeeViewController.view.backgroundColor = ColorUtils.blackTransparent()
        DialogAccessChangePasswordEmployeeViewController.data = Employeeinfo
       
     
            let nav = UINavigationController(rootViewController: DialogAccessChangePasswordEmployeeViewController)
            // 1
            nav.modalPresentationStyle = .overCurrentContext
            // 2
            if #available(iOS 15.0, *) {
                if let sheet = nav.sheetPresentationController {
                    
                    // 3
                    sheet.detents = [.large()]
                    
                }
            } else {
                // Fallback on earlier versions
            }
            // 4
   
            present(nav, animated: true, completion: nil)

    }
}
