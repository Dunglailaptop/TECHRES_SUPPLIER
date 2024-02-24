//
//  Utils.swift
//  TechresOrder
//
//  Created by macmini_techres_03 on 12/01/2023.
//

import UIKit
import MarqueeLabel
import RxCocoa
import Photos
import ExpandableLabel
import AMPopTip


class Utils: NSObject {
    
    static func getUDID()-> String{
        let UDID = UIDevice.current.identifierForVendor!.uuidString
        
        return UDID.lowercased()
    }
    
    static func getOSName()-> String{
        return  "iOS"
    }
    static func getAppType()-> Int{
        return  0
    }
    
    static func getDeviceName()-> String{
        let UDID = UIDevice.current.name
        
        return UDID.lowercased()
    }
    
    static func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    static func isHideAllView(isHide:Bool, view:UIView){
        view.isHidden = isHide
        view.subviews.enumerated().forEach { (index, value) in
            view.subviews[index].isHidden = isHide
        }
        
        
    }
    
    static func isHideView(isHide:Bool, view:UIView){
        view.isHidden = isHide
        view.subviews.forEach { _ in
            
            view.subviews[0].isHidden = isHide
            view.subviews[1].isHidden = isHide
        }
    }
    
    static func doubleToPrecent(value : Double)-> String
    {
        let index = value*100
        let str = String(format: "%.1f%%", index)
        return str
    }
    
    static func stringVietnameseMoneyFormatWithNumber(amount:Float, unit_name :String = "")->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@ %@",strAmount!, unit_name)
    }
    
    static func stringVietnameseMoneyFormatWithNumberInt(amount:Int, unit_name :String = "")->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@ %@",strAmount!, unit_name)
    }
    
    
    static func stringVietnameseMoneyFormatWithNumber(amount:Int)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@",strAmount!)
    }
    static func stringVietnameseMoneyFormatWithDouble(amount: Double)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = 2
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@", strAmount!)
    }
    
    static func stringVietnameseMoneyFormatWithNumberDouble(amount:Double, unit_name :String = "")->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = 2
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@ %@",strAmount!, unit_name)
    }
    static func removeStringVietnameseFormatMoney(amount:String)->(Int){
        return Int(amount.replacingOccurrences(of: ",", with: "")) ?? 0
    }
    static func removeStringVietnameseFormatStringFloat(amount:String)->(Float){
        return Float(amount.replacingOccurrences(of: ",", with: "")) ?? 0
    }
    static func removeStringVietnameseFormatStringInt(amount:String)->(Double){
        return Double(amount.replacingOccurrences(of: ".", with: "")) ?? 0
    }
    
    
    static func removeZeroFromNumberFloat(number:Float) -> String{
        /*
            nếu 1.0 return "1"
            nếu 2.50 return "2.5"
            nếu 2.68 return "2.68"
         */
        var amount = String(format: "%.2f", number)
        while amount.last == "0" {
           amount.removeLast()
        }
        if amount.last == "." {
           amount.removeLast()
        }
        return amount
    }
    
    
    static func formatQuantityToStringWithNumberDouble(quantity:Double) -> String{
        /*
            nếu 1.0 return "1"
            nếu 2.5 return "2.5"
            nếu 2.68 return "2.68"
         */
        var amount = String(format: "%f", quantity)
        while amount.last == "0" {
           amount.removeLast()
        }
        if amount.last == "." {
           amount.removeLast()
        }
        return amount
    }
    
    
    
    func capitalizeString(inputString: String) -> String {
        let capitalizedString = inputString.uppercased()
        return capitalizedString
    }

    
    
    static func stringQuantityFormatWithNumber(amount:Int)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.groupingSeparator = ","
        number.groupingSize = 3
        
        let strAmount = number.string(from: NSNumber(value: amount))
        return String(format: "%@",strAmount!)
    }
    static func stringQuantityFormatWithNumberFloat(amount:Float)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = 2
        let strAmount = number.string(from: NSNumber(value: Double(amount)))
        return String(format: "%@",strAmount!)
    }
    static func stringQuantityFormatWithNumberDouble(amount:Double)->(String){
        let number = NumberFormatter()
        number.usesGroupingSeparator = true
        number.numberStyle = .decimal
        number.groupingSeparator = ","
        number.decimalSeparator = "."
        number.groupingSize = 3
        number.maximumFractionDigits = 2
        let strAmount = number.string(from: NSNumber(value: Double(amount)))
        return String(format: "%@",strAmount!)
    }
    
    static func isCheckCharacterVN(string : String) -> Bool{
        
        let character = "àảãáạăằẳẵắặâầẩẫấậÀẢÃÁẠĂẰẲẴẮẶÂẦẨẪẤẬđĐèẻẽéẹêềểễếệÈẺẼÉẸÊỀỂỄẾỆìỉĩíịÌỈĨÍỊòỏõóọôồổỗốộơờởỡớợÒỎÕÓỌÔỒỔỖỐỘƠỜỞỠỚỢùủũúụưừửữứựÙỦŨÚỤƯỪỬỮỨỰyỳỷỹýỵỲỶỸÝỴ"
        
        if character.contains(string){
            return true
        }else{
            return false
        }
        
    }
    
    static func checkRoleBookingManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.BOOKING_MANAGEMENT.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    static func checkImportInventoryManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.BAR_ACCESS.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.BRANCH_INVENTORY_MANAGEMENT.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.GOODS_INVENTORY_MANAGEMENT.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    static func checkCreateInventoryManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.INVENTORY_MATERIAL_REQUEST.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    static func checkConfirmInventoryManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.BRANCH_INVENTORY_MANAGEMENT.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    //QUYỀN ADMIN HỆ THỐNG | CHỦ NHÀ HÀNG
    static func checkOwnerPermission(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    
    static func checkSalaryTableEmployess(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.TMS_VIEW_EMPLOYEE_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_SALARY_TABLE.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.CONFIRM_SALARY_TABLE.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.VIEW_ALL.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.RESTAURANT_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    /// Quyền quản lý
    static func checkConfirmSalary(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.CONFIRM_SALARY_TABLE.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.PAYROLL_OVERVIEW.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    /// Quyền tổng quản lý
    static func checkManagerApproveSalary(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.GENERAL_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.CHEF_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.ACCOUNTING_MANAGER.rawValue)) == true) {
                isAllow = true
            }
        }
        return isAllow
    }
    static func checkPermissionConfirmAllSalary(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.PAYROLL_OVERVIEW.rawValue)) == true) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    
    static func checkCreateBonusPunishManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.MANAGER_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    static func checkConfirmBonusPunishManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.CONFIRM_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    static func checkApproveBonusPunishManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    static func checkGoodsRequestPermission(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                //                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                
                
            ){
                isAllow = true
            }
        }
        return isAllow
    }
    
    static func checkByPassCheckin(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.BYPASS_CHECKIN.rawValue)) == true
            ){
                isAllow = true
            }
        }
        return isAllow
    }
    
    /// Check quyền quản lý mua hàng
    static func checkWarehouseManage(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.BRANCH_INVENTORY_MANAGEMENT.rawValue)) == true ){
                isAllow = true
            }
        }
        return isAllow
    }
    
    
    //QUYỀN QUẢN LÝ NHÂN VIÊN
    static func checkEmployeeManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.EMPLOYEE_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.EMPLOYEE_CHECKIN_LIST.rawValue)) == true
            ){
                isAllow = true
            }
        }
        return isAllow
    }
    //QUYỀN TỔNG QUẢN LÝ
    static func checkRestaurantManagerPermission(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.RESTAURANT_MANAGER.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM ALL HỆ THỐNG. CHỈ XEM KO ĐC CHỈNH SỬA
    static func checkViewAllPermission(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.VIEW_ALL.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN QUẢN LÝ CHẤM CÔNG
    static func checkTimeSheetManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.CHECK_KPI_TASK_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.EMPLOYEE_CHECKIN_LIST.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    // QUYỀN QUẢN LÝ NGHỈ PHÉP
    static func checkLeaveManager(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.EMPLOYEE_LEAVE_FORM_MANAGER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN QUẢN LÝ DUYỆT ỨNG LƯƠNG
    static func checkAdvanceSalary(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_ADVANCE_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN QUẢN LÝ DUYỆT MỤC TIÊU
    static func checkApproveTargetEmployee(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_TARGET.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN QUẢN LÝ DUYỆT THƯỞNG PHẠT NHÂN VIÊN
    static func checkApproveAdditionEmployee(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_ADDITION_SALARY.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.APPROVE_EMPLOYEE_FORM.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    // QUYỀN XEM BÁO CÁO DANH MỤC
    static func checkViewReportCategory(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.RESTAURANT_MANAGER.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM BÁO CÁO ĐỒ UỐNG
    static func checkViewReportDrink(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.REPORT_DRINK.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM BÁO CÁO ĐỒ ĂN
    static func checkViewReportFood(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.REPORT_FOOD.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    // QUYỀN XEM BÁO CÁO MÓN KHÁC
    static func checkViewReportOtherFood(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.REPORT_OTHER_FOOD.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    // QUYỀN XEM BÁO CÁO MÓN TẶNG
    static func checkViewReportGiftFood(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.REPORT_GIFT_FOOD.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM BÁO CÁO MÓN HỦY
    static func checkViewReportCancelFood(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.REPORT_MANAGER.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM BÁO CÁO ĐÁNH GIÁ MÓN
    static func checkViewReportReviewFood(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.REPORT_FOOD.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    // QUYỀN XEM QL KAIZEN
    static func checkViewKaizenManagement(permission:[String]) -> Bool {
        var isAllow = false
        for item in permission {
            if ((item.elementsEqual(PERMISSIONS.OWNER.rawValue)) == true
                || (item.elementsEqual(PERMISSIONS.KAIZEN_MANAGEMENT.rawValue)) == true
            ) {
                isAllow = true
            }
        }
        return isAllow
    }
    
    
    //=========== END DEFINE PERMISSION ==================
    
    static func encoded(str:String)->String{
        
        if let base64Str = str.base64Encoded() {
            print("Base64 encoded string: \"\(base64Str)\"")
            return base64Str
        }
        return str
    }
    
    
    static func getDayOfWeek(today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: todayDate)
        return weekDay
    }
    
    static func getWeekOfYear(today: String) -> Int? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        guard let todayDate = formatter.date(from: today) else { return nil }
        let myCalendar = Calendar(identifier: .gregorian)
        let week = myCalendar.component(.weekOfYear, from: todayDate)
        return week
    }
    
    static func getCurrentMonth(date: Date = Date()) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    
    static func getCurrentYear(date: Date = Date()) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "YYYY"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    
    static func getCurrentDay(date: Date) -> Int {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd"
        
        
        let dateString = dateformat.string(from: date as Date)
        //println(dateString)
        return Int(dateString)!
    }
    static func getCurrentDateString() -> String{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year:Int =  components.year ?? 2022
        let month:Int = components.month ?? 01
        let day:Int = components.day ?? 01
        
        return String(format: "%02d/%02d/%d", day, month, year)
    }
    static let calendar = Calendar.current
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/YYYY"
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    static let monthFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/YYYY"
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    
    static let yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        formatter.calendar = Calendar(identifier: .gregorian)
        return formatter
    }()
    static func getYesterdayString()->String{
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        return String(format: "%@", dateFormatter.string(from: yesterday!))
    }
    
    static func getCurrentWeekString() ->String {
        let week = Calendar.current.component(.weekOfYear, from: Date())
        let year = Calendar.current.component(.year, from: Date())
        return String(format: "%d/%d",week,year)
    }
    
    static func getLastThreeMonthString() ->String {
        let lastThreeMonth = calendar.date(byAdding: .month, value: -3, to: Date())
        return String(format: "%@", monthFormatter.string(from: lastThreeMonth!))
    }
    
    static func getLastMonthString() ->String {
        let lastMonth = calendar.date(byAdding: .month, value: -1, to: Date())
        return String(format: "%@", monthFormatter.string(from: lastMonth!))
    }
    
    static func getCurrentMonthString() ->String {
        let currentMonth = calendar.date(byAdding: .month, value: 0, to: Date())
        return String(format: "%@", monthFormatter.string(from: currentMonth!))
    }
    
    static func getLastThreeYearString() -> String {
        let lastThreeYear = calendar.date(byAdding: .year, value: -3, to: Date())
        return String(format: "%@", yearFormatter.string(from: lastThreeYear!))
    }
    
    static func getLastYearString() -> String {
        let lastYear = calendar.date(byAdding: .year, value: -1, to: Date())
        return String(format: "%@", yearFormatter.string(from: lastYear!))
    }
    
    static func getCurrentYearString() -> String {
        let year = Calendar.current.component(.year, from: Date())
        return String(format: "%d", year)
    }
    
    static func getCurrentHour()->String{
        
        // 1. Choose a date
        let today = Date()
        // 2. Pick the date components
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        let seconds = (Calendar.current.component(.second, from: today))
        
        return String(format: "%d:%d:%d", hours, minutes, seconds)
    }
    
    static func getCurrentDateHour()->String{
        
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year:Int =  components.year ?? 2022
        let month:Int = components.month ?? 01
        let day:Int = components.day ?? 01
        
        
        // 1. Choose a date
        let today = Date()
        // 2. Pick the date components
        let hours   = (Calendar.current.component(.hour, from: today))
        let minutes = (Calendar.current.component(.minute, from: today))
        //        let seconds = (Calendar.current.component(.second, from: today))
        
        return String(format: "%02d/%02d/%d %02d:%02d",day, month, year, hours, minutes)
    }
    
    static func getCurrentMonthYearString() -> String{
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year:Int =  components.year ?? 2022
        let month:Int = components.month ?? 01
        
        return String(format: "%02d/%d",  month, year)
    }
    
    static func getNextMonthYearString() -> String{
        let nm = Calendar.current.date(byAdding: .month, value: +1, to: Date())
        let monthFormatter : DateFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM/yyyy"
        let nextMonth = monthFormatter.string(from: nm!)
        return nextMonth
    }
    
    static func getFullMediaLink(string:String, media_type:Int = TYPE_IMAGE) -> String {
        
        dLog( media_type == TYPE_VIDEO ? (String(format: "%@%@", APIEndPoint.endPointURL, "/s3") + string).encodeUrl()! : (String(format: "%@", ManageCacheObject.getConfig().api_upload_short) + string).encodeUrl()!)
        
        return media_type == TYPE_VIDEO ? (String(format: "%@%@", APIEndPoint.endPointURL, "/s3") + string).encodeUrl()! : (String(format: "%@", ManageCacheObject.getConfig().api_upload_short) + string).encodeUrl()!
    }
    
    static func lableMarqueeLabel(marqueeLabel:MarqueeLabel){
        // Left/right example, with rate usage
        //        marqueeLabel.type = .leftRight
        //        marqueeLabel.speed = .rate(60)
        //        marqueeLabel.fadeLength = 10.0
        //        marqueeLabel.leadingBuffer = 30.0
        //        marqueeLabel.trailingBuffer = 20.0
        //        marqueeLabel.textAlignment = .left
        
        marqueeLabel.type = .continuous
        marqueeLabel.scrollDuration = 5.0
        marqueeLabel.animationCurve = .easeInOut
        marqueeLabel.speed = .duration(15)
        marqueeLabel.fadeLength = 10.0
        marqueeLabel.leadingBuffer = 2.0
        marqueeLabel.trailingBuffer = 2.0
        
    }
    
    static func getMarqueeLabel(lblContent: MarqueeLabel) {
        lblContent.type = .continuous
        lblContent.scrollDuration = 20.0
        lblContent.animationCurve = .easeInOut
        lblContent.fadeLength = 40.0
        lblContent.leadingBuffer = 2.0
        lblContent.trailingBuffer = 2.0
    }
    
    static func getLastDayOfMonth(year:Int, month:Int) -> Int {
        let calendar:Calendar = Calendar.current
        var dc:DateComponents = DateComponents()
        dc.year = year
        dc.month = month + 1
        dc.day = 0
        let lastDateOfMonth:Date = calendar.date(from:dc)!
        let lastDay = calendar.component(Calendar.Component.day, from: lastDateOfMonth)
        return lastDay
    }
    static func getHeightTextContent(textContent:String, widthContent:UILabel, marginLabel: CGFloat, fontSize: CGFloat) -> CGFloat {
        let textContent = textContent // text của data trả về
        let font = UIFont.systemFont(ofSize: fontSize) // font size text content
        let widthContents = CGFloat(widthContent.frame.width) // chiều rộng của content
        let boundingSize = CGSize(width: widthContents, height: CGFloat.greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes = [NSAttributedString.Key.font: font]
        return NSString(string: textContent).boundingRect(with: boundingSize, options: options, attributes: attributes, context: nil).height + marginLabel
    }
    static func getHeightTextContentInView(textString: String, maxWidth: CGFloat, theRest: CGFloat, fontSize: CGFloat, fontName: String) -> CGFloat{
        return NSString(string: textString)
            .boundingRect(with: CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude),
                          options: NSStringDrawingOptions.usesLineFragmentOrigin,
                          attributes: [
                            NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize)
                          ],
                          context: nil).height + theRest
    }
    static func countUserInputCharacters(in textView: UITextView) -> Int {
        let text = textView.text ?? ""
        let userInputCount = text.count
        return userInputCount
    }
    static func countUserInputCharactersTextField(in textField: UITextField) -> Int {
        let textField = textField.text ?? ""
        let userInputCountTextField = textField.count
        return userInputCountTextField
    }
    static func countUserInputCharactersTextView(in textView: UITextView) -> Int {
        let textView = textView.text ?? ""
        let userInputCountTextView = textView.count
        return userInputCountTextView
    }
    static func countUserInputCharactersLable(in lable: UILabel) -> Int {
        let lable = lable.text ?? ""
        let userInputCountLable = lable.count
        return userInputCountLable
    }
    
    static func isValidPhoneNumber(_ phoneNumber: String) -> Bool {
        let phoneRegex = #"^\d{10}$"#
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phonePredicate.evaluate(with: phoneNumber)
    }
    static func isEmailFormatCorrect(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isAtLeast16YearsOld(dateString: String, format: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        if let dateOfBirth = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            let currentDate = Date()

            if let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: currentDate).year, ageComponents >= 16 {
                return true
            }
        }

        return false
    }


    
    static func rateDefaultTemplate(numerator: Double, denominator: Double) -> Double {
        var rate: Double = 0
        
        if numerator == 0 && denominator == 0 {
            rate = 0
        } else if denominator == 0 {
            rate = 1
        } else {
            rate = numerator / denominator
        }
        return rate
    }
    
    
    static func getDateString() -> (thisWeek: String, thisMonth: String, lastMonth: String, threeLastMonth: String, thisYear: String, lastYear: String, threeLastYear: String, dateTimeNow: String, today: String, yesterday: String) {
        
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let Week = calendar.component(.weekOfYear, from: date)
        
        // Tuần này
        var thisWeek = String(format: "%d/%d", Week, year)
        if thisWeek.count == 6 {
            thisWeek = String(format: "0%d/%d", Week, year)
        }
        // Tháng này
        _ = String(format: "%d/%d", month, year)
        let tm = Calendar.current.date(byAdding: .month, value: 0, to: Date())
        let tmFormatter : DateFormatter = DateFormatter()
        tmFormatter.dateFormat = "MM/yyyy"
        let thisMonth = tmFormatter.string(from: tm!)
        
        // Tháng trước
        let lm = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let monthFormatter : DateFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM/yyyy"
        let lastMonth = monthFormatter.string(from: lm!)
        
        // 3 Tháng trước
        let tlm = Calendar.current.date(byAdding: .month, value: -3, to: Date())
        let threeLastMonthFormatter : DateFormatter = DateFormatter()
        threeLastMonthFormatter.dateFormat = "MM/yyyy"
        let threeLastMonth = threeLastMonthFormatter.string(from: tlm!)
        
        // Năm nay
        let thisYear = String(year)
        
        // Năm trước
        let ly = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        let yearFormatter : DateFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let lastYear = yearFormatter.string(from: ly!)
        
        // 3 năm trước
        let tly = Calendar.current.date(byAdding: .year, value: -3, to: Date())
        let threeLastYearFormatter : DateFormatter = DateFormatter()
        threeLastYearFormatter.dateFormat = "yyyy"
        let threeLastYear = threeLastYearFormatter.string(from: tly!)
        
        // Ngày hôm nay
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY"
        let formattedDate = format.string(from: date)
        let dateTimeNow = formattedDate
        
        // Giờ hôm nay
        let formatTime = DateFormatter()
        formatTime.dateFormat = "HH:mm:ss"
        let today = formatTime.string(from: date)
        
        // Hôm qua
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let yesterday = dateFormatter.string(from: y!)
        return (thisWeek, thisMonth, lastMonth, threeLastMonth, thisYear, lastYear, threeLastYear, dateTimeNow, today, yesterday)
    }
    // bỏ tiếng việt và khoảng trắng
    func processString(input: String) -> String {
           let withoutDiacriticsAndD = removeDiacriticsAndD(from: input)
           let withoutSpaces = withoutDiacriticsAndD.replacingOccurrences(of: " ", with: "")
           return withoutSpaces
    }
       
   func removeDiacriticsAndD(from input: String) -> String {
       var mutableString = NSMutableString(string: input) as CFMutableString
       CFStringTransform(mutableString, nil, kCFStringTransformStripCombiningMarks, false)
       
       let range = CFRangeMake(0, CFStringGetLength(mutableString))
       CFStringFindAndReplace(mutableString, "đ" as CFString, "d" as CFString, range, [])
       
       return mutableString as String
   }
    // kiem tra ky tu đặc biet khi nhap vao cho tên vùng -> trả về chuỗi
    static  func blockSpecialCharacters(_ string: String) -> String {
        //the patern:"\\p{L}\\p{M}" is for vni telex
        let regex = try! NSRegularExpression(pattern: "[^a-zA-Z0-9\\p{L}\\p{M} ]+")
        let filteredString = regex.stringByReplacingMatches(in: string, range: NSRange(location: 0, length: string.count), withTemplate: "")
        return filteredString
    }
    

    
    
    
    // kiem tra ky tu đặc biet khi nhap vao cho tên vùng -> trả về chuỗi
  static  func blockSpace(_ string: String) -> String {
        let specialCharacterSet = CharacterSet(charactersIn: " ")
        let filteredString = string.components(separatedBy: specialCharacterSet).joined(separator: "")
        return filteredString
    }
    
    // Lấy các ngày trong tuần
    static func getDayOfWeek(_ date:String, format:String) -> String?{
        let weekDays = [
            "thứ 2",
            "thứ 3",
            "thứ 4",
            "thứ 5",
            "thứ 6",
            "thư 7",
            "chủ nhật"
        ]
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let myDate = formatter.date(from: date) else {return nil}
        
        let myCalendar = Calendar(identifier: .gregorian)
        let weekDay = myCalendar.component(.weekday, from: myDate)
        
        if (weekDay == 1){
            return weekDays[6]
        }
        return weekDays[weekDay - 2]
    }
    
    /// Tính thời gian cách hiện tại
    static func timeAgo(from dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.timeZone = TimeZone(identifier: "UTC")!
        
        if let date = dateFormatter.date(from: dateString) {
            let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: Date())
            
            if let year = components.year, year > 0 {
                return "\(year) năm trước"
            } else if let month = components.month, month > 0 {
                return "\(month) tháng trước"
            } else if let day = components.day, day > 0 {
                return "\(day) ngày trước"
            } else if let hour = components.hour, hour > 0 {
                return "\(hour) giờ trước"
            } else if let minute = components.minute, minute > 0 {
                return "\(minute) phút trước"
            } else if let second = components.second, second > 0 {
                return "\(second) giây trước"
            } else {
                return "Vừa xong"
            }
        }
        
        return ""
    }
    
    /// Chuyển đổi VideoURL sang IDVideo load Youtube
    static func extractVideoId(from videoURL: String) -> String? {
        if let url = URL(string: videoURL),
           let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: true)?.queryItems {
            for queryItem in queryItems {
                if queryItem.name.lowercased() == "v", let videoId = queryItem.value {
                    return videoId
                }
            }
        }
        return ""
    }
    
    // Formatter YYYY/MM/DD sang DD/MM/YYYY
    static func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy/MM/dd"
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            return outputFormatter.string(from: date)
        }
        return nil
    }
    
    /// Chuyển đổi Image thành URL trên thiết bị
    static func getImageURL(_ image: UIImage) -> URL? {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            return nil
        }
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let number = Int.random(in: 1 ... 100)
        let random = Utils.randomString(length: number)
        let fileName = String(format: "%@.%@", random, "jpg")
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        do {
            try imageData.write(to: fileURL)
            return fileURL
        } catch {
            dLog(error)
            return nil
        }
    }
    
    /// Chuyển đổi Video thành URL trên thiết bị
    static func getVideoURL(from asset: PHAsset, completion: @escaping (URL?) -> Void) {
        let options = PHVideoRequestOptions()
        options.version = .original
        PHImageManager.default().requestAVAsset(forVideo: asset, options: options) { (avAsset, _, _) in
            guard let avAsset = avAsset as? AVURLAsset else {
                completion(nil)
                return
            }
            let videoURL = avAsset.url
            completion(videoURL)
        }
    }
    
    /// Lấy tên nguyên bản trên thiết bị của ảnh
    static func getImageFullName(asset: PHAsset) -> String {
        let resources = PHAssetResource.assetResources(for: asset)
        
        if let resource = resources.first {
            let fullName = resource.originalFilename
            return fullName
        }
        
        return ""
    }
    
    /// Get PHAsset từ ảnh
    static func getPHAssetFromImage(from image: UIImage, completion: @escaping (PHAsset?) -> Void) {
        var assetIdentifier: String?

        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest.creationRequestForAsset(from: image)
            assetIdentifier = request.placeholderForCreatedAsset?.localIdentifier
        }) { success, error in
            if success, let identifier = assetIdentifier {
                let assets = PHAsset.fetchAssets(withLocalIdentifiers: [identifier], options: nil)
                let asset = assets.firstObject
                completion(asset)
            } else {
                print("Error creating PHAsset: \(error?.localizedDescription ?? "")")
                completion(nil)
            }
        }
    }

    
    /// Fetch PHAsset to Image
    static func fetchPHAsset(for image: UIImage) -> PHAsset? {
        var asset: PHAsset?
        let semaphore = DispatchSemaphore(value: 0)
            
        getPHAssetFromImage(from: image) { fetchedAsset in
                asset = fetchedAsset
                semaphore.signal()
            }
            
            semaphore.wait()
            return asset
    }
    
    static func validateStringNotAllowSticker(_ string: String) -> Bool {
        let emojiRegex = try! NSRegularExpression(pattern: "[\\p{Emoji}]", options: .caseInsensitive)
        let iconRegex = try! NSRegularExpression(pattern: "[\\p{Sk}]", options: .caseInsensitive)
        
        let emojiMatches = emojiRegex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        let iconMatches = iconRegex.matches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count))
        
        return emojiMatches.isEmpty && iconMatches.isEmpty
    }
    
    static func getExpandableLabel(label: ExpandableLabel, target: BaseViewController, content: String) {
        
        let textLabel = label
        
        textLabel.delegate = target as?  ExpandableLabelDelegate
        
        textLabel.setLessLinkWith(lessLink: "Thu gọn", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor(hex: "0071BB")], position: nil)
        
        textLabel.layoutIfNeeded()
        
        var arrayStringSolution = [String]()
        let inputSolution = content
        let detectorSolution = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matchesSolution = detectorSolution.matches(in: inputSolution, options: [], range: NSRange(location: 0, length: inputSolution.utf16.count))
        
        for matchSolution in matchesSolution {
            guard let rangeSolution = Range(matchSolution.range, in: inputSolution) else { continue }
            let url = inputSolution[rangeSolution]
            arrayStringSolution.append(String(url))
        }
        
        let attributedWithTextColorSolution: NSAttributedString = content.attributedStringWithColor( arrayStringSolution, color: UIColor(hex: "0071BB"))
        textLabel.attributedText = attributedWithTextColorSolution
        
        let attrsSolution = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),  NSAttributedString.Key.foregroundColor : UIColor(hex: "0071BB")]
        
        textLabel.numberOfLines = 4
        textLabel.shouldCollapse = true
        textLabel.collapsed = true
        textLabel.collapsedAttributedLink = NSAttributedString(string: "Xem thêm", attributes: attrsSolution)
        textLabel.expandedAttributedLink = NSAttributedString(string: "Thu gọn", attributes: attrsSolution)
        textLabel.ellipsis = NSAttributedString(string: "...", attributes: attrsSolution)
        
        target.view.setNeedsLayout()
        
    }
    
    static func getPopTip(label: String, view: UIView, sender: UIButton) {
        let textTip = label
        let popTip = PopTip()
        popTip.bubbleColor = UIColor(hex: "EBF4FA")
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
            NSAttributedString.Key.foregroundColor: UIColor(hex: "7D7E81")]
        
        let attributedText = NSMutableAttributedString(string: textTip, attributes: attributes)
        
        popTip.show(
            attributedText: attributedText,
            direction: .down,
            maxWidth: 200,
            in: view,
            from: sender.frame
        )
    }
    
    
    static func setMultipleColorForLabel(label: UILabel, attributes:[(str:String, color:UIColor)]) -> NSMutableAttributedString {
        var totalStr = ""
        var pointer = 0
        
        for i in 0..<(attributes.count - 1) {
            totalStr += attributes[i].str + " "
        }
        totalStr += attributes[attributes.count - 1].str

        let myMutableString = NSMutableAttributedString(string: totalStr, attributes: [NSAttributedString.Key.font :label.font as Any])

        for attr in attributes {
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: attr.color, range: NSRange(location:pointer,length:attr.str.count))
            pointer += attr.str.count + 1
        }
        
        label.text = totalStr

        return myMutableString
    }
    
    static func setMultipleFontAndColorForLabel(label: UILabel, attributes:[(str:String,font:UIFont,color:UIColor)]) -> NSMutableAttributedString {
        var totalStr = ""
        var pointer = 0
        
        for i in 0..<(attributes.count - 1) {
            totalStr += attributes[i].str + " "
        }
        totalStr += attributes[attributes.count - 1].str
        
        let myMutableString = NSMutableAttributedString(string: totalStr,attributes: [NSAttributedString.Key.foregroundColor :label.textColor as Any])
        for attr in attributes {
            myMutableString.addAttribute(NSAttributedString.Key.font, value: attr.font, range: NSRange(location:pointer,length:attr.str.count))
            myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: attr.color, range: NSRange(location:pointer,length:attr.str.count))
            pointer += attr.str.count + 1
        }

        label.text = totalStr
        return myMutableString
    }
    
    
    
    
    
    static func isDateValid(fromDateStr:String, toDateStr:String) -> Bool{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let fromDate = dateFormatter.date(from: fromDateStr) ?? Date()
        let toDate = dateFormatter.date(from: toDateStr) ?? Date()
        return fromDate.isSmallerThanOrEqual(toDate)
    }

}

extension BehaviorRelay where Element: Collection {
    func isCollectionEmpty(isHide: Bool, view: UIView) {
        if self.value.count > 0 {
            Utils.isHideAllView(isHide: true, view: view)
        } else {
            Utils.isHideAllView(isHide: false, view: view)
        }
    }
}

struct AppUtility {

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
    
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
   
        self.lockOrientation(orientation)
    
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        UINavigationController.attemptRotationToDeviceOrientation()
    }
}
