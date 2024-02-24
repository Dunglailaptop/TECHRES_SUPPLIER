//
//  OrderReportViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension OrderReportViewController {
    @IBAction func actionFilterToday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterYesterday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_yesterday, textTitle: self.lbl_yesterday)
        dLog(yesterday)
        self.viewModel.date_string.accept(yesterday)
        self.viewModel.report_type.accept(REPORT_TYPE_YESTERDAY)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterThisWeek(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisweek, textTitle: self.lbl_thisWeek)
        self.viewModel.date_string.accept(thisWeek)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_WEEK)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterThisMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisMonth, textTitle: self.lbl_thisMonth)
        self.viewModel.date_string.accept(thisMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_MONTH)
        self.getOrderReport()
    }
    @IBAction func actionFilterLastMonth(_ sender:Any){
        self.checkFilterSelected(view_selected: self.view_filter_lastMonth, textTitle: self.lbl_lastMonth)
        self.viewModel.date_string.accept(lastMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_MONTH)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterThreeMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_three_Month, textTitle: self.lbl_threeMonth)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_MONTHS)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterThisYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisYear, textTitle: self.lbl_thisYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_YEAR)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterLastYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_lastYear, textTitle: self.lbl_lastYear)
        self.viewModel.date_string.accept(lastYear)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_YEAR)
        self.getOrderReport()
    }
    
    @IBAction func actionFilterThreeYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_threeYear, textTitle: self.lbl_threeYear)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_YEAR)
        self.getOrderReport()
    }
    // Thêm action filter tất cả các năm
    @IBAction func actionFilterAllYear(_ sender: Any){
        self.checkFilterSelected(view_selected: self.view_filter_AllYear, textTitle: self.lbl_AllYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_ALL_YEAR)
     
        self.getOrderReport()
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

extension OrderReportViewController:AxisValueFormatter {
    
    func setupBarChart(data:[OrderReportData],barChart:BarChartView){
        let groupCount = data.count + 1
        let groupSpace = 0.08 //inset padding of everygroup example |<-content->| (<-,-> is inset padding)
        let barSpace = 0.03
        let barWidth = 0.154
        // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
        
        barChart.chartDescription.enabled =  false
   
        barChart.legend.horizontalAlignment = .right
        barChart.legend.verticalAlignment = .top
        barChart.legend.orientation = .vertical
        barChart.legend.drawInside = true
        barChart.legend.font = .systemFont(ofSize: 8, weight: .light)
        barChart.legend.yOffset = 0
        barChart.legend.xOffset = 10
        barChart.legend.yEntrySpace = 0
        barChart.backgroundColor = UIColor.white

        barChart.xAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        barChart.xAxis.granularity = 1
        barChart.xAxis.centerAxisLabelsEnabled = true
        barChart.xAxis.labelCount = data.count
        barChart.xAxis.labelHeight = 50
        barChart.xAxis.centerAxisLabelsEnabled = true
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.axisMinimum = 0
        barChart.fitScreen()
        barChart.xAxis.axisMaximum = Double(data.count)
        let visibleXRange = 3 // Number of values to show in y-Axis
        barChart.setVisibleXRangeMaximum(Double(visibleXRange))
        barChart.xAxis.setLabelCount(visibleXRange, force: false)
        barChart.xAxis.granularity = 1
        barChart.xAxis.labelCount = visibleXRange
        barChart.dragEnabled = true


        barChart.leftAxis.labelFont = .systemFont(ofSize: 10, weight: .light)
        barChart.leftAxis.valueFormatter = self
        barChart.leftAxis.spaceTop = 0.35
        barChart.leftAxis.axisMinimum = 0
        barChart.rightAxis.enabled = false
        
        
        //======================================
        var v1: [BarChartDataEntry] = []
        var v2: [BarChartDataEntry] = []
        var v3: [BarChartDataEntry] = []
        var v4: [BarChartDataEntry] = []
        var v5: [BarChartDataEntry] = []

        
        var x_label:[String] = []
            
        for i in 0..<data.count {
           
            dLog(data[0].total_amount)
            
            x_label.append(ChartUtils.getXLabel(dateTime: data[i].report_time, reportType: viewModel.report_type.value, dataPointnth:i))
            
            let entry = BarChartDataEntry(x: Double(i), y: Double(data[i].total_amount / 1000))
            v1.append(entry)

            // Assuming these properties are available in OrderReportData
            let entry2 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_delivered_amount/1000))
            v2.append(entry2)
            
            let entry3 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_not_delivered_amount/1000))
            v3.append(entry3)
            
            let entry4 = BarChartDataEntry(x: Double(i), y: Double(data[i].order_cancel_amount/1000))
            v4.append(entry4)
            
            let entry5 = BarChartDataEntry(x: Double(i), y: Double(data[i].total_return_amount/1000))
            v5.append(entry5)
            

            
        }
//        let importDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_amount/1000))
//        }
//
//        let exportDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_delivered_amount/1000))
//        }
//
//        let returnDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_not_delivered_amount/1000))
//        }
//
//        let cancelDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(data[i].order_cancel_amount/1000))
//        }
//
//        let remainingDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
//            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_return_amount/1000))
//        }
//
//        let importDataEntryArray = (0..<data.count).map(importDataEntry)
//        let exportDataEntryArray = (0..<data.count).map(exportDataEntry)
//        let returnDataEntryArray = (0..<data.count).map(returnDataEntry)
//        let cancelDataEntryArray = (0..<data.count).map(cancelDataEntry)
//        let remainingDataEntryArray = (0..<data.count).map(remainingDataEntry)
        

        let importDataSet = BarChartDataSet(entries: v1, label: "Huỷ hàng")
        importDataSet.setColor(ColorUtils.blue_first())

        let exportDataSet = BarChartDataSet(entries: v2, label: "Đã giao")
        exportDataSet.setColor(ColorUtils.green_export())

        let returnDataSet = BarChartDataSet(entries: v3, label: "Chưa giao")
        returnDataSet.setColor(ColorUtils.orange_now())

        let cancelDataSet = BarChartDataSet(entries: v4, label: "HUỷ hàng")
        cancelDataSet.setColor(ColorUtils.red_color())

        let remainingDataSet = BarChartDataSet(entries: v5, label: "Trả hàng")
        remainingDataSet.setColor(ColorUtils.water_import())

        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:x_label)
        let chartData: BarChartData =  [importDataSet,exportDataSet,returnDataSet,cancelDataSet,remainingDataSet]
        
      

        // specify the width each bar should have
        chartData.barWidth = barWidth
        chartData.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)
        barChart.data = chartData
        
        for set in barChart.data! {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        
        //chart animation
        barChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
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

    

}

