//
//  DialogInputQuantityViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

class DialogInputQuantityViewController: BaseViewController {
    
    @IBOutlet weak var textField_Result: UILabel!
    @IBOutlet weak var btn_point: UIButton!
    @IBOutlet weak var root_view: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    
    var delegate:InputQuantityDelegate?
    var position:Int = 0
    var current_quantity:Float = 0
    var maxQuantity:Float = 999
    var minQuantity:Float = 0
    var textWarning:String = "Số lượng tối đa cho phép là"
    var result:Float = 0
    var is_sell_by_weight = 0
    var isHavePoint = 0
    var isCheckSpam:Bool = false
    var lblTitle:String = "NHẬP SỐ LƯỢNG"
    override func viewDidLoad() {
        super.viewDidLoad()
        root_view.round(with: .both, radius: 8)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
            tapGesture.cancelsTouchesInView = false
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
        // Do any additional setup after loading the view.
        lbl_title.text = lblTitle
        result = current_quantity
        if is_sell_by_weight == 1 {
            btn_point.isEnabled = true
            btn_point.isHidden = false
            if current_quantity == 0 {
                textField_Result.text = "0"
                isHavePoint = 0
            }else {
                if current_quantity.truncatingRemainder(dividingBy: 1) > 0{
                    isHavePoint = 1
                    textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: Utils.removeStringVietnameseFormatStringFloat(amount: String(format: "%.2f", current_quantity)))
                } else {
                    isHavePoint = 0
                    textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: current_quantity)
                }
            }
        }else{
            btn_point.isEnabled = false
            btn_point.isHidden = true
            isHavePoint = 0
            textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: current_quantity)
        }
    }
    
    @IBAction func actionDone(_ sender: Any) {
        if (self.isHavePoint == 0){
            if (result < minQuantity){
                if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                    self.isCheckSpam = false
                }
                JonAlert.show(message: String(format: "Số lượng tối thiểu cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: minQuantity)), andIcon: UIImage(named: "icon-warning"), duration: 2.5)
            }else{
                delegate?.callbackInputQuantity(number: Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!), position: position)
                dismiss(animated: true, completion: nil)
            }
        }else{
            if (Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) < minQuantity){
                if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                    self.isCheckSpam = false
                }
                JonAlert.show(message: String(format: "Số lượng tối thiểu cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: minQuantity)), andIcon: UIImage(named: "icon-warning"), duration: 2.5)
            }else {
                delegate?.callbackInputQuantity(number: Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!), position: position)
                dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func actionPoint(_ sender: Any) {
        if (self.isHavePoint == 1) {
            return
        } else {
            if (Int(result) >= Int(maxQuantity)){
                self.textField_Result.text! = Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)
                result = maxQuantity
                self.isHavePoint = 0
                if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                    self.isCheckSpam = false
                }
                JonAlert.show(message: String(format: "Số lượng tối đa cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)), andIcon: UIImage(named: "icon-warning"), duration: 2.5)
            } else {
                self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: result) + "."
                self.isHavePoint = 1
            }
        }
    }
    
    @IBAction func actionCaculator(_ sender: UIButton) {
        if(sender.titleLabel?.text == "C"){
            self.isHavePoint = 0
            result = 0
        }else if (sender.titleLabel?.text == "Tăng"){
            if (isHavePoint == 0){
                if (result > maxQuantity){
                    result = maxQuantity
                } else {
                    result += 1
                }
            } else {
                if (Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) > maxQuantity){
                    self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)
                    result = maxQuantity
                    self.isHavePoint = 0
                    JonAlert.show(message: String(format: "Số lượng tối đa cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                } else {
                    self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) + 0.01)
                }
            }
        }else if (sender.titleLabel?.text == "Giảm"){
            if (isHavePoint == 0){
                if (result - 1 < minQuantity){
                    if isCheckSpam { return }
                    isCheckSpam = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                        self.isCheckSpam = false
                    }
                    JonAlert.show(message: String(format: "Số lượng tối thiểu cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: minQuantity)), andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                    result = minQuantity
                } else if (result == 0){
                    result = 0
                    self.isHavePoint = 0
                } else {
                    result -= 1
                }
            } else {
                if (Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) < minQuantity){
                    if isCheckSpam { return }
                    isCheckSpam = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                        self.isCheckSpam = false
                    }
                    self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: minQuantity)
                    JonAlert.show(message: String(format: "Số lượng tối thiểu cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: minQuantity)), andIcon: UIImage(named: "icon-warning"), duration: 2.5)
                } else if (Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) <= 0){
                    self.textField_Result.text = "0"
                    result = 0
                    self.isHavePoint = 0
                    dLog(123)
                } else {
                    self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) - 0.01)
                }
            }
        }else if(sender.titleLabel?.text == "-1"){
            if (isHavePoint == 0){
                let text_result = String(Utils.removeStringVietnameseFormatMoney(amount: self.textField_Result.text!))
                let leng_result = (text_result.count) - 1;
                    if(!(self.textField_Result.text?.isEmpty)!){
                        let subStr = text_result.prefix(leng_result)
                        result = Float(subStr) ?? 0
                        if((self.textField_Result.text?.isEmpty)! ){
                            result = 0
                            self.isHavePoint = 0
                        }else if Float(text_result)! == 0 {
                            result = 0
                            self.isHavePoint = 0
                        }
                    }else{
                        if Int(text_result)! == 0 {
                            result = 0
                            self.isHavePoint = 0
                        }
                    }
            } else {
                let text_result = self.textField_Result.text!
                let leng_result = (self.textField_Result.text!.count) - 1
                    if(!(self.textField_Result.text?.isEmpty)!){
                        let subStr = text_result.prefix(leng_result)
                        self.textField_Result.text = String(subStr)
                        if((self.textField_Result.text?.isEmpty)! ){
                            result = 0
                            self.isHavePoint = 0
                        } else if (text_result.filter({ $0 == "." }).count == 0){
                            self.isHavePoint = 0
                        }
                    }else{
                        if Int(self.textField_Result.text!)! == 0 {
                            result = 0
                            self.isHavePoint = 0
                        }
                    }
            }
           
        }else if (sender.titleLabel?.text == "%"){

        }else if(sender.titleLabel?.text == "7"){
            if isHavePoint == 1 {
                self.textField_Result.text! += "7"
            }else {
                if result == 0 {
                    result = 7
                } else {
                    result = result * 10 + 7
                }
            }
        }else if(sender.titleLabel?.text == "8"){
           if isHavePoint == 1 {
                self.textField_Result.text! += "8"
            }else {
                if result == 0 {
                    result = 8
                } else {
                    result = result * 10 + 8
                }
            }
        }else if(sender.titleLabel?.text == "9"){
            if isHavePoint == 1 {
                self.textField_Result.text! += "9"
            } else {
                if result == 0 {
                    result = 9
                } else {
                    result = result * 10 + 9
                }
            }      }
        else if(sender.titleLabel?.text == "4"){
            if isHavePoint == 1 {
                self.textField_Result.text! += "4"
            } else {
                if result == 0 {
                    result = 4
                } else {
                    result = result * 10 + 4
                }
            }
        }else if(sender.titleLabel?.text == "5"){
           if isHavePoint == 1 {
               self.textField_Result.text! += "5"
           }else {
               if result == 0 {
                   result = 5
               } else {
                   result = result * 10 + 5
               }
           }
        }
        else if(sender.titleLabel?.text == "6"){
           if isHavePoint == 1 {
                self.textField_Result.text! += "6"
            } else {
                if result == 0 {
                    result = 6
                } else {
                    result = result * 10 + 6
                }
            }
        }else if(sender.titleLabel?.text == "1"){
            if isHavePoint == 1 {
                self.textField_Result.text! += "1"
            } else {
                if result == 0 {
                    result = 1
                } else {
                    result = result * 10 + 1
                }
            }
        }else if(sender.titleLabel?.text == "2"){
           if isHavePoint == 1 {
               self.textField_Result.text! += "2"
           }else {
               if result == 0 {
                   result = 2
               } else {
                   result = result * 10 + 2
               }
           }
        }else if(sender.titleLabel?.text == "3"){
           if isHavePoint == 1 {
               self.textField_Result.text! += "3"
            } else {
                if result == 0 {
                    result = 3
                } else {
                    result = result * 10 + 3
                }
            }
        }else if(sender.titleLabel?.text == "0"){
           if isHavePoint == 1 {
               self.textField_Result.text! += "0"
           } else {
               if result == 0 {
                   result = 0
               } else {
                   result = result * 10
               }
           }
        }else if(sender.titleLabel?.text == "000"){
            if isHavePoint == 1 {
                if (Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!) == 0){
                    self.textField_Result.text! = "0"
                    self.isHavePoint = 0
                } else {
                    self.textField_Result.text! += "000"
                }
            }else{
                result = result * 1000
            }
        }
        
         if (Int(result) > Int(maxQuantity)){
            self.textField_Result.text! = Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)
            result = maxQuantity
            if isCheckSpam {
                return
            }
            isCheckSpam = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2500)) {
                self.isCheckSpam = false
            }
            JonAlert.show(message: String(format: "Số lượng tối đa cho phép là %@", Utils.stringQuantityFormatWithNumberFloat(amount: maxQuantity)),andIcon: UIImage(named: "icon-warning"), duration: 2.5)
        } else {
            if (isHavePoint == 0){
                self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: result)
            } else {
                let originalString = self.textField_Result.text
                if let dotIndex = originalString?.firstIndex(of: ".") {
                    self.textField_Result.text = (originalString?[..<dotIndex])! + "." + (originalString?[dotIndex...].dropFirst().prefix(2))!
                } else {
                    result = Utils.removeStringVietnameseFormatStringFloat(amount: self.textField_Result.text!)
                    self.textField_Result.text = Utils.stringQuantityFormatWithNumberFloat(amount: result)
                    self.isHavePoint = 0
                }
            }
        }
    }
}
