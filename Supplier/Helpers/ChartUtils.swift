//
//  ChartUtils.swift
//  Techres - TMS
//
//  Created by Thanh Phong on 05/08/2021.
//  Copyright © 2021 ALOAPP. All rights reserved.
//

import UIKit
import Charts

class ChartUtils: NSObject {
    static func customLineChart(chartView : LineChartView, entries: [ChartDataEntry]) {
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.axisMaximum = Double(entries.count)
       
        chartView.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 7), size: 7)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        let customFormatter = CustomChartView()
        chartView.leftAxis.valueFormatter = customFormatter as! AxisValueFormatter
    }
    
    static func customPieChart(chartView : PieChartView, total: Int) {
        chartView.entryLabelColor = .black
        chartView.transparentCircleRadiusPercent = CGFloat(0.1)
        chartView.drawHoleEnabled = false
        //gone chú thích
        chartView.legend.enabled = false
        chartView.legend.horizontalAlignment = .center
        //gone text center
        chartView.drawCenterTextEnabled = false
        chartView.drawHoleEnabled = false
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 12.0)! ]
        let myAttrString = NSAttributedString(string: Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(Float(total))), attributes: myAttribute)
        chartView.centerAttributedText = myAttrString
        chartView.clearsContextBeforeDrawing = true
        chartView.animate(yAxisDuration: 2.0, easingOption: ChartEasingOption.easeInOutBack)
        chartView.entryLabelFont = UIFont.init(name: "HelveticaNeue", size: 4)
    }
    
    static func customBarChart(chartView : BarChartView) {
        chartView.legend.enabled = false
        chartView.chartDescription.enabled = false
        chartView.backgroundColor = UIColor.white
        chartView.leftAxis.drawAxisLineEnabled = true
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.rightAxis.enabled = false
        chartView.xAxis.drawAxisLineEnabled = false
        chartView.xAxis.drawGridLinesEnabled = true
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.axisMinimum = -1
        chartView.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 8), size: 8)
        chartView.xAxis.labelRotatedHeight = CGFloat(50.0)
        chartView.xAxis.labelRotationAngle = -75.0
        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        let customFormatter = CustomChartView()
        chartView.leftAxis.valueFormatter = customFormatter as! AxisValueFormatter
    }
    
    ////variable  dataPointnth is used to get label for the report type of week
    static func getXLabel(dateTime:String, reportType:Int, dataPointnth:Int) -> String {
        var x_label = ""
        let datetimeSeparator = dateTime.components(separatedBy: [" "])
            
            dLog(dateTime)
            switch(reportType){
                case REPORT_TYPE_TODAY:
                let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                x_label = String(format: "%@:00", substringTime.first ?? "")
         
                case REPORT_TYPE_YESTERDAY:
                let substringTime = datetimeSeparator[1].components(separatedBy: [":"])
                x_label = String(format: "%@:00", substringTime.first ?? "")
                
                case REPORT_TYPE_THIS_WEEK:
                    switch dataPointnth {
                        case 0:
                            x_label = "Thứ 2"
                            break
                        case 1:
                            x_label = "Thứ 3"
                            break
                        case 2:
                            x_label = "Thứ 4"
                            break
                        case 3:
                            x_label = "Thứ 5"
                            break
                        case 4:
                            x_label = "Thứ 6"
                            break
                        case 5:
                            x_label = "Thứ 7"
                            break
                        default:
                            x_label = "Chủ nhật"
                    }
                    break
                
                case REPORT_TYPE_LAST_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])
                    
                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_MONTH:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[2], substringDate[1])
                    break
                
                case REPORT_TYPE_THREE_MONTHS:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[2],substringDate[1])
                    break
                
                case REPORT_TYPE_THIS_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_LAST_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_THREE_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label = String(format: "%@/%@", substringDate[1], substringDate[0])
                    break
                
                case REPORT_TYPE_ALL_YEAR:
                    let datetimeSeparator = dateTime.components(separatedBy: [" "])
                    let substringDate = datetimeSeparator[0].components(separatedBy: ["-"])

                    x_label.append(String(format: "%@",substringDate[0]))
                    break
                
                default:
                    break
            }
        
        return x_label
        
    }
    
    static func setLabelCountForChart(reportType:Int,totalDataPoint:Int) -> Int{
        
        switch reportType {
            case REPORT_TYPE_TODAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_YESTERDAY:
                return (totalDataPoint)/3
            
            case REPORT_TYPE_THIS_WEEK:
                return totalDataPoint
            
            case REPORT_TYPE_THIS_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_LAST_MONTH:
                return (totalDataPoint)/4
            
            case REPORT_TYPE_THREE_MONTHS:
                return (totalDataPoint)/11
            
            case REPORT_TYPE_THIS_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_LAST_YEAR:
                return (totalDataPoint)
            
            case REPORT_TYPE_THREE_YEAR:
                return (totalDataPoint)/5
            
            case REPORT_TYPE_ALL_YEAR:
                return (totalDataPoint)
            
            default:
                return totalDataPoint
        }

    }
}
