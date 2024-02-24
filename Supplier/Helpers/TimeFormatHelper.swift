//
//  TimeFormatHelper.swift
//  NewsReader
//
//  Created by Florian Marcu on 3/28/17.
//  Copyright © 2017 iOS App Templates. All rights reserved.
//

import Foundation

class TimeFormatHelper {
    static func timeAgoString(date: Date) -> String {
        let secondsInterval = Date().timeIntervalSince(date).rounded()
        if (secondsInterval < 10) {
            return "Vừa xong"
        }
        if (secondsInterval < 60) {
            return String(Int(secondsInterval)) + " giây trước"
        }
        let minutes = (secondsInterval / 60).rounded()
        if (minutes < 60) {
            return String(Int(minutes)) + " phút trước"
        }
        let hours = (minutes / 60).rounded()
        if (hours < 24) {
            return String(Int(hours)) + " giờ trước"
        }
        let days = (hours / 24).rounded()
        if (days < 30) {
            return String(Int(days)) + " ngày trước"
        }
        let months = (days / 30).rounded()
        if (months < 12) {
            return String(Int(months)) + " tháng trước"
        }
        let years = (months / 12).rounded()
        return String(Int(years)) + " năm trước"
    }

    static func convertStringToDate(isoDate:String)->Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:isoDate)!
        return date
    }
    
    static func compareSmallerDate(first_date:String) -> Bool{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let firstDate = formatter.date(from: first_date)
        let today = Date()
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        
        let secondDate = formatter.date(from: formatter1.string(from: today))

        if firstDate?.compare(secondDate!) == .orderedAscending {
            print("First Date is smaller then second date")
            return true
        }else{
            return false
        }
    }
    
    static func string(for date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

    static func chatString(for date: Date) -> String {
        let calendar = NSCalendar.current
        if calendar.isDateInToday(date) {
            return self.string(for: date, format: "HH:mm")
        }
        return self.string(for: date, format: "MMM dd")
    }
    
    static func isDateInToday(for date: Date) -> Bool{
        return Calendar.current.isDateInToday(date)
    }
    static func isDateInYesterday(for date: Date) -> Bool{
        return Calendar.current.isDateInYesterday(date)
    }
    static func isDateInTomorrow(for date: Date) -> Bool{
        return Calendar.current.isDateInTomorrow(date)
    }
    
    static func getCurrentDayMonthYear() -> String{
        var current_month = 1
        var current_year = 1
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        current_year = Int(formatter.string(from: Date()))!
        
        formatter.dateFormat = "MM"
        current_month = Int(formatter.string(from: Date()))!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        var dateString = ""
        
        if current_month < 10 {
            dateString = "01/0\(current_month)/\(current_year)"
        }
        else {
            dateString = "01/\(current_month)/\(current_year)"
        }
        return dateString
    }
}
