//
//  NotificationViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 20/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class NotificationViewModel: BaseViewModel {
    private(set) weak var view: NotificationViewController?
    private var router: NotificationViewRouter?
    

    public var type : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var is_viewed : BehaviorRelay<Int> = BehaviorRelay(value: -1)
    public var page : BehaviorRelay<Int> = BehaviorRelay(value: 1)
    public var limit : BehaviorRelay<Int> = BehaviorRelay(value: LIMITED)
    
    public var dataArray : BehaviorRelay<[Notification]> = BehaviorRelay(value: [])
    public var dataFilter : BehaviorRelay<[Notification]> = BehaviorRelay(value: [])
    
    func bind(view: NotificationViewController, router: NotificationViewRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    

    func makePopViewController(){
        router?.navigateToPopViewController()
    }
}

//Mark: Call API
extension NotificationViewModel{
    func notifications() -> Observable<APIResponse> {
        return appServiceProvider.rx.request(.notifications(type: self.type.value, is_viewed: -1, page: page.value, limit: limit.value))
               .filterSuccessfulStatusCodes()
               .mapJSON().asObservable()
               .showAPIErrorToast()
               .mapObject(type: APIResponse.self)
       }
}
