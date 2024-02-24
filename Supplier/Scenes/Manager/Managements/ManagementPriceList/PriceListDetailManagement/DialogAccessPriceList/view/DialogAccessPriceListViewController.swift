//
//  DialogAccessPriceListViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogAccessPriceListViewController: BaseViewController {

    var viewModel = PriceListDetailViewModel()
    var materialPriceList = MaterialPriceList()
    
    @IBOutlet weak var lbl_Name_Product: UILabel!
    @IBOutlet weak var root_view: UIView!
    var isCheckSpam:Bool = false
    
    var delegate: ShowInputMoneyPriceListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
        setup()
        // Do any additional setup after loading the view.
    }

    func setup(){
        let fullString = materialPriceList!.name + " Sẽ thay đổi giá"
        let attributedString = NSMutableAttributedString(string: fullString)
                   
                   // Định dạng phần "materialPriceList!.name" thành màu đỏ
        let range = (fullString as NSString).range(of: materialPriceList!.name)
                   attributedString.addAttribute(.foregroundColor, value: UIColor.gray_Bold_Text(), range: range)
                   
                   lbl_Name_Product.attributedText = attributedString
    }

    @IBAction func btn_cancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    

    @IBAction func btn_access(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                }

       
        viewModel.view?.callbackShowInputPriceList()

    }
}
