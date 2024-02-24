//
//  FeedBackViewModel.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import JonAlert
class FeedBackViewModel:BaseViewModel{
    private (set) weak var viewController: FeedBackViewController?
    private var router: FeedBackRouter?
    var name = BehaviorRelay<String>(value: ManageCacheObject.getCurrentUser().name)
    var email = BehaviorRelay<String>(value: "")
    var phone = BehaviorRelay<String>(value: ManageCacheObject.getCurrentUser().phone_number)
    var type = BehaviorRelay<Int>(value: -1)
    var describe = BehaviorRelay<String>(value: "")
    var isMessageShowing = BehaviorRelay<Bool>(value: false)
    
    private func showWarningMessage(content:String){
        if(!isMessageShowing.value){
            JonAlert.show(message: content ?? "",
            andIcon: UIImage(named: Constants.WARNING_MESSAGE.ICON_WARNING),
            duration: 2.0)
            isMessageShowing.accept(true)
        }

    }
    
    
    func bind(view:FeedBackViewController, router: FeedBackRouter){
        self.viewController = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
        
}

extension FeedBackViewModel{
    func sendFeedBack() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.sendFeedBack(name: name.value, email: email.value, phone: phone.value, project_id: String(Constants.PROJECT_IDS.PROJECT_ID_SUPPLIER), type: type.value, describe: describe.value))
            .filterSuccessfulStatusCodes()
            .mapJSON().asObservable()
            .showAPIErrorToast().mapObject(type: APIResponse.self)
    }
}
