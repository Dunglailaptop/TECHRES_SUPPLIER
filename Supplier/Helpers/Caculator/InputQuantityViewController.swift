//
//  InputQuantityViewController.swift
//  TechresOrder
//
//  Created by Kelvin on 18/01/2023.
//

import UIKit
import JonAlert

class InputQuantityViewController: BaseViewController {
    @IBOutlet weak var textField_Result: UILabel!
    var delegate:CaculatorDelegate?
    var max_quantity:Double?
    var min_quantity:Double?
    var result:Double = 0.0
    var isAllowDecimalNumber = true
    var decimalDigit = 2
    var titleCalculator:String = ""
    weak var timer: Timer?
    var isMessageShowing:Bool = false
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var calculator_view: UIView!
    @IBOutlet weak var result_view: UIView!
    @IBOutlet weak var check_view: UIView!
    
    @IBOutlet weak var btn_add_decimal_point: UIButton!
    @IBOutlet weak var money_percent_convert_stack_view: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] _ in
            self?.isMessageShowing = false
        }
    }
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.calculator_view)
        if !calculator_view.bounds.contains(tapLocation) {
            actionClosed("")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        textField_Result.text = Utils.formatQuantityToStringWithNumberDouble(quantity: result) == ""
        ? "0"
        : stringVietnameseMoneyFormatWithDouble(amount: result)
        lbl_title.text = titleCalculator
        if !isAllowDecimalNumber {
            money_percent_convert_stack_view.isHidden = true
            money_percent_convert_stack_view.heightAnchor.constraint(equalToConstant: 0).isActive = true
            calculator_view.heightAnchor.constraint(equalToConstant: 430).isActive = true
            btn_add_decimal_point.isHidden = true
        }
    }
    
    private func showWarningMessage(content:String = ""){
        if(!isMessageShowing){
            JonAlert.show(message: content,
                          andIcon: UIImage(named: "icon-warning"),
                          duration: 2.0)
            isMessageShowing = true
        }
        
    }
    
    
    @IBAction func actionClosed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func actionCaculator(_ sender: UIButton) {
        
        switch (sender as AnyObject).titleLabel?.text{
                
            case "C":
                clear()
                break
            
            case "=":
                getResult()
                break
            
            case "-1":
                backSpace()
                break
        
            case "1":
                handleNumberInput(numberInput: "1")
                break
            
            case "2": 
                handleNumberInput(numberInput: "2")
                break
            
            case "3":
                handleNumberInput(numberInput: "3")
                break
            
            case "4":
                handleNumberInput(numberInput: "4")
                break
            
            case "5":
                handleNumberInput(numberInput: "5")
                break
            
            case "6":
                handleNumberInput(numberInput: "6")
                break
            
            case "7":
                handleNumberInput(numberInput: "7")
                break
            
            case "8":
                handleNumberInput(numberInput: "8")
                break
            
            case "9":
                handleNumberInput(numberInput: "9")
                break
            
            case "0":
                handleNumberInput(numberInput: "0")
                break
       
            case ".":
                addDecimalPoint()
                break
            
            case "%":
                convertToPercentFormat()
                break
            
            case "$":
                convertToMoneyFormat()
                break
            
            case "Tăng":
                increaseByOne()
                break
            
            case "Giảm":
                decreaseByOne()
                break
            case "000":
                break
                
            default:
                return
        }



    }
    
    private func getResult(){
        delegate?.callbackToGetResult(number: result)

        dismiss(animated: true, completion: nil)
    }
    
        
    private func clear(){
        result = 0
        self.textField_Result.text = "0"
    }
    
    
    private func backSpace(){
        /*
            khi user click backspace, thì lấy kết qủa từ màn hình ra sau đó chỉ remove đi ký tự cuối cùng.
            Remove đến khi ký tự cuối cùng của chuỗi là "." thì ta replace lun.
            
            nếu chuổi là rỗng thì ta cho result = 0.0, ngược thì ép chuỗi về kiểu Float
            last step: show result ra màn hình bằng hàm stringVietnameseMoneyFormatWithDouble
         */
        var resultText = String(textField_Result.text!.dropLast())

        if(resultText.last == "."){
            resultText = resultText.replacingOccurrences(of: ".", with: "")
        }
        result = resultText == "" ? 0.0 : Double(resultText.replacingOccurrences(of: ",", with: "")) ?? 0

        textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
    }
    
    private func handleNumberInput(numberInput: String){
        //Nếu chữ cái đầu tiên là số 0 thì remove đi ký tự số 0
        if (textField_Result.text?.first == "0"){
            textField_Result.text!.removeFirst()
        }
        //case: số thập phần > 1 such as 0.9393
        if(textField_Result.text?.first == "."){
            textField_Result.text!.insert("0", at: textField_Result.text!.startIndex)
        }
        textField_Result.text?.append(numberInput)
        checkDecimalDigit()
        checkMaximumQuantity()
        checkMinimumQuantity()
    }
    
    private func addDecimalPoint(){
        if let isDecimalExisting = textField_Result.text?.contains(where: {(char) -> Bool in char == "."}), !isDecimalExisting{
            textField_Result.text?.append(".")
        }
        result = Double(textField_Result.text!.replacingOccurrences(of: ",", with: "")) ?? 0
    }
    
    
    private func checkDecimalDigit(){
        /*
            hàm dùng để lấy đúng 2 chữ số thập phân cuối cùng (decimal places)
            step1: lấy chuổi kết quả từ màn hình sau đó bỏ đi dấu "," và gán lại vào result dưới dạng double
            step2: lấy đúng number of digit theo yêu cầu
            step3: gắn lại kết quả hiển thị in form of vietnames string
         */
        
        var figureNumber = textField_Result.text!.replacingOccurrences(of: ",", with: "")
        if figureNumber.contains(where: {(char) -> Bool in char == "."}){
            if let index = figureNumber.firstIndex(of: "."){
                let distance = figureNumber.distance(from: figureNumber.startIndex, to: index)
                figureNumber = String(figureNumber.prefix(distance + decimalDigit + 1)) //step2
             }
        }

        result = Double(figureNumber) ?? 0
        textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
    }
    
 
    private func stringVietnameseMoneyFormatWithDouble(amount: Double)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = (decimalDigit + 1)
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@", strAmount ?? "0")
    }
    
    


    private func checkMaximumQuantity(){
        guard let max_quantity = max_quantity else {return}
        if (self.result) > max_quantity {
            result = max_quantity
            self.textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
            showWarningMessage(content: String(format: "Giá trị tối đa là %@", self.textField_Result.text ?? ""))
        }
    }
    

    /*Note: làm chơi cho vui để qua mặt QC với BA*/
    private func checkMinimumQuantity(){
        guard let min_quantity = min_quantity else {return}
        if (self.result) < min_quantity {
            showWarningMessage(content: String(format: "Giá trị tối thiểu là 0 hoặc %@", stringVietnameseMoneyFormatWithDouble(amount: min_quantity)))
            
        }
    }
    
    
}


extension InputQuantityViewController{
    private func convertToPercentFormat(){
        /*
         nếu số đó là kiểu doulbe 0.00 thì ko làm gì cả
         
         nếu số đó là số integer thì thêm dấu . và 2 số 0
         */
        if (floor(result) == result){
//            if let isDecimalExisting = textField_Result.text?.contains(where: {(char) -> Bool in char == "."}), !isDecimalExisting{
//                textField_Result.text?.append(".")
//                for _ in 0 ..< decimalDigit {
//                    textField_Result.text?.append("0")
//                }
//
//            }
            addDecimalPoint()
        }
    }
    
    private func convertToMoneyFormat(){
        result = Double(Int(result))
        textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
    }
    
    private func increaseByOne(){
        //Nếu số đó là integer
        if (floor(result) == result){
            result += 1
            textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
        }else{
            
            /*
             nếu số là kiểu double thì tăng theo số decimal digit của số đó
             ex:
                case: 5.1 -> += 0.1
                case: 5.15 -> += 0.01
                case: 5.156 -> += 0.001
                case: 5.n -> += 0.("n-1" số 0)
             */
            
            var figureNumber = textField_Result.text!.replacingOccurrences(of: ",", with: "")
            var decimalDigit = 0
            var increaseBy = ""
            if figureNumber.contains(where: {(char) -> Bool in char == "."}){
                if let index = figureNumber.firstIndex(of: "."){
                    let distance = figureNumber.distance(from: figureNumber.startIndex, to: index)
                    decimalDigit = figureNumber.count - distance - 1
                    
                 }
            }
            increaseBy.append("0.")
            decimalDigit -= 1 //- 1 là vì decimalDigit cuối cùng là 1 và ta có (n-1) số 0
            
            if (decimalDigit > 0){
                for _ in 0 ..< (decimalDigit){
                    increaseBy.append("0")
                }
            }
        
            increaseBy.append("1")
            result += Double(increaseBy)!
            textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
        }
    }
    
    private func decreaseByOne(){
        //Nếu số đó là integer
        if (floor(result) == result){
            result -= 1
            textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
        }else{
            /*
             nếu số là kiểu double thì tăng theo số decimal digit của số đó
             ex:
             case: 5.1 -> -= 0.1
             case: 5.15 -> -= 0.01
             case: 5.156 -> -= 0.001
             case: 5.n -> -= 0.("n-1" số 0)
             */
            var figureNumber = textField_Result.text!.replacingOccurrences(of: ",", with: "")
            var decimalDigit = 0
            var increaseBy = ""
            if figureNumber.contains(where: {(char) -> Bool in char == "."}){
                if let index = figureNumber.firstIndex(of: "."){
                    let distance = figureNumber.distance(from: figureNumber.startIndex, to: index)
                    decimalDigit = figureNumber.count - distance - 1
                    
                }
            }
            increaseBy.append("0.")
            decimalDigit -= 1 //- 1 là vì decimalDigit cuối cùng là 1 và ta có (n-1) số 0
            if (decimalDigit > 0){
                for _ in 0 ..< (decimalDigit){
                    increaseBy.append("0")
                }
            }
        
            increaseBy.append("1")
            result -= Double(increaseBy)!
            textField_Result.text = stringVietnameseMoneyFormatWithDouble(amount: result)
        }
    }
}
