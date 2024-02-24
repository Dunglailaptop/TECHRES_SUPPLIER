//
//  ChangePasswordViewController+Extension.swift
//  Seemt
//
//  Created by Kelvin on 08/04/2023.
//

import UIKit
import RxSwift

extension ChangePasswordViewController {
    func changePassword(){
        viewModel.changePassword().subscribe(onNext: {(response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if self.type == 1 {
                    NotificationCenter.default
                                .post(name: NSNotification.Name("success"),
                                 object: nil)


                    self.viewModel.makePopViewController()
                    
                } else {
                    Toast.show(message: "Bạn đã đổi mật khẩu thành công", controller: self)
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)){
                        self.logout()
                    }
                }
              

            }else{
                Toast.show(message: response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại", controller: self)
            }
        }).disposed(by: rxbag)
    }
    
    
 
}
