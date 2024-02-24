//
//  DialogResetPasswordViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 13/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogResetPasswordViewModel: BaseViewModel {
    private(set) weak var view: DialogResetPasswordViewController?
    private var router: DialogResetPasswordRouter?
    
    func bind(view: DialogResetPasswordViewController,router: DialogResetPasswordRouter) {
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeToChangePasswordViewController() {
        router?.navigationToChangePasswordViewController()
    }
    
}
