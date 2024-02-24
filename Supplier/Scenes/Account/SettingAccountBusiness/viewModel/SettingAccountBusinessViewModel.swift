//
//  SettingAccountBusinessViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 22/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa
import JonAlert

class SettingAccountBusinessViewModel:BaseViewModel {
    private(set) weak var view: SettingAccountBusinessViewController?
    private var router: SettingAccountBusinessRouter?
    
    public var supplierInfor = BehaviorRelay<SupplierBusiness>(value: SupplierBusiness())
    public var supplier_type_business_id: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    public var dataArrayTypeBusiness: BehaviorRelay<[TypeBusiness]> = BehaviorRelay(value: [])
    public var dataSearch: BehaviorRelay<[TypeBusiness]> = BehaviorRelay(value: [])
    public var dataFirst:BehaviorRelay<[TypeBusiness]> = BehaviorRelay(value: [])
    var isMessageShowing = BehaviorRelay<Bool>(value: false)
    func bind(view: SettingAccountBusinessViewController, router: SettingAccountBusinessRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makepopViewController(){
        router?.navigationPopToViewController()
    }
    
    private func showWarningMessage(content:String){
        if(!isMessageShowing.value){
            JonAlert.show(message: content ,
                          andIcon: UIImage(named: "icon-tab-workplace"),
                          duration: 2.0)
            isMessageShowing.accept(true)
        }
        
    }
    
    private func validateName(name:String) -> Bool{
        if (name.isEmpty){
            showWarningMessage(content: "Tên không được để trống")
            return false
        }else {
            if(name.count < 2){
                showWarningMessage(content: "Tên phải có tối thiểu 2 ký tự")
                return false
            }else if(name.count > 50){
                showWarningMessage(content: "Tên chỉ được tối đa 50 ký tự")
                return false
            }
            return true
        }
    }
    
  
        
    private func validatePhoneNumber(phoneNumber:String) -> Bool {
        if(phoneNumber.isEmpty){
            showWarningMessage(content: "Số điện thoại không được để trống")
            return false
        }else{
            if(phoneNumber.count < 10){
                showWarningMessage(content: "Số điện thoại chưa đúng 10 số!")
                return false
            }else{
                let index = phoneNumber.index(phoneNumber.startIndex, offsetBy: 0)
                if(Int(String(phoneNumber[index])) != 0){
                    showWarningMessage(content: "Số đầu tiên phải là số 0")
                    return false
                }
            }
            return true
        }
    }
    
    
//    private func validateEmail(email:String) -> Bool{
//        if(email.count < 5){
//            showWarningMessage(content:"Email tối thiểu 5 ký tự")
//            return false
//        }else if (email.count > 55){
//            showWarningMessage(content:"Email tối đa 55 ký tự")
//            return false
//        }else if (Utils.isEmailFormatCorrect(email)) == false{
//            showWarningMessage(content:"Email không hợp lệ")
//            return false
//        }
//        return true
//    }
    
    
    private func validateAddress(address:String) -> Bool{
        if(address.isEmpty){
            showWarningMessage(content:"Địa chỉ tối thiểu 2 ký tự")
            return false
        }else {
            if(address.trim().count < 2){
                showWarningMessage(content:"Địa chỉ phải có tối thiểu 2 ký tự")
                return false
            }else if (address.count > 255){
                showWarningMessage(content: "Địa chỉ được tối đa 255 ký tự")
                return false
            }
                return true
        }
    }
    
    var isAccountBusinessInforValid: Observable<Bool>{
        return Observable.combineLatest(
            Observable.of(validateName(name: supplierInfor.value.name)),
            Observable.of(validatePhoneNumber(phoneNumber: supplierInfor.value.phone)),
//            Observable.of(validateEmail(email: supplierInfor.value.email)),
            Observable.of(validateAddress(address: supplierInfor.value.address))
        ){$0 && $1 && $2}
    }
    
    
}
extension SettingAccountBusinessViewModel {
    func getSupplierInfo() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getSupplierInfo)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    func UpdateSupplierInfo() -> Observable<APIResponse> {
        var unitSpecsList:[Int] = []
        for unitSpecs in self.dataArrayTypeBusiness.value.filter{$0.isSelected == ACTIVE} {
            unitSpecsList.append(unitSpecs.id)
        }
        return appServiceProvider.rx.request(.updateSupplierInfoBusiness(name: supplierInfor.value.name, email: supplierInfor.value.email, phone: supplierInfor.value.phone, address: supplierInfor.value.address, tax_code: supplierInfor.value.tax_code, website: supplierInfor.value.website, description: supplierInfor.value.description, avatar: supplierInfor.value.avatar, information: supplierInfor.value.information,city_id: supplierInfor.value.city_id, district_id: supplierInfor.value.district_id, ward_id: supplierInfor.value.ward_id,cover_photo: supplierInfor.value.cover_photo,supplier_business_type_id: unitSpecsList))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
    
    func getListTypesBusiness() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.getListTypesBusiness)
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast()
            .mapObject(type: APIResponse.self)
    }
}
