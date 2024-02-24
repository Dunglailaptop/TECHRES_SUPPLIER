//
//  DialogInputMoneyViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

class DialogInputMoneyViewController: BaseViewController {
    @IBOutlet weak var lbl_result: UILabel!
    @IBOutlet weak var btn_suggestion_one: UIButton!
    @IBOutlet weak var btn_suggestion_two: UIButton!
    @IBOutlet weak var btn_suggestion_three: UIButton!
    @IBOutlet weak var btn_suggestion_four: UIButton!
    @IBOutlet weak var btn_suggestion_five: UIButton! 
    @IBOutlet weak var btn_suggestion_six: UIButton!
    
    @IBOutlet weak var lbl_enter_money_title: UILabel!
    @IBOutlet weak var lbl_accept_title: UIButton!
    @IBOutlet weak var lbl_money_reference_title: UILabel!
    
    @IBOutlet weak var root_view: UIView!
    
    var position:Int = 0
    var total_amount:Int = 0
    var row:Int = 0
    var delegate:InputMoneyDelegate?
    var delegatePrice:InputMoneyDelegatePriceList?
    var materialPriceList = MaterialPriceList()
    
    var money_suggestion_one:Int = 0
    var money_suggestion_two:Int = 0
    var money_suggestion_three:Int = 0
    var money_suggestion_four:Int = 0
    var money_suggestion_five:Int = 0
    var money_suggestion_six:Int = 0
    var result:Int = 0
    var minMoney = 0
    var maxMoney = 0
    var current_money:Int = 0
    var isCheckSpam:Bool = false
    var isEnterZeroMoney:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
        // Do any additional setup after loading the view.
        lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: total_amount)
        
        btn_suggestion_one.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 50000), for: UIControl.State.normal)
        
        btn_suggestion_two.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 100000), for: UIControl.State.normal)
        
        btn_suggestion_three.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 200000), for: UIControl.State.normal)
        
        btn_suggestion_four.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 300000), for: UIControl.State.normal)
        
        btn_suggestion_five.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 500000), for: UIControl.State.normal)
        
        btn_suggestion_six.setTitle(Utils.stringVietnameseMoneyFormatWithNumber(amount: 1000000), for: UIControl.State.normal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
                tapGesture.cancelsTouchesInView = false
//                view.superview?.addGestureRecognizer(tapGesture) // Attach to the superview
                // OR
                 UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view)
        if !root_view.bounds.contains(tapLocation) {
                // Handle touch outside of the view
                dismiss(animated: true, completion: nil)
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dLog(isEnterZeroMoney)
        result = current_money
        if current_money == 0 {
            lbl_result.text = "0"
        } else {
            lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
        }
    }

    @IBAction func actionCalculator(_ sender: Any) {
        if((sender as AnyObject).titleLabel?.text == "ĐỒNG Ý"){
            if (self.result) > maxMoney {
                JonAlert.show(message: String(format: "Giá trị tối đa %@", Utils.stringVietnameseMoneyFormatWithNumber(amount: maxMoney)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                return
            } else {
                dLog(self.result)
                dLog(minMoney)
                dLog(isEnterZeroMoney)
                if (self.result) != 0 && (self.result) < minMoney && isEnterZeroMoney {
                    dLog(self.result)
                    dLog(minMoney)
                    dLog(isEnterZeroMoney)
                    JonAlert.show(message: String(format: "Giá trị tối thiểu bằng 0 hoặc %@", Utils.stringVietnameseMoneyFormatWithNumber(amount: minMoney)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                    return
                } else if (self.result) < minMoney && !isEnterZeroMoney {
                    JonAlert.show(message: String(format: "Giá trị tối thiểu %@", Utils.stringVietnameseMoneyFormatWithNumber(amount: minMoney)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                    return
                }
                if materialPriceList!.id > 0{
                    delegatePrice?.callbackInputPriceList(amount: result, materialPriceList: materialPriceList!)
//                    dismiss(animated: true, completion: nil)
                }else {
                    delegate?.callBackInputMoney(amount: result, position: position)
                    dismiss(animated: true, completion: nil)
                }
                
            }
        }else if((sender as AnyObject).titleLabel?.text == "7"){
            if result == 0{
                result = result + 7
            }
            else{
                result = result*10 + 7
            }
            
        }else if((sender as AnyObject).titleLabel?.text == "8"){
            if result==0{
                result = result + 8
            }
            else{
                result = result*10 + 8
            }
        } else if((sender as AnyObject).titleLabel?.text == "9") {
            if result==0 {
                result = result + 9
            }
            else {
                result = result*10 + 9
            }
            
        } else if((sender as AnyObject).titleLabel?.text == "4"){
            if result==0{
                result = result + 4
            }
            else{
                result = result*10 + 4
            }
        }else if((sender as AnyObject).titleLabel?.text == "5"){
            if (self.result) > maxMoney {
                return
            }
            if result==0{
                result = result + 5
            }
            else{
                result = result*10 + 5
            }
        }else if((sender as AnyObject).titleLabel?.text == "6"){
            if result==0{
                result = result + 6
            }
            else{
                result = result*10 + 6
            }
        }else if((sender as AnyObject).titleLabel?.text == "1"){
            if result==0{
                result = result + 1
            }
            else{
                result = result*10 + 1
            }
        }else if((sender as AnyObject).titleLabel?.text == "2"){
            if result==0{
                result = result + 2
            }
            else{
                result = result*10 + 2
            }
        }else if((sender as AnyObject).titleLabel?.text == "3"){
            if result==0{
                result = result + 3
            }
            else{
                result = result*10 + 3
            }
        }else if((sender as AnyObject).titleLabel?.text == "0"){
            if result==0{
                result = 0
            }
            else{
                result = result*10
            }
        }else if((sender as AnyObject).titleLabel?.text == "000"){
            result = result*1000
        }else if((sender as AnyObject).titleLabel?.text == "C"){
            result = 0
        }else if((sender as AnyObject).titleLabel?.text == ""){
            self.result = 0
        }
        if (result > maxMoney){
           result = maxMoney
           self.lbl_result.text! = Utils.stringVietnameseMoneyFormatWithNumber(amount: maxMoney)
           if isCheckSpam {
               return
           }
           isCheckSpam = true
           DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
               self.isCheckSpam = false
           }
           JonAlert.show(message: String(format: "Số tiền tối đa cho phép là %@", Utils.stringVietnameseMoneyFormatWithNumber(amount: maxMoney)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
        } else {
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
        }
    }
    
    @IBAction func btn_backSpace(_ sender: Any) {
        if result < 10 {
            result = 0
        }
        else {
            result /= 10
        }
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionOne(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 50000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionTwo(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 100000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionThree(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 200000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionFour(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 300000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionFive(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 500000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    @IBAction func actionSuggestionSix(_ sender: Any) {
        if (self.result) > maxMoney {
            return
        }
        result = 1000000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: result)
    }
    
    
    func actionSuggestionMoney(money_suggestion:Int){
        
    }
    

}
