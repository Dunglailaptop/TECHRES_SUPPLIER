//
//  CustomViewModel.swift
//  TechresOrder
//
//  Created by Kelvin on 13/01/2023.
//

import UIKit

class CustomViewModel: BaseViewModel {
    private(set) weak var view: ViewController?
    private var router: CustomViewRouter?
    
    func bind(view: ViewController, router: CustomViewRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func makeLoginViewController(){
        router?.navigateToLoginViewController()
    }
    
}
