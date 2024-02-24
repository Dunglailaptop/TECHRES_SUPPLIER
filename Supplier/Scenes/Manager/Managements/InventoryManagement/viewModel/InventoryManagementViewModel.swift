//
//  InventoryManagementViewModel.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay

class InventoryManagementViewModel: BaseViewModel {
    private(set) weak var view: InventoryManagementViewController?
    private var router: InventoryManagementRouter?
    
    // phân biệt loại màn hình tạo: 0 - tạo phiếu nhập kho, 1 - tạo phiếu huỷ kho
    public var btn_create_type : BehaviorRelay<Int> = BehaviorRelay(value: 0)
    
    func bind(view: InventoryManagementViewController, router: InventoryManagementRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makePopViewController(){
        router?.navigateToPopViewController()
    }
    
    func makeCreateInventoryViewController(){
        router?.navigateToCreateInventoryViewController(btnCreateType: btn_create_type.value)
    }
}
