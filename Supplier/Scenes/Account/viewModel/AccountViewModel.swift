//
//  AccountViewModel.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class AccountViewModel: BaseViewModel {
    private(set) weak var view: AccountViewController?
    private var router: AccountRouter?
    
    var title_header = BehaviorRelay<String>(value:  "")
    var link_website = BehaviorRelay<String>(value:  "")
    
    func bind(view: AccountViewController, router: AccountRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    

    func makeAccountInforViewController() {
        router?.navigateToAccountInforViewController()
    }
    

    func makeToSettingAccountViewController(){
        router?.navigateToSettingAccountBusiness()
    }
    
    func makePrivacyViewController(){
        router?.navigateToPrivacyViewController(title_header: title_header.value, link_website: link_website.value)
    }
    
    func makePolicyViewController(){
        router?.navigateToPolicyViewController(title_header: title_header.value, link_website: link_website.value)
    }

    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
    func makeChangePasswordViewController(){
        router?.navigateToChangePasswordViewController()
    }
    
    func makeFeedBackViewController() {
        router?.navigateToFeedBackViewController()
    }
}
