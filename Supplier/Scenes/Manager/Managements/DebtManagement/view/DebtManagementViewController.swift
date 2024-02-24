//
//  DebtManagementViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DebtManagementViewController: UIViewController {
    
    var viewModel = DebtManagementViewModel()
    var router = DebtManagementRouter()
    
    @IBOutlet weak var view_receipt_bill: UIView!
    @IBOutlet weak var lbl_receipt_bill: UILabel!
    
    @IBOutlet weak var view_payment_bill: UIView!
    @IBOutlet weak var lbl_payment_bill: UILabel!
    
    
    
    @IBOutlet weak var btn_get_receipt_data: UIButton!
    
    @IBOutlet weak var btn_get_payment_data: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        firstSetup()
 
    }


    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    func firstSetup(){
        actionReceiptBill("")
    }
    
    @IBAction func actionReceiptBill(_ sender: Any) {
        changeHeader(btn: btn_get_receipt_data)

        let accountsReceivableViewController = AccountsReceivableViewController(nibName: "AccountsReceivableViewController", bundle: Bundle.main)
        addTopCustomViewController(accountsReceivableViewController, addTopCustom: 120)

        let accountsPayableViewControllerViewController = AccountsPayableViewController(nibName: "AccountsPayableViewController", bundle: Bundle.main)
        accountsPayableViewControllerViewController.remove()
    }
    
    @IBAction func actionPaymentBill(_ sender: Any) {
        changeHeader(btn: btn_get_payment_data)
      
        let accountsReceivableViewController = AccountsReceivableViewController(nibName: "AccountsReceivableViewController", bundle: Bundle.main)
        accountsReceivableViewController.remove()

        let accountsPayableViewControllerViewController = AccountsPayableViewController(nibName: "AccountsPayableViewController", bundle: Bundle.main)
        addTopCustomViewController(accountsPayableViewControllerViewController, addTopCustom: 120)
        
    }
    
    
    private func changeHeader(btn:UIButton){
        btn_get_payment_data.backgroundColor = ColorUtils.gray_200()
        btn_get_receipt_data.backgroundColor = ColorUtils.gray_200()
     
        btn_get_payment_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        btn_get_receipt_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
       
        btn.backgroundColor = ColorUtils.blue_000()
        btn.setTitleColor(ColorUtils.blue_700(),for: .normal)
    }
    
    
}
