//
//  PickerStyle.swift
//  TechresOrder
//
//  Created by kelvin on 14/01/2023.
//

import Foundation
import UIKit

extension UIColor {
    static var pickBackgroundColor:UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? ColorUtils.main_color() : .white
        }
    }
    
    static var titleBackgroundColor:UIColor {
        return UIColor { (traits) -> UIColor in
            return traits.userInterfaceStyle == .dark ? ColorUtils.main_color() : ColorUtils.blue_color()
        }
    }
}

enum DateFormat:String{
    /** Định dạng ngày：yyyy/MM/dd */
    case yyyy_m_d = "yyyy/MM/dd"
    /** Định dạng ngày：dd/MM/yyyy */
    case d_m_yyyy = "dd/MM/yyyy"
    /** Định dạng ngày：MM/dd/yy */
    case m_d_yy = "MM/dd/yy"
    /** Định dạng ngày：d-MMMM-yy */
    case d_mmmm_yy = "d-MMMM-yy"
    /** Định dạng ngày：dd-MMMM */
    case d_mmmm = "dd-MMMM"
    /** Định dạng ngày：MMMM-yy */
    case mmmm_yy = "MMMM-yy"
    /** Định dạng ngày：hh:mm aaa */
    case h_mm_PM = "hh:mm aaa"
    /** Định dạng ngày：HH:mm:ss */
    case h_mm_ss = "HH:mm:ss"
    /** Định dạng ngày：yyyy/MM/dd HH:mm:ss */
    case yyyy_To_ss = "yyyy/MM/dd HH:mm:ss"
    /** Định dạng ngày：MM/yyyy */
    case mm_yyyy = "MM/yyyy"
}

enum StyleColor {
    case color(UIColor)
    case colors([UIColor])
}

protocol PickerStyle {
    var backColor:UIColor { get set }
    var textColor:UIColor { get set }
    var pickerColor:StyleColor? { get set }
    var timeZone:TimeZone? { get set }
    var minimumDate:Date? { get set }
    var maximumDate:Date? { get set }
    var pickerMode:UIDatePicker.Mode? { get set }
    var titleFont:UIFont? { get set }
    var returnDateFormat:DateFormat? { get set }
    var titleString:String? { get set }
}

struct DefaultStyle:PickerStyle {
    var backColor: UIColor = UIColor.pickBackgroundColor
    var textColor: UIColor = UIColor.titleBackgroundColor
    var pickerColor: StyleColor? = StyleColor.color(UIColor.init(red: 10/255.0, green: 186/255.0, blue: 181/255.0, alpha: 1.0))
    var timeZone: TimeZone? = TimeZone(secondsFromGMT: TimeZone.current.secondsFromGMT())
    var minimumDate: Date?
    var maximumDate: Date?
    var pickerMode:UIDatePicker.Mode? = .dateAndTime
    var titleFont:UIFont?
    var returnDateFormat:DateFormat? = .yyyy_To_ss
    var titleString: String? = "Title"
}
struct CustomStyle:PickerStyle {
    var backColor: UIColor
    var textColor:UIColor
    var pickerColor: StyleColor?
    var timeZone: TimeZone?
    var minimumDate: Date?
    var maximumDate: Date?
    var pickerMode:UIDatePicker.Mode?
    var titleFont:UIFont?
    var returnDateFormat:DateFormat?
    var titleString: String?
}

