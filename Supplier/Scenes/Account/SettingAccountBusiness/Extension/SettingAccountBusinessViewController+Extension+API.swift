//
//  SettingAccountBusinessViewController+Extension+API.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
import RxSwift
import RxRelay
import RxCocoa

extension SettingAccountBusinessViewController {
    
    func getListTypeBusiness() {
        viewModel.getListTypesBusiness().subscribe(onNext: { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let datas = Mapper<TypeBusiness>().mapArray(JSONObject: response.data) {
                    self.viewModel.dataArrayTypeBusiness.accept(datas)
//                    self.viewModel.dataSearch.accept(datas)
//                    var data:[TypeBusiness] = datas.map({(element) in
//                        var cloneElement = element
//                        cloneElement.isSelected = DEACTIVE
//                        return cloneElement
//                    })
//                    self.type_business.optionArray = datas.map({$0.name})
//                    self.type_business.optionIds = datas.map({$0.id})
//                    dLog(data)
//                    self.viewModel.dataArrayTypeBusiness.accept(data)
                }
            }
        })
    }
    
    
    func getSupplierInfo() {
        viewModel.getSupplierInfo().subscribe(onNext:  { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                if let dataSupplierInfo = Mapper<SupplierBusiness>().map(JSONObject: response.data) {
                    self.viewModel.supplierInfor.accept(dataSupplierInfo)
//                    self.viewModel.dataArrayTypeBusiness.accept(dataSupplierInfo)
                    var dataTypeBusiness = self.viewModel.dataArrayTypeBusiness.value
                    var unitSpecsList:[TypeBusiness] = dataTypeBusiness.map({(element) in
                        var cloneElement = element
                        cloneElement.isSelected = DEACTIVE
                        return cloneElement
                    })
                    
                    var dataIdBusiness = viewModel.supplier_type_business_id.value
                    for dataSupinfoTypeBusiness in dataSupplierInfo.supplier_bussiness_types {
                        unitSpecsList.enumerated().forEach{(index,value2) in
                            if dataSupinfoTypeBusiness.id == value2.id && dataSupinfoTypeBusiness.isSelected == DEACTIVE {
                                unitSpecsList[index].isSelected = ACTIVE
                                self.tag_List.addTag(value2.name)
                                self.height_tag_list.constant = 5 + self.tag_List.intrinsicContentSize.height
                                self.heightview.constant = height_tag_list.constant + 80
                                dataIdBusiness.append(value2.id)
                            }
                        }
                        
                    }
                    self.viewModel.dataArrayTypeBusiness.accept(unitSpecsList)
                
                    self.viewModel.supplier_type_business_id.accept(dataIdBusiness)
                    self.setupProfile()
                    dLog(response.toJSON())
                }
            }else {
                JonAlert.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối")
            }
            
        }).disposed(by: rxbag)
        
    }
    
    func updateProfileBusiness() {
        viewModel.UpdateSupplierInfo().subscribe(onNext:  { [self] (response) in
            if response.code == RRHTTPStatusCode.ok.rawValue {
                self.viewModel.makepopViewController()
                JonAlert.show(message: "Cập nhật thông tin doanh nghiệp thành công")
                
            }else {
                JonAlert.show(message: response.message ?? "Cập nhật thông tin doanh nghiệp thất bại")
            }
        })
    }
    
    func setupProfile() {
        txt_businessId.text = String(viewModel.supplierInfor.value.id)
        txt_nameBusiness.text = viewModel.supplierInfor.value.name
        txt_emailBusiness.text = viewModel.supplierInfor.value.email
        txt_phoneBusiness.text = viewModel.supplierInfor.value.phone
        txt_addessBusiness.text = viewModel.supplierInfor.value.address
        txt_categoryBusiness.text = viewModel.supplierInfor.value.website
        txt_name_normalize.text = ManageCacheObject.getUsernameLogin()
//        txt_businesscategory.text = viewModel.supplierInfor.value.name_supplier_bussiness_type
        txt_taxCode.text = viewModel.supplierInfor.value.tax_code
        txt_description.text = viewModel.supplierInfor.value.description
        lbl_district.text = viewModel.supplierInfor.value.district_name
        lbl_ward.text = viewModel.supplierInfor.value.ward_name
        lbl_city.text = viewModel.supplierInfor.value.city_name
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.supplierInfor.value.avatar)), placeholder: UIImage(named: "icon-logo-gray"))
        poster.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: viewModel.supplierInfor.value.cover_photo)), placeholder: UIImage(named: "img-background"))
        
    }
}


extension SettingAccountBusinessViewController {
    
    
    func updateProfileWithAvatar(){
        getGenerateFile()
    }
        
    func getGenerateFile(){
        viewModel.getGenerateFile().subscribe(onNext: {(response) in
            dLog(response.toJSON())
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                // Call API Generate success...
                 let media_objects = Mapper<MediaObject>().mapArray(JSONArray: response.data as! [[String : Any]])
                var upload_requests = [MediaRequest]()
                // CALL API UPDATE PROFILE
                var cloneEmployeeInfor = self.viewModel.supplierInfor.value
                var checkArray = 0
                if self.imagecover.count > 0 {
                 dLog("vap")
                    cloneEmployeeInfor.avatar = media_objects[0].thumb?.url! ?? ""
                   
                  
                 
                    let upload_request = MediaRequest()
                    upload_request?.media_id = media_objects[0].media_id
                    upload_request?.name = media_objects[0].original?.name
                    upload_request?.image = self.imagecover[0]
                    upload_request?.data = self.imagecover[0].jpegData(compressionQuality: 0.5)
                    upload_request?.type = TYPE_IMAGE// Hình ảnh
                    upload_requests.append(upload_request!)
                    checkArray = 1
                }
                dLog(self.imagecover2.count)
                if self.imagecover2.count > 0 {
//                    var cloneEmployeeInfor = self.viewModel.supplierInfor.value
                    dLog("vao day roi")
                    let upload_request2 = MediaRequest()
                    if media_objects[checkArray].thumb?.url != nil {
                        cloneEmployeeInfor.cover_photo = media_objects[checkArray].thumb?.url! ?? ""
                        
                        upload_request2?.media_id = media_objects[checkArray].media_id
                        upload_request2?.name = media_objects[checkArray].original?.name
                    }
                    upload_request2?.image = self.imagecover2[0]
                    upload_request2?.data = self.imagecover2[0].jpegData(compressionQuality: 0.5)
                    upload_request2?.type = TYPE_IMAGE// Hình ảnh
                    upload_requests.append(upload_request2!)
                }
                self.viewModel.supplierInfor.accept(cloneEmployeeInfor)
              self.updateProfileBusiness()
                /*
                    Nếu user thay đổi ảnh thì ta sẽ
                        gọi API để tạo file ảnh từ server trước, sau đó accept qua cho biến avatar và
                        gọi API update or create profile và upload ảnh lên server, sau khi update thành công thì
                        thấy đổi avatar của user (trong cache)
                    */
            
                self.viewModel.upload_request.accept(upload_requests)
            
                
            
                self.uploadMedia()
                           
            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ.", controller: self)
            }
        }).disposed(by: rxbag)
    }
    
    
    func uploadMedia(){
        viewModel.uploadImageWidthAlamofire()
    }
    
}
