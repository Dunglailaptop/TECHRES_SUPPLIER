//
//  SplashScreenViewController.swift
//  Seemt
//
//  Created by macmini_techres_03 on 07/04/2023.
//

import UIKit

class SplashScreenViewController: UIViewController {
    var viewModel = SplashScreenViewModel()
    var router = SplashScreenRouter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: router)
              
        
              if(ManageCacheObject.isLogin()){
                  dLog("Ready login...")
                  viewModel.makeMainViewController()
              }else{
                  dLog("Not Login...")
                  viewModel.makeLoginViewController()
              }

        
    }


 
}
