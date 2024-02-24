//
//  ReceiptAndPaymentCatetoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ReceiptAndPaymentCatetoryViewController: BaseViewController {
    var viewModel = ReceiptAndPaymentCategoryViewModel()
    var router = ReceiptAndPaymentCategoryRouter()
    var callBackToPopViewController: () -> Void = {}
    
    @IBOutlet weak var lbl_active_hint: UILabel!
    @IBOutlet weak var lbl_deactive_hint: UILabel!
    
    
    //-----IBOutlet of sub-header
    @IBOutlet weak var lbl_active: UILabel!
    @IBOutlet weak var active_bottomLine: UILabel!
    
    
    @IBOutlet weak var lbl_deactive: UILabel!
    @IBOutlet weak var deactive_bottomLine: UILabel!
    
    
    //-----IBOutlet of tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view_empty_data: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
        
        // Do any additional setup after loading the view.
    
        lbl_active_hint.roundCorners(corners: .allCorners, radius: 20)
        lbl_deactive_hint.roundCorners(corners: .allCorners, radius: 20)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actionToGetActiveData("")
    }


    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
   
    
    @IBAction func actionToGetCategoryData(_ sender: Any) {
        getReceiptAndPaymenCategory()
    }
    
    @IBAction func actionToGetReceiptData(_ sender: Any) {
        /*
            type = 0 -> phiếu thu
            type = 1 -> phiếu chi
         */
        viewModel.makeReceiptAndPaymentViewController(screenType:0)
    }
    
    @IBAction func actionToGetPaymentData(_ sender: Any) {
        /*
            type = 0 -> phiếu thu
            type = 1 -> phiếu chi
         */
        viewModel.makeReceiptAndPaymentViewController(screenType:1)
    }
    
    @IBAction func actionToGetActiveData(_ sender: Any) {
        changeSubHeader(bottomLine: active_bottomLine, label: lbl_active,labelHint: lbl_active_hint)
        viewModel.is_hidden.accept(0)
        getReceiptAndPaymenCategory()
    }
    
    @IBAction func actionToGetDeactiveData(_ sender: Any) {
        changeSubHeader(bottomLine: deactive_bottomLine, label: lbl_deactive,labelHint: lbl_deactive_hint)
        viewModel.is_hidden.accept(1)
        getReceiptAndPaymenCategory()
    }
    
    
    @IBAction func actionNavigateToCreateReceiptAndPaymentCategoryViewCotroller(_ sender: Any) {
        viewModel.makeCreateReceiptAndPaymentCategoryViewController()
    }
    
    
    
    
    private func changeSubHeader(bottomLine:UILabel, label:UILabel,labelHint:UILabel){
        active_bottomLine.backgroundColor = .white
        lbl_active_hint.backgroundColor = ColorUtils.gray_400()
        deactive_bottomLine.backgroundColor = .white
        lbl_deactive_hint.backgroundColor = ColorUtils.gray_400()
        lbl_active.textColor = ColorUtils.gray_600()
        lbl_deactive.textColor = ColorUtils.gray_600()
        label.textColor = ColorUtils.blue_700()
        labelHint.backgroundColor = ColorUtils.orange_700()
        bottomLine.backgroundColor = ColorUtils.blue_700()
        bottomLine.roundCorners([.topLeft,.topRight], radius: 8)
    }
    
    
}
