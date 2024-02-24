//
//  LoadWebLinkViewModel.swift
//  ALOLINE
//
//  Created by Kelvin on 06/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class LoadWebLinkViewModel: BaseViewModel {

    
    public var dataArraySession : BehaviorRelay<[String]> = BehaviorRelay(value: [])
//    public var dataArrayLevel : BehaviorRelay<[LevelCard]> = BehaviorRelay(value: [])
//    public var dataLevelCard : BehaviorRelay<LevelCard> = BehaviorRelay(value: LevelCard.init()!)
    
    private(set) weak var view: LoadWebLinkViewController?
    private var router: LoadWebLinkRouter?
    
    var restaurant_id = 0
//    var dataCard = [LevelCard]()
    
    func bind(view: LoadWebLinkViewController, router: LoadWebLinkRouter){
        self.view = view
        self.router = router
        
        self.router?.setSourceView(view)
    }
    
}
