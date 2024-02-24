//
//  DetailEmployeeViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import ObjectMapper
import JonAlert


extension DetailEmployeeViewController {
    
    func updateWithAvatar() {
        getGenerateFile()
    }
    
    func postUpdate() {
        viewModel.UpdateEmployee().subscribe(onNext: { [self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue) {
//                JonAlert.show(message: "Cập nhật thông tin ")
            }
        }).disposed(by: rxbag)
    }
}
//Mark: Call API
extension DetailEmployeeViewController {
    
    
    func getDetailEmployee(){
        viewModel.getDetailEmployee().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let employeeDetail = Mapper<DetailProfileEmployee>().map(JSONObject: response.data) {
                    mapEmployeeData(employeeDetail: employeeDetail)
                    viewModel.employeeInfor.accept(employeeDetail)
                }
            }else{
                dLog(response.message ?? "")
            }
        }).disposed(by: rxbag)
    }
    
    func getSupplierRole(){
        viewModel.getListRole().subscribe(onNext: {(response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue) {
                if let dataSuplierRole = Mapper<SupplierRole>().mapArray(JSONObject: response.data){
                    self.viewModel.dataSuplier.accept(dataSuplierRole)
                    var dataSuplier:[SupplierRole] = dataSuplierRole.map({(element) in
                        var cloneElement = element
                        cloneElement.isSelected = DEACTIVE
                        return cloneElement
                    })
                    self.dropdown_title.optionArray = dataSuplierRole.map({$0.name})
                    self.dropdown_title.optionIds = dataSuplierRole.map({$0.id})
                    self.viewModel.dataSuplier.accept(dataSuplier)
                }
            }
        }).disposed(by: rxbag)
    }
    
    func UpdateProfileWithoutAvatar(){
        viewModel.getProfileUpdate().subscribe(onNext: {[self] (response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.show(message: "Cập nhật thông tin tài khoản thành công")
                var cloneAccount = ManageCacheObject.getCurrentUser()
                   if (imagecover.count > 0){
                     
                       cloneAccount.avatar = viewModel.employeeInfor.value.avatar
                       ManageCacheObject.saveCurrentUser(cloneAccount)
                   }
                       cloneAccount.name = viewModel.employeeInfor.value.name
                       ManageCacheObject.saveCurrentUser(cloneAccount)
                   
                       
                viewModel.makePopViewController()
            }else {
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
        })
    }
    
    
    
    func updateProfileWithAvatar(){
        getGenerateFile()
    }
    
    
    
    func createEmployeeWithoutAvatar(){
        viewModel.createEmployee().subscribe(onNext: {(response) in
            if (response.code == RRHTTPStatusCode.ok.rawValue){
                
                if let account  = Mapper<Account>().map(JSONObject: response.data){
                    self.viewModel.createdAccount.accept(account)
                    self.viewModel.dialogType.accept(1)
                    self.prensentDialogConfirm(content: "")
                }
                
            }else {
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", andIcon: UIImage(named: "icon-cancel"), duration: 2.0)
            }
        })
    }
    
    func createEmployeeWithAvatar() {
        getGenerateFile()
    }
    
    
    
        
    func getGenerateFile(){
        viewModel.getGenerateFile().subscribe(onNext: {(response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                // Call API Generate success...
                 let media_objects = Mapper<MediaObject>().mapArray(JSONArray: response.data as! [[String : Any]])
        
                /*
                    Nếu user thay đổi ảnh thì ta sẽ
                        gọi API để tạo file ảnh từ server trước, sau đó accept qua cho biến avatar và
                        gọi API update or create profile và upload ảnh lên server, sau khi update thành công thì
                        thấy đổi avatar của user (trong cache)
                    */
                var mediass_request = [mediass]()
                // CALL API UPLOAD IMAGE TO SERVER
                var upload_requests = [MediaRequest]()
                let upload_request = MediaRequest()
                upload_request?.media_id = media_objects[0].media_id
                upload_request?.name = media_objects[0].original?.name
                upload_request?.image = self.imagecover[0]
                upload_request?.data = self.imagecover[0].jpegData(compressionQuality: 0.5)
                upload_request?.type = TYPE_IMAGE// Hình ảnh
                upload_requests.append(upload_request!)
                self.viewModel.upload_request.accept(upload_requests)
                self.uploadMedia()
                
                // CALL API UPDATE PROFILE
                var cloneEmployeeInfor = self.viewModel.employeeInfor.value
                cloneEmployeeInfor.avatar = media_objects[0].thumb?.url! ?? ""
                self.viewModel.employeeInfor.accept(cloneEmployeeInfor)
                if self.moduleType == "UPDATE" {
                    self.UpdateProfileWithoutAvatar()
                } else if self.moduleType == "CREATE" {
                    self.createEmployeeWithoutAvatar()
                } else if self.moduleType == "UPDATEEMPLOYEE"{
                    self.postUpdate()
                }
                
                           
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ.", controller: self)
            }
        }).disposed(by: rxbag)
    }
    
    
    func uploadMedia(){
        viewModel.uploadImageWidthAlamofire()
    }
}
