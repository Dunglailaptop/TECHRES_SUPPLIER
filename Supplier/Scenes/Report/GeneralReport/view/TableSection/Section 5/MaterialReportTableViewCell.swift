//
//  MaterialReportTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import Charts

class MaterialReportTableViewCell: UITableViewCell, ChartViewDelegate {
    
    @IBOutlet weak var btn_today: UIButton!
    @IBOutlet weak var btn_yesterday: UIButton!
    @IBOutlet weak var btn_this_week: UIButton!
    @IBOutlet weak var btn_this_month: UIButton!
    @IBOutlet weak var btn_last_month: UIButton!
    @IBOutlet weak var btn_last_three_month: UIButton!
    @IBOutlet weak var btn_this_year: UIButton!
    @IBOutlet weak var btn_last_year: UIButton!
    @IBOutlet weak var btn_last_three_year: UIButton!
    @IBOutlet weak var btn_all_year: UIButton!
    
    @IBOutlet weak var barChart: BarChartView!
    
    @IBOutlet weak var lbl_total_import: UILabel!
    @IBOutlet weak var lbl_total_export: UILabel!
    @IBOutlet weak var lbl_total_return: UILabel!
    @IBOutlet weak var lbl_total_cancel: UILabel!
    @IBOutlet weak var lbl_total_remaining: UILabel!
    
    
    var btnArray:[UIButton] = []
    private(set) var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var viewModel:GeneralReportViewModel?{
        didSet{
            bindViewModel()
            btnArray = [btn_today,btn_yesterday,btn_this_week,btn_this_month,btn_last_month, btn_last_three_month,btn_this_year,btn_last_year,btn_last_three_year,btn_all_year]
            changeBgBtn(btn: btn_today)
            for btn in btnArray{
                btn.rx.tap.asDriver().drive(onNext: { [weak self] in
                    self!.changeBgBtn(btn: btn)
                }).disposed(by: disposeBag)
            }
        }
    }
    
    @IBAction func actionChooseReportType(_ sender: UIButton) {
        
        guard let viewModel = self.viewModel else {return}
        
        var cloneMaterialReport = viewModel.materialReport.value
        cloneMaterialReport.data = []
        switch sender.tag{
    
            case REPORT_TYPE_TODAY:
                cloneMaterialReport.report_type = REPORT_TYPE_TODAY
                cloneMaterialReport.date_string = Utils.getDateString().today
                break
            case REPORT_TYPE_YESTERDAY:
                cloneMaterialReport.report_type = REPORT_TYPE_YESTERDAY
                cloneMaterialReport.date_string = Utils.getDateString().yesterday
                break
            case REPORT_TYPE_THIS_WEEK:
                cloneMaterialReport.report_type = REPORT_TYPE_THIS_WEEK
                cloneMaterialReport.date_string = Utils.getDateString().thisWeek
                break
            case REPORT_TYPE_THIS_MONTH:
                cloneMaterialReport.report_type = REPORT_TYPE_THIS_MONTH
                cloneMaterialReport.date_string = Utils.getDateString().thisMonth
                break
            case REPORT_TYPE_THREE_MONTHS:
                cloneMaterialReport.report_type = REPORT_TYPE_THREE_MONTHS
                cloneMaterialReport.date_string = Utils.getDateString().threeLastMonth
                break
            case REPORT_TYPE_THIS_YEAR:
                cloneMaterialReport.report_type = REPORT_TYPE_THIS_YEAR
                cloneMaterialReport.date_string = Utils.getDateString().thisYear
                break
            case REPORT_TYPE_LAST_YEAR:
                cloneMaterialReport.report_type = REPORT_TYPE_LAST_YEAR
                cloneMaterialReport.date_string = Utils.getDateString().lastYear
                break
            case REPORT_TYPE_THREE_YEAR:
                cloneMaterialReport.report_type = REPORT_TYPE_THREE_YEAR
                cloneMaterialReport.date_string = Utils.getDateString().threeLastYear
                break
            case REPORT_TYPE_LAST_MONTH:
                cloneMaterialReport.report_type = REPORT_TYPE_LAST_MONTH
                cloneMaterialReport.date_string = Utils.getDateString().lastMonth
                break
            case REPORT_TYPE_ALL_YEAR:
                cloneMaterialReport.report_type = REPORT_TYPE_ALL_YEAR
                cloneMaterialReport.date_string = ""
                break
            default:
                break
        }
        
        viewModel.materialReport.accept(cloneMaterialReport)
        viewModel.view?.getMaterialReport()
    }
}

extension MaterialReportTableViewCell{
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.materialReport.subscribe( // Thực hiện subscribe Observable data food
              onNext: { [self] (data) in
    
                  lbl_total_import.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_import_amount)
                  lbl_total_export.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_export_amount)
                  lbl_total_return.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_return_amount)
                  lbl_total_cancel.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_cancel_amount)
                  lbl_total_remaining.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_remaining_amount)
                  
                  if data.data.count > 0 {
                      setupBarChart(data:data.data,barChart: self.barChart)
                  }
              }).disposed(by: disposeBag)
        }
            
     }
    
    private func changeBgBtn(btn:UIButton){
        for button in self.btnArray{
            button.backgroundColor = ColorUtils.gray_000()
            button.setTitleColor(ColorUtils.blue_700(),for: .normal)
            button.borderWidth = 1
            button.borderColor = ColorUtils.blue_700()
        }
        btn.borderWidth = 0
        btn.backgroundColor = ColorUtils.blue_000()
    }
    
}

extension MaterialReportTableViewCell: AxisValueFormatter{

    func setupBarChart(data:[MaterialReportData],barChart:BarChartView){
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
        barChart.xAxis.axisMinimum = 1
        barChart.fitScreen()
        barChart.xAxis.axisMaximum = Double(data.count + 1)
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
        
        var x_label:[String] = []
            
        for i in 0..<data.count {
            x_label.append(data[i].supplier_material_name)
        }
        let importDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_import/1000))
        }
        
        let exportDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_export/1000))
        }
        
        let returnDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_return/1000))
        }
        
        let cancelDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_cancel/1000))
        }
        
        let remainingDataEntry: (Int) -> BarChartDataEntry = { (i) -> BarChartDataEntry in
            return BarChartDataEntry(x: Double(i), y: Double(data[i].total_remaining/1000))
        }

        let importDataEntryArray = (0..<data.count).map(importDataEntry)
        let exportDataEntryArray = (0..<data.count).map(exportDataEntry)
        let returnDataEntryArray = (0..<data.count).map(returnDataEntry)
        let cancelDataEntryArray = (0..<data.count).map(cancelDataEntry)
        let remainingDataEntryArray = (0..<data.count).map(remainingDataEntry)
        

        let importDataSet = BarChartDataSet(entries: importDataEntryArray, label: "Nhập")
        importDataSet.setColor(ColorUtils.blue_700())

        let exportDataSet = BarChartDataSet(entries: exportDataEntryArray, label: "Xuất")
        exportDataSet.setColor(ColorUtils.green_600())

        let returnDataSet = BarChartDataSet(entries: returnDataEntryArray, label: "Trả hàng")
        returnDataSet.setColor(ColorUtils.red_600())

        let cancelDataSet = BarChartDataSet(entries: cancelDataEntryArray, label: "Huỷ hàng")
        cancelDataSet.setColor(ColorUtils.orange_700())

        let remainingDataSet = BarChartDataSet(entries: remainingDataEntryArray, label: "Tồn kho")
        remainingDataSet.setColor(ColorUtils.black())

        
        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:x_label)
        let chartData: BarChartData =  [importDataSet,exportDataSet,returnDataSet,cancelDataSet,remainingDataSet]
        
      

        // specify the width each bar should have
        chartData.barWidth = barWidth
        chartData.groupBars(fromX: 1, groupSpace: groupSpace, barSpace: barSpace)
        barChart.data = chartData
        
        for set in barChart.data! {
            set.drawValuesEnabled = !set.drawValuesEnabled
        }
        
        //chart animation
        barChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5, easingOption: .linear)
    }

    // Thêm format tiền
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        if(value > -1000 && value < 1000 ){
            return String(format: "%@ K", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
        }else if(value <= -1000 && value > -1000000 || value >= 1000 && value < 1000000){
            return String(format: "%@ Tr", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000))
        }else if( value <= -1000000 || value >= 1000000){
            return String(format: "%@ Tỷ", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value/1000000))
        }
        return String(format: "%@", Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: value))
     }
}

