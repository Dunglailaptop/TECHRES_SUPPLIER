//
//  DetailEmployeeViewController + Extension + validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
extension DetailEmployeeViewController {
    
    func mappingAndValidateData(){
        mappingData()
        validate()
    }
    
    private func mappingData(){
        
        dropdown_title.didSelect{ [self](selectedText , index ,id) in
            var cloneEmployeeInfor = viewModel.employeeInfor.value
            cloneEmployeeInfor.supplier_role_id = id
            viewModel.employeeInfor.accept(cloneEmployeeInfor)
        }
        
        
        _ = text_field_name.rx.text.map{(str) in
            if str!.count > 50 {
                self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
            }
            return String(str!.prefix(50))
        }.map({(str) -> DetailProfileEmployee in
            self.text_field_name.text = str
            var cloneEmployeeInfor = self.viewModel.employeeInfor.value
            cloneEmployeeInfor.name = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.employeeInfor).disposed(by: rxbag)
        
        
        
        _ = text_field_identity_card.rx.text.map{(str) in
            if str!.count > 12 {
                self.showWarningMessage(content: "Độ dài tối đa 12 ký tự")
            }
            return String(str!.prefix(12))
        }.map({(str) -> DetailProfileEmployee in
            self.text_field_identity_card.text = str
            var cloneEmployeeInfor = self.viewModel.employeeInfor.value
            cloneEmployeeInfor.identity_card = str ?? ""
            return cloneEmployeeInfor
        }).bind(to: viewModel.employeeInfor).disposed(by: rxbag)
        
        
        _ = text_field_phone.rx.text.map{(str) in
                if(String(str!.prefix(1)) != "0" && !str!.isEmpty){
                    return String("")
                }else if str!.count > 10 {
                    self.showWarningMessage(content: "Độ dài tối đa 10 ký tự")
                }
                return String(str!.prefix(10))
            }.map({(str) -> DetailProfileEmployee in
            var cloneEmployeeInfor = self.viewModel.employeeInfor.value
            self.text_field_phone.text = str
            cloneEmployeeInfor.phone = str
            return cloneEmployeeInfor
        }).bind(to: viewModel.employeeInfor).disposed(by: rxbag)
        
        
        _ = text_field_email.rx.text.map{(str) in
                if str!.count > 50 {
                    self.showWarningMessage(content: "Độ dài tối đa 50 ký tự")
                }
                return String(str!.prefix(50))
            }.map({(str) -> DetailProfileEmployee in
            var cloneEmployeeInfor = self.viewModel.employeeInfor.value
            cloneEmployeeInfor.email = str
            self.text_field_email.text = str
            return cloneEmployeeInfor
        }).bind(to: viewModel.employeeInfor).disposed(by: rxbag)
        
        
        _ = text_field_address.rx.text.map{(str) in
            
                if str!.count > 255 {
                    self.showWarningMessage(content: "Độ dài tối đa 255 ký tự")
                }
                return String(str!.prefix(255))
            }.map({(str) -> DetailProfileEmployee in
            var cloneEmployeeInfor = self.viewModel.employeeInfor.value
            cloneEmployeeInfor.address = str
            self.text_field_address.text = str
            
            return cloneEmployeeInfor
        }).bind(to: viewModel.employeeInfor).disposed(by: rxbag)
        
    }
    
    
    private func validate(){
        _ = isNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_name.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isIdentityCardValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_cardId.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isBirthDateValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_DOB.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isPhoneNumberValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_phone.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isEmailValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_email.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isAddressValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_address.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isCityValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_choose_city.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isDistrictValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_choose_district.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isWardValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_error_choose_ward.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        
    }
    
  
    
    var isEmployeeInforValid: Observable<Bool>{
        return Observable.combineLatest(isNameValid,isIdentityCardValid,isBirthDateValid,isPhoneNumberValid,isAddressValid, isCityValid,isDistrictValid,isWardValid){$0 && $1 && $2 && $3 && $4 && $5 && $6 && $7}
    }
    
    
    private var isNameValid: Observable<Bool>{
        return viewModel.employeeInfor.map{$0.name}.distinctUntilChanged().asObservable().map(){[self](str) in
            let name = str.trim()
            lbl_error_name.isHidden = false
            
            if name.count < 2{
                lbl_error_name.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }

            lbl_error_name.isHidden = true
            lbl_error_name.text = ""
            return true
        }

    }
    
    private var isIdentityCardValid:Observable<Bool>{
        
        return viewModel.employeeInfor.map{$0.identity_card}.distinctUntilChanged().asObservable().map(){[self](str) in
            let id = str.trim()
            lbl_error_cardId.isHidden = false
            
            if(id.count < 9){
                lbl_error_cardId.text = "Độ dài tối thiểu 9 ký tự"
                return false
            }

            lbl_error_cardId.isHidden = true
            lbl_error_cardId.text = ""
            return true
        }
    }
    
    
    private var isBirthDateValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.birthday}.distinctUntilChanged().asObservable().map(){[self](DOB) in
            lbl_error_DOB.isHidden = false
            if(DOB.isEmpty){
                lbl_error_DOB.text = "Vui lòng chọn ngày sinh"
                return false
            }
            lbl_error_DOB.isHidden = true
            lbl_error_DOB.text = ""
            return true
        }
    
    }
        
    private var isPhoneNumberValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.phone}.distinctUntilChanged().asObservable().map(){[self](phoneNumber) in
            lbl_error_phone.isHidden = false
            if(phoneNumber.isEmpty){
                lbl_error_phone.text = "Không được bỏ trống số điện thoại"
                return false
            }else if(phoneNumber.count < 10){
                lbl_error_phone.text = "Số điện thoại chưa đúng 10 số!"
                return false
            }
            lbl_error_phone.isHidden = true
            lbl_error_phone.text = ""
            return true
            
        }
    
    }
    
    
    private var isEmailValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.email}.distinctUntilChanged().asObservable().map(){[self](str) in
            let email = str.trim()
            lbl_error_email.isHidden = false
            if(email.count < 2){
                lbl_error_email.text = "Độ dài tối thiểu 2 ký tự"
                return false
                
            }else if (Utils.isEmailFormatCorrect(email)) == false{
                lbl_error_email.text = "Email không hợp lệ"
                return false
            }
            lbl_error_email.isHidden = true
            lbl_error_email.text = ""
            return true
        }
       
    }
    
    
    private var isAddressValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.address}.distinctUntilChanged().asObservable().map(){[self](str) in
            let address = str.trim()
            lbl_error_address.isHidden = false
            if(address.count < 2){
                lbl_error_address.text = "Độ dài tối thiểu 2 ký tự"
                return false
            }else if (address.count > 255){
                lbl_error_address.text = "Độ dài tối đa 255 ký tự"
                return false
            }
            lbl_error_address.isHidden = true
            lbl_error_address.text = ""
            return true
        }
    }
    
    private var isCityValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.city_id}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_choose_city.isHidden = false
            if id <= 0{
                lbl_error_choose_city.text = "Vui lòng chọn Tỉnh, Thành phố"
                return false
            }
            lbl_error_choose_city.isHidden = true
            lbl_error_choose_city.text = ""
            return true
        }
    }
    
    private var isDistrictValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.district_id}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_choose_district.isHidden = false
            if id <= 0 {
                lbl_error_choose_district.text = "Vui lòng chọn Quận,Huyện"
                return false
            }
            lbl_error_choose_district.isHidden = true
            lbl_error_choose_district.text = ""
            return true
        }
    }
    
    
    private var isWardValid:Observable<Bool>{
        return viewModel.employeeInfor.map{$0.ward_id}.distinctUntilChanged().asObservable().map(){[self](id) in

            lbl_error_choose_ward.isHidden = false
            if id <= 0 {
                lbl_error_choose_ward.text = "Vui lòng chọn phường, xã"
                return false
            }
            lbl_error_choose_ward.isHidden = true
            lbl_error_choose_ward.text = ""
            return true
        }
    }
    
    
    
}
