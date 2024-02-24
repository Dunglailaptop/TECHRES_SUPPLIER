//
//  CaculatorInputMoneyViewController.swift
//  TechresOrder
//
//  Created by Kelvin on 18/01/2023.
//

import UIKit
import JonAlert
class CaculatorInputMoneyViewController: BaseViewController {
    
    @IBOutlet weak var btn_number_1: UIButton!
    @IBOutlet weak var btn_number_2: UIButton!
    @IBOutlet weak var btn_number_3: UIButton!
    @IBOutlet weak var btn_number_4: UIButton!
    @IBOutlet weak var btn_number_5: UIButton!
    @IBOutlet weak var btn_number_6: UIButton!
    @IBOutlet weak var btn_number_7: UIButton!
    @IBOutlet weak var btn_number_8: UIButton!
    @IBOutlet weak var btn_number_9: UIButton!
    @IBOutlet weak var btn_number_0: UIButton!
    
    @IBOutlet weak var btn_increase: UIButton!
    
    @IBOutlet weak var btn_Decrease: UIButton!
    //    @IBOutlet weak var btn_number_000: UIButton!
    @IBOutlet weak var btn_clear: UIButton!
    @IBOutlet weak var btn_space_back: UIButton!
    @IBOutlet weak var btn_dot: UIButton!
    
    
    @IBOutlet weak var btn_Price: UIButton!
    
    @IBOutlet weak var btn_Percent: UIButton!
    @IBOutlet weak var lbl_result: UILabel!
  
    
    
//    @IBOutlet weak var lbl_enter_money_title: UILabel!
    @IBOutlet weak var btn_accept: UIButton!
//    @IBOutlet weak var lbl_money_reference_title: UILabel!
    
    @IBOutlet weak var root_view: UIView!
    
    var total_amount:Int = 0
    var row:Int = 0
    var delegate:CalculatorMoneyDelegate?
    
    var MaterialPrice = MaterialPriceList()
   
    
    
    var result:Int = 0
    var checkMoneyFee = 0
    var limitMoneyFee = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        root_view.round(with: .both, radius: 10)
        
        // Do any additional setup after loading the view.
        lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(total_amount))
        
        
      
        setUpLayout()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        //view.superview?.addGestureRecognizer(tapGesture) // Attach to the superview
        // OR
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window

    }
    @objc private func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view)
        if !root_view.bounds.contains(tapLocation) {
               // Handle touch outside of the view
               dismiss(animated: true, completion: nil)
           }
    }

    
    
    
    private func setUpLayout(){
        btn_number_0.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_1.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_2.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_3.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_4.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_5.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_6.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_7.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_8.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_number_9.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
//        btn_number_000.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_clear.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_space_back.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_accept.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_dot.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_increase.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_Decrease.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_Price.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        btn_Percent.addShadow(shadowOffset: CGSize(width: 1, height: 2), shadowOpacity: 0.3, shadowRadius: 2, color: UIColor(.black))
        let cornerRadius: CGFloat = 4 // thay 'b' bằng giá trị bán kính mong muốn
               let maskLayer = CAShapeLayer()

               // Cạnh trên bên phải
               maskLayer.path = UIBezierPath(roundedRect: btn_accept.bounds,
                                             byRoundingCorners: [.topRight],
                                             cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath

               // Cạnh dưới bên phải
               maskLayer.path = UIBezierPath(roundedRect: btn_accept.bounds,
                                             byRoundingCorners: [.bottomRight],
                                             cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath

               btn_accept.layer.mask = maskLayer
      
    }
    
    
  
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        limitMoneyFee = checkMoneyFee == 1 ? 1000000000 : 500000000
//        lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float( String(format: "%d", result))!)
        lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double( String(format: "%d", result))!)
    }
    
    @IBAction func actionClosed(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func actionCalculator(_ sender: Any) {
        
        switch (sender as AnyObject).titleLabel?.text{
            case "1":
                handleNumberInput(numberInput: 1)
                break
            case "2":
                handleNumberInput(numberInput: 2)
                break
            case "3":
                handleNumberInput(numberInput: 3)
                break
            case "4":
                handleNumberInput(numberInput: 4)
                break
            case "5":
                handleNumberInput(numberInput: 5)
                break
            case "6":
                handleNumberInput(numberInput: 6)
                break
            case "7":
                handleNumberInput(numberInput: 7)
                break
            case "8":
                handleNumberInput(numberInput: 8)
                break
            case "9":
                handleNumberInput(numberInput: 9)
                break
            case "0":
                handleNumberInput(numberInput: 0)
                break
            case "C":
                clear()
                break
            default:
                return
        }
        
        
//        else if((sender as AnyObject).titleLabel?.text == ""){
//
//            self.lbl_result.text = "0"
//            self.result = 0
//        }
        
    }
    
    private func clear(){
        result = 0
        self.lbl_result.text = "0"
    }
    
    
    
    
    private func handleIncrease(){
        
        result = Int((self.lbl_result.text?.trim().replacingOccurrences(of: ",", with: ""))!)!
        
        result += 1
        checkLimitMoneyFee(amount: result)
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(result))
       
        dLog(result)

    }
    
    private func handleDecrease() {
        result = Int((self.lbl_result.text?.trim().replacingOccurrences(of: ",", with: ""))!)!
        
        result -= 1
        checkLimitMoneyFee(amount: result)
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(result))
       
        dLog(result)
    }
    
    // Action button add new
    
    @IBAction func btn_action_increase(_ sender: Any) {
        handleIncrease()
    }
    
    
    @IBAction func btn_action_Decrease(_ sender: Any) {
        handleDecrease()
    }
    
    @IBAction func btn_accept_price(_ sender: Any) {
        handleEqualOperator()
    }
    
    ///
    
    private func handleEqualOperator(){
        if (self.result) > limitMoneyFee {
            // Đổi thành toast message
            Toast.show(message: String(format: "Số tiền tối đa cho phép là %@",  Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(limitMoneyFee))), controller: self)
            return
        } else {
            if (self.result) < checkMoneyFee {
               
                // Đổi thành toast message
                Toast.show(message:  String(format: "Số tiền tối thiểu phải %@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(checkMoneyFee))), controller: self)
                return
            }
            delegate?.callBackCalculatorMoney(amount: result, position: row,MaterialId: MaterialPrice?.id ?? 0)
//            NotificationCenter.default.post(name: NSNotification.Name("GETAPIUPDATE"), object: nil)
            dismiss(animated: false, completion: nil)
        }
    }
    
    private func handleNumberInput(numberInput: Int){
        if result==0{
            result = result + numberInput
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(result))
        }
        else{
            result = result*10 + numberInput
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(result))
            checkLimitMoneyFee(amount: result)
        }
    }
    
    private func handleNumber000(){
        result = result*1000
        self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(result))
        checkLimitMoneyFee(amount: result)
    }
    
    private func checkLimitMoneyFee(amount:Int){
        if (self.result) > limitMoneyFee {
            result = limitMoneyFee
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(limitMoneyFee))
        }
    }
    
    @IBAction func btn_backSpace(_ sender: Any) {

        if result < 10 {
            result = 0
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Float(result))
        }
        else {
            result /= 10
            self.lbl_result.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(result))
        }
    }
    
   
    
    
    func actionSuggestionMoney(money_suggestion:Int){
        
    }
    

}
