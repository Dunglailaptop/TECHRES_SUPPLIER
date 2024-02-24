//
//  InventoryReportViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Charts


extension InventoryReportViewController {
    @IBAction func actionFilterToday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterYesterday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_yesterday, textTitle: self.lbl_yesterday)
        dLog(yesterday)
        self.viewModel.date_string.accept(yesterday)
        self.viewModel.report_type.accept(REPORT_TYPE_YESTERDAY)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterThisWeek(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisweek, textTitle: self.lbl_thisWeek)
        self.viewModel.date_string.accept(thisWeek)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_WEEK)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterThisMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisMonth, textTitle: self.lbl_thisMonth)
        self.viewModel.date_string.accept(thisMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_MONTH)
        self.getInventoryReport()
    }
    @IBAction func actionFilterLastMonth(_ sender:Any){
        self.checkFilterSelected(view_selected: self.view_filter_lastMonth, textTitle: self.lbl_lastMonth)
        self.viewModel.date_string.accept(lastMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_MONTH)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterThreeMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_three_Month, textTitle: self.lbl_threeMonth)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_MONTHS)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterThisYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisYear, textTitle: self.lbl_thisYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_YEAR)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterLastYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_lastYear, textTitle: self.lbl_lastYear)
        self.viewModel.date_string.accept(lastYear)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_YEAR)
        self.getInventoryReport()
    }
    
    @IBAction func actionFilterThreeYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_threeYear, textTitle: self.lbl_threeYear)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_YEAR)
        self.getInventoryReport()
    }
    // Thêm action filter tất cả các năm
    @IBAction func actionFilterAllYear(_ sender: Any){
        self.checkFilterSelected(view_selected: self.view_filter_AllYear, textTitle: self.lbl_AllYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_ALL_YEAR)
     
        self.getInventoryReport()
    }
    // Thêm action filter tháng trước
    func getCurentTime(){
        let date = Date()
        let calendar = Calendar.current
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        self.Week = calendar.component(.weekOfYear, from: date)
        //Tuần này
        self.thisWeek = String(format: "%d/%d", self.Week, year)
        if self.thisWeek.count == 6 {
            self.thisWeek = String(format: "0%d/%d", self.Week, year)
        }
        //Thang nay
        self.monthCurrent = String(format: "%d/%d", month, year)
        //
        let tm = Calendar.current.date(byAdding: .month, value: 0, to: Date())
        let tmFormatter : DateFormatter = DateFormatter()
        tmFormatter.dateFormat = "MM/yyyy"
        self.thisMonth = tmFormatter.string(from: tm!)
        //Tháng trước
        let lm = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        let monthFormatter : DateFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM/yyyy"
        self.lastMonth = monthFormatter.string(from: lm!)
        //Nam nay
        self.yearCurrent = String(year)
        //Nam truoc
        let ly = Calendar.current.date(byAdding: .year, value: -1, to: Date())
        let yearFormatter : DateFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        self.lastYear = yearFormatter.string(from: ly!)
        
        //
        let format = DateFormatter()
        format.dateFormat = "dd/MM/YYYY"
        let formattedDate = format.string(from: date)
        self.dateTimeNow = formattedDate
        //Hôm nay
        let formatTime = DateFormatter()
        formatTime.dateFormat = "HH:mm:ss"
        
        today = formatTime.string(from: date)
        
        //        lblCurrentTime.text = formatTime.string(from: date)
        //Hôm qua
        let y = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        self.yesterday = dateFormatter.string(from: y!)
        
    }
    
    func checkFilterSelected(view_selected:UIView, textTitle:UILabel){
        view_filter_today.backgroundColor = ColorUtils.gray_200()
        view_filter_yesterday.backgroundColor = ColorUtils.gray_200()
        view_filter_thisweek.backgroundColor = ColorUtils.gray_200()
        view_filter_thisMonth.backgroundColor = ColorUtils.gray_200()
        view_filter_lastMonth.backgroundColor = ColorUtils.gray_200()
        view_filter_three_Month.backgroundColor = ColorUtils.gray_200()
        view_filter_thisYear.backgroundColor = ColorUtils.gray_200()
        view_filter_lastYear.backgroundColor = ColorUtils.gray_200()
        view_filter_threeYear.backgroundColor = ColorUtils.gray_200()
        view_filter_AllYear.backgroundColor = ColorUtils.gray_200()// thêm tất cả các năm
        
        lbl_today.textColor = ColorUtils.blue_700()
        lbl_yesterday.textColor = ColorUtils.blue_700()
        lbl_thisWeek.textColor = ColorUtils.blue_700()
        lbl_thisMonth.textColor = ColorUtils.blue_700()
        lbl_lastMonth.textColor = ColorUtils.blue_700()
        lbl_threeMonth.textColor = ColorUtils.blue_700()
        lbl_thisYear.textColor = ColorUtils.blue_700()
        lbl_lastYear.textColor = ColorUtils.blue_700()
        lbl_threeYear.textColor = ColorUtils.blue_700()
        lbl_AllYear.textColor = ColorUtils.blue_700()// thêm tất cả các năm
        
        textTitle.textColor = ColorUtils.blue_700()
        view_selected.backgroundColor = ColorUtils.blue_000()
    }
    
    
}

extension InventoryReportViewController:AxisValueFormatter {
    func setupBarChart(revenues:InventoryReport){
        
        view_chart.noDataText = "Chưa có dữ liệu !!"
        let totalCancel = revenues.total_cancel_amount
        let totalExport = revenues.total_export_amount
        let totalImport = revenues.total_import_amount
        let totalNow = revenues.total_inventory_now_amount
        let totalFirst = revenues.total_inventory_first_amount
        
   
        
        var barChartItems = [BarChartDataEntry]()
        
        //Chart Data
        
      
        
        barChartItems.append(BarChartDataEntry(x: Double(0), y: Double(totalFirst)))
        barChartItems.append(BarChartDataEntry(x: Double(1), y: Double(totalImport)))
        barChartItems.append(BarChartDataEntry(x: Double(2), y: Double(totalExport )))
        barChartItems.append(BarChartDataEntry(x: Double(3), y: Double(totalNow )))
        barChartItems.append(BarChartDataEntry(x: Double(4), y: Double(totalCancel )))
        
       
        
        //Bar Chart
        let barChartDataSet = BarChartDataSet(entries: barChartItems, label: "")
        barChartDataSet.setColors(ColorUtils.blue_color(), ColorUtils.red_color(), ColorUtils.main_color())
        barChartDataSet.drawValuesEnabled = false
        barChartDataSet.colors = [ColorUtils.blue_first(),ColorUtils.green_export(),ColorUtils.water_import(),ColorUtils.orange_now(),ColorUtils.pink_cancel()]
//        barChartDataSet.valueFormatter = MyValueFormatter()
        
        view_chart.data = BarChartData(dataSet: barChartDataSet)
        view_chart.fitScreen()
        view_chart.legend.enabled = false
        view_chart.chartDescription.enabled = false
        view_chart.backgroundColor = UIColor.white
        view_chart.leftAxis.drawAxisLineEnabled = true
        view_chart.leftAxis.drawGridLinesEnabled = true
        view_chart.leftAxis.axisMinimum = 0
        view_chart.leftAxis.valueFormatter = self // Thêm valueFormatter
        view_chart.rightAxis.enabled = false
        view_chart.xAxis.drawAxisLineEnabled = false
        view_chart.xAxis.drawGridLinesEnabled = true
        view_chart.xAxis.labelPosition = .bottom
        view_chart.xAxis.drawGridLinesEnabled = false
        view_chart.xAxis.axisMinimum = -1
        view_chart.xAxis.axisMaximum = Double(barChartItems.count)
        view_chart.xAxis.labelCount = barChartItems.count + 1
        view_chart.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 10), size: 10)
        view_chart.dragEnabled = true
        //        bar_chart.xAxis.labelRotationAngle = -60.0
        //            cell.bar_chart.xAxis.labelRotatedHeight = CGFloat(100.0)
        view_chart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        view_chart.pinchZoomEnabled = false
        view_chart.doubleTapToZoomEnabled = false
        view_chart.xAxis.labelRotationAngle = -50
        view_chart.xAxis.labelRotatedHeight = CGFloat(60)
        //label
        var x_label = [String]()
        x_label.append("Tồn đầu")
        x_label.append("Nhập kho")
        x_label.append("Xuất kho")
        x_label.append("Tồn hiện tại")
        x_label.append("Huỷ hàng")
        view_chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_label)
//        view_chart.leftAxis.valueFormatter = CustomAxisValueFormatter()
         
    }
  
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if(value >= 0 && value < 1000 ){
            return String(format: "%@ K", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value >= 1000 && value < 1000000 ){
            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
        }else if(value >= 1000000){
            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }
        return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
     }

    public class CustomAxisValueFormatter: NSObject, AxisValueFormatter {
        public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            return Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(value))
        }
    }
//    class MyValueFormatter: ValueFormatter {
//        var hiddenEntries: [ChartDataEntry?] = []
//
//        func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
//            return Utils.stringQuantityFormatWithNumber(amount: Int(value))
//        }
//    }
}
