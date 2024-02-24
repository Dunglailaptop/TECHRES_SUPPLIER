//
//  DialogChooseInputInventoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 31/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChooseInputInventoryViewController: UIViewController {
    
    var viewModel = CreateInventoryViewModel()
    
    @IBOutlet weak var title_choose_input: UILabel!
    @IBOutlet weak var txt_amount: UITextField!
    @IBOutlet weak var txt_percent: UITextField!
    
    @IBOutlet weak var btn_input_amount: UIButton!
    @IBOutlet weak var btn_input_percent: UIButton!
    
    @IBOutlet weak var btn_choose_input_amount: UIButton!
    @IBOutlet weak var btn_choose_input_percent: UIButton!
    
    @IBOutlet weak var root_view: UIView!
    
    var delegate: ChooseInputMoneyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
        setUpForTapOutSide()
        
        if viewModel.discount_percent.value == 0 {
            self.theFirst()
            txt_amount.text = viewModel.discount_amount.value > 0 ? Utils.stringVietnameseMoneyFormatWithNumber(amount: viewModel.discount_amount.value) : ""
        }else {
            self.theSecond()
            txt_percent.text = String((Int(viewModel.discount_percent.value)) > 0 ? String(Int(viewModel.discount_percent.value)) : "")
        }
    }
    
    @IBAction func actionChooseInputAmount(_ sender: Any) {
        viewModel.type_button_discount.accept(0) // 0 là chọn số tiền
        viewModel.discount_percent.accept(0)
        theFirst()
        txt_percent.text = ""
    }
    
    @IBAction func actionChooseInputPercent(_ sender: Any) {
        viewModel.type_button_discount.accept(1) // 1 là chọn %
        viewModel.discount_amount.accept(0)
        theSecond()
        txt_amount.text = ""
    }
    
    @IBAction func actionInputAmount(_ sender: Any) {
        self.presentModalInputMoneyViewController(current_money: viewModel.discount_amount.value)
    }
    
    @IBAction func actionInputPercent(_ sender: Any) {
        self.presentModalInputQuantityViewController(number: Float(viewModel.discount_percent.value))
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.delegate?.callBackCancelChooseInputMoney()
        dismiss(animated: true)
    }
    
    @IBAction func actionApproved(_ sender: Any) {
        if viewModel.discount_amount.value == 0{
            self.delegate?.callBackChooseInputMoney(amount: viewModel.discount_amount_display.value, percent: Float(viewModel.discount_percent.value))
        }else{
            self.delegate?.callBackChooseInputMoney(amount: viewModel.discount_amount.value, percent: Float(viewModel.discount_percent.value))
        }
        dismiss(animated: true)
    }
    
    
    private func theFirst() {
        btn_choose_input_amount.setImage(UIImage(named: "icon-radio-checked"), for: .normal)
        btn_choose_input_percent.setImage(UIImage(named: "icon-radio-unchecked"), for: .normal)
        btn_input_amount.isEnabled = true
        btn_input_percent.isEnabled = false
        txt_percent.text = ""
    }
    
    private func theSecond() {
        btn_choose_input_amount.setImage(UIImage(named: "icon-radio-unchecked"), for: .normal)
        btn_choose_input_percent.setImage(UIImage(named: "icon-radio-checked"), for: .normal)
        btn_input_amount.isEnabled = false
        btn_input_percent.isEnabled = true
        txt_amount.text = ""
    }
    
    private func setUpForTapOutSide() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view)
        if !root_view.bounds.contains(tapLocation) {
            dismiss(animated: true, completion: nil)
        }
    }
}
