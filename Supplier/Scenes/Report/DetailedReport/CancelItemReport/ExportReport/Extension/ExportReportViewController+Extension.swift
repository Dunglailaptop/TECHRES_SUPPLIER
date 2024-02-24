//
//  ExportReportViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//




import Foundation
import RxSwift
import RxRelay
import Charts

extension ExportReportViewController {
    func registerCell() {
        
        let ExportItemTableViewCell = UINib(nibName: "ExportItemTableViewCell", bundle: .main)
        tableView.register(ExportItemTableViewCell, forCellReuseIdentifier: "ExportItemTableViewCell")
        
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rx.setDelegate(self).disposed(by: rxbag)


        
    }
    
    func bindTableViewData() {
        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "ExportItemTableViewCell", cellType: ExportItemTableViewCell.self))
            {  (row, data, cell) in
                cell.data = data
                cell.viewModel = self.viewModel
        
//
                
                
                cell.selectionStyle = .none
              
            }.disposed(by: rxbag)
        refreshControl.attributedTitle = NSAttributedString(string: "Cập nhật dữ liệu mới")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewController
        

      
     }
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        viewModel.ClearData()
        refreshControl.endRefreshing()
    }
}

extension ExportReportViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension ExportReportViewController {
    @IBAction func actionFilterToday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterYesterday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_yesterday, textTitle: self.lbl_yesterday)
        dLog(yesterday)
        self.viewModel.date_string.accept(yesterday)
        self.viewModel.report_type.accept(REPORT_TYPE_YESTERDAY)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterThisWeek(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisweek, textTitle: self.lbl_thisWeek)
        self.viewModel.date_string.accept(thisWeek)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_WEEK)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterThisMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisMonth, textTitle: self.lbl_thisMonth)
        self.viewModel.date_string.accept(thisMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_MONTH)
        self.getExportItemReport()
    }
    @IBAction func actionFilterLastMonth(_ sender:Any){
        self.checkFilterSelected(view_selected: self.view_filter_lastMonth, textTitle: self.lbl_lastMonth)
        self.viewModel.date_string.accept(lastMonth)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_MONTH)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterThreeMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_three_Month, textTitle: self.lbl_threeMonth)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_MONTHS)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterThisYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisYear, textTitle: self.lbl_thisYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_YEAR)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterLastYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_lastYear, textTitle: self.lbl_lastYear)
        self.viewModel.date_string.accept(lastYear)
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_YEAR)
        self.getExportItemReport()
    }
    
    @IBAction func actionFilterThreeYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_threeYear, textTitle: self.lbl_threeYear)
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_YEAR)
        self.getExportItemReport()
    }
    // Thêm action filter tất cả các năm
    @IBAction func actionFilterAllYear(_ sender: Any){
        self.checkFilterSelected(view_selected: self.view_filter_AllYear, textTitle: self.lbl_AllYear)
        self.viewModel.date_string.accept(yearCurrent)
        self.viewModel.report_type.accept(REPORT_TYPE_ALL_YEAR)
     
        self.getExportItemReport()
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

extension ExportReportViewController {
    func setByCategoryFoodRevenuePieChart(revenues: [CancelItemReport]) {
        self.PieChart_View.noDataText = NSLocalizedString("Chưa có dữ liệu !!", comment: "")
        pieChartItems.removeAll()
        
        var s = 0.0
        for i in 0 ..< revenues.count {
            s += Double(revenues[i].total_amount)
        }
        
        for i in 0 ..< revenues.count {
            pieChartItems.append(PieChartDataEntry(value: Double(revenues[i].total_amount), label: Utils.stringVietnameseMoneyFormatWithNumber(amount: revenues[i].total_amount)))
            self.colors.append(ColorUtils.random())
        }
        let pieChartDataSet = PieChartDataSet(entries: self.pieChartItems, label: "")
        pieChartDataSet.colors = self.colors
        pieChartDataSet.sliceSpace = 2
        pieChartDataSet.selectionShift = 5
        pieChartDataSet.xValuePosition = .insideSlice
        pieChartDataSet.yValuePosition = .insideSlice
        pieChartDataSet.valueTextColor = UIColor.clear
        pieChartDataSet.valueLineWidth = 0.5
        pieChartDataSet.valueLinePart1OffsetPercentage = 0.8
        pieChartDataSet.valueLinePart2Length = 0.2
        pieChartDataSet.drawValuesEnabled = false
        pieChartDataSet.drawIconsEnabled = false
        
        
        let noZeroFormatter = NumberFormatter()
        noZeroFormatter.zeroSymbol = ""
        pieChartDataSet.valueFormatter = CustomChartView()
        ChartUtils.customPieChart(chartView: PieChart_View, total: Int(s))
        let data = PieChartData(dataSet: pieChartDataSet)
        PieChart_View.data = data
        PieChart_View.data?.isHighlightEnabled = false
        
    }
}
