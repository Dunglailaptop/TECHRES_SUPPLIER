//
//  FeedBackViewController + Extension + Validate.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

extension FeedBackViewController{
    
    func validateAndMappingData(){
        _ = text_field_email.rx.text.map{String($0 ?? "")}.subscribe(onNext:{[weak self] (value) in
            self!.viewModel.email.accept(String(value))
            self!.text_field_email.text = String(value)
        }).disposed(by: rxbag)
        
        _ = isEmailValid.subscribe(onNext: {(isValid) in
            self.lbl_email_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
    
        _ = text_view.rx.text.map{$0!.prefix(2000)}.subscribe(onNext:{[weak self] (value) in
            self!.viewModel.describe.accept(String(value))
            self!.text_view.text = String(value)
            self!.lbl_text_length.text = String(value.count)
        }).disposed(by: rxbag)
        
        
        _ = isDescriptionValid.subscribe(onNext: {(isValid) in
            self.lbl_description_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        _ = isValid.subscribe(onNext: {(isValid) in
            if isValid{
                self.lbl_confirm_btn.textColor = ColorUtils.blue_700()
                self.icon_confirm.image = UIImage(named: "icon-blue-checked")
                self.btn_confirm_view.backgroundColor = ColorUtils.blue_000()
                self.btn_confirm_view.isUserInteractionEnabled = true
            }else {
                self.lbl_confirm_btn.textColor = .white
                self.icon_confirm.image = UIImage(named: "icon-check-white")
                self.btn_confirm_view.backgroundColor = ColorUtils.gray_400()
                self.btn_confirm_view.isUserInteractionEnabled = false
            }
        }).disposed(by: rxbag)
        
    }
    
    
    
    var isEmailValid: Observable<Bool>{
        return viewModel.email.asObservable().map(){(email) in
            if(email.trim().count < 2){
                self.lbl_email_err.text = "Độ dài tối thiểu 2 ký tự"
                self.lbl_email_err.isHidden = false
                return false
            }else if email.trim().count > 50 {
                self.lbl_email_err.text = "Độ dài tối đa 50 ký tự"
                self.lbl_email_err.isHidden = false
                return false
            } else if !Utils.isEmailFormatCorrect(email){
                self.lbl_email_err.text = "Email không hợp lệ"
                self.lbl_email_err.isHidden = false
                return false
            }else {
                return true
            }
        }
    }
    
        
    var isDescriptionValid:Observable<Bool>{
        return viewModel.describe.asObservable().map(){(description) in
            if(description.trim().count < 2){
                self.lbl_description_err.text = "Nội dung góp ý phải có tối thiểu 2 ký tự"
                self.lbl_description_err.isHidden = false
                return false
            }
            return true
        }

    }
    
    var isValid: Observable<Bool>{
        return Observable.combineLatest(isEmailValid,isDescriptionValid){$0 && $1}
    }
}
