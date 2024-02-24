//
//  DialogConfrimAccessUpdateEmployeeViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogConfrimAccessUpdateEmployeeViewController: UIViewController {

    var viewModel = DetailEmployeeViewModel()
    var time: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        time = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }


    @objc func timerFired() {
           dismiss(animated: true)
        viewModel.makePopViewController()
       }

       // Don't forget to invalidate the timer when you're done with it, typically in the deinitializer or when you no longer need it.
       deinit {
           time?.invalidate()
       }

}
