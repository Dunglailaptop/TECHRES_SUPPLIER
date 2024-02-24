//
//  ForgotPasswordViewController.swift
//  Seemt
//
//  Created by Pham Khanh Huy on 07/04/2023.
//

import UIKit
import RxRelay
class ForgotPasswordViewController: BaseViewController {
    var viewModel = ForgotPasswordViewModel()
    var router = ForgotPasswordRouter()
    var sessions_str = ""
    @IBOutlet weak var text_field_brand: UITextField!
    @IBOutlet weak var lbl_notification_brand: UILabel!
    @IBOutlet weak var text_field_account: UITextField!
    @IBOutlet weak var lbl_notification_account: UILabel!
    
    @IBOutlet weak var view_btn_receive_OTP: UIView!
    @IBOutlet weak var lbl_btn_receive_OTP: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        _ = text_field_brand.rx.text.map{$0 ?? ""}.bind(to: viewModel.restaurant_brand_name).disposed(by: rxbag)
        _ = text_field_account.rx.text.map{$0 ?? ""}.bind(to: viewModel.account).disposed(by: rxbag)
       
        _ = viewModel.isBrandValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            self!.lbl_notification_brand.isHidden = !isValid ? false : true
            self!.enableBtn(condition: isValid ? true : false)
        })
        
        _ = viewModel.isAccountValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            self!.lbl_notification_account.isHidden = !isValid ? false : true
            self!.enableBtn(condition: isValid ? true : false)
        })
        
        
        _ = viewModel.isValid.subscribe({[weak self] isValid in
            guard let strongSelf = self, let isValid = isValid.element else { return }
            self!.enableBtn(condition: isValid ? true : false)
        })
        
        lbl_notification_brand.isHidden = true
        lbl_notification_account.isHidden = true
        
    }
    
    private func enableBtn(condition:Bool){
        if condition {
            view_btn_receive_OTP.isUserInteractionEnabled = true
            view_btn_receive_OTP.backgroundColor = UIColor(hex: "C7D9EC")
            lbl_btn_receive_OTP.textColor = UIColor(hex: "1462B0")
        }else {
            view_btn_receive_OTP.isUserInteractionEnabled = false
            view_btn_receive_OTP.backgroundColor = ColorUtils.gray_400()
            lbl_btn_receive_OTP.textColor = ColorUtils.gray_000()
        }
        
    
    }


    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func action(_ sender: Any) {
       getSession()
    
    }
    
}
