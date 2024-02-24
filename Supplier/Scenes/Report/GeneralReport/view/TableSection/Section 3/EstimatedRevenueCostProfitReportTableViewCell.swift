//
//  EstimatedRevenueCostProfitReportTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts
import RxSwift
class EstimatedRevenueCostProfitReportTableViewCell: UITableViewCell {
    
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
    

    @IBOutlet weak var line_chart_view: LineChartView!
    @IBOutlet weak var lbl_total_revenue: UILabel!
    @IBOutlet weak var lbl_total_cost: UILabel!
    @IBOutlet weak var lbl_total_profit: UILabel!
    @IBOutlet weak var lbl_profit_percent: UILabel!
    
    var btnArray:[UIButton] = []
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private(set) var disposeBag = DisposeBag()
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: GeneralReportViewModel?{
        didSet{
            bindViewModel()
            btnArray = [btn_today,btn_yesterday,btn_this_week,btn_this_month,btn_last_month, btn_last_three_month,btn_this_year,btn_last_year,btn_last_three_year,btn_all_year,]
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
        var cloneEstimatedRevenueCostProfitReport = viewModel.estimatedRevenueCostProfitReport.value
        cloneEstimatedRevenueCostProfitReport.data = []
        switch sender.tag{
            case REPORT_TYPE_TODAY:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_TODAY
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().today
                break
            case REPORT_TYPE_YESTERDAY:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_YESTERDAY
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().yesterday
                break
            case REPORT_TYPE_THIS_WEEK:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_THIS_WEEK
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().thisWeek
                break
            case REPORT_TYPE_THIS_MONTH:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_THIS_MONTH
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().thisMonth
                break
            case REPORT_TYPE_THREE_MONTHS:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_THREE_MONTHS
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().threeLastMonth
                break
            case REPORT_TYPE_THIS_YEAR:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_THIS_YEAR
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().thisYear
                break
            case REPORT_TYPE_LAST_YEAR:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_LAST_YEAR
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().lastYear
                break
            case REPORT_TYPE_THREE_YEAR:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_THREE_YEAR
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().threeLastYear
                break
            case REPORT_TYPE_LAST_MONTH:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_LAST_MONTH
                cloneEstimatedRevenueCostProfitReport.date_string = Utils.getDateString().lastMonth
                break
            case REPORT_TYPE_ALL_YEAR:
                cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_ALL_YEAR
                cloneEstimatedRevenueCostProfitReport.date_string = ""
                break
            default:
                break
        }
        viewModel.estimatedRevenueCostProfitReport.accept(cloneEstimatedRevenueCostProfitReport)
        viewModel.view?.getEstimatedRevenueCostProfitReport()
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

extension EstimatedRevenueCostProfitReportTableViewCell{
    private func bindViewModel() {
        if let viewModel = viewModel {
            viewModel.estimatedRevenueCostProfitReport.subscribe(onNext: { [self] (data) in
                lbl_total_revenue.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_revenue)
                lbl_total_cost.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_cost)
                lbl_total_profit.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_profit)
                lbl_profit_percent.text = String(format: "%.2f%%",data.profit_percent)

                if data.data.count > 0{
                    setupMultiLineChart(revenueCostProfitArray:data.data, viewMultiLineChart:line_chart_view, reportType:data.report_type)
                }
                
              
          }).disposed(by: disposeBag)
        }
     }
}

extension EstimatedRevenueCostProfitReportTableViewCell:AxisValueFormatter {
    
    func setupMultiLineChart(revenueCostProfitArray:[RevenueCostProfitData], viewMultiLineChart:LineChartView,reportType:Int) {
        viewMultiLineChart.noDataText = "Chưa có dữ liệu!"
        viewMultiLineChart.noDataFont = UIFont.systemFont(ofSize: 14,weight: .semibold)
        
        var revenueLineItem = [ChartDataEntry]()
        var costLineItem = [ChartDataEntry]()
        var profitLineItem = [ChartDataEntry]()
        var x_label = [String]()
       
        for i in 0..<revenueCostProfitArray.count {
            x_label.append(ChartUtils.getXLabel(dateTime:revenueCostProfitArray[i].report_time, reportType:reportType, dataPointnth:i))
            revenueLineItem.append(ChartDataEntry(x: Double(i), y: Double(revenueCostProfitArray[i].supplier_revenue/1000)))
            costLineItem.append(ChartDataEntry(x:Double(i), y: Double(revenueCostProfitArray[i].supplier_cost/1000)))
            profitLineItem.append(ChartDataEntry(x:Double(i), y:Double(revenueCostProfitArray[i].supplier_profit/1000)))
        }

        //Line Chart
        let revenueLine = LineChartDataSet(entries: revenueLineItem, label: "revenue data")
        revenueLine.setColor(ColorUtils.blue_color())
        revenueLine.setCircleColor(ColorUtils.blue_color())
        revenueLine.drawValuesEnabled = false
        revenueLine.circleRadius = 2
        revenueLine.drawCirclesEnabled = false
        revenueLine.mode = .horizontalBezier
        
        
        let costLine = LineChartDataSet(entries: costLineItem, label: "cost data")
        costLine.setColor(ColorUtils.red_color())
        costLine.setCircleColor(ColorUtils.red_color())
        costLine.drawValuesEnabled = false
        costLine.circleHoleRadius = 10
        costLine.circleRadius = 2
        costLine.drawCirclesEnabled = false
        costLine.mode = .cubicBezier
        
        
        let profitLine = LineChartDataSet(entries: profitLineItem,label: "profit data")
        profitLine.setColor(ColorUtils.green())
        profitLine.setCircleColor(ColorUtils.green())
        profitLine.drawValuesEnabled = false
        profitLine.circleHoleRadius = 10
        profitLine.circleRadius = 2
        profitLine.drawCirclesEnabled = false
        profitLine.mode = .cubicBezier
     
        viewMultiLineChart.data = LineChartData(dataSets: [revenueLine])
        viewMultiLineChart.legend.enabled = false
        viewMultiLineChart.legend.formSize = 12
        viewMultiLineChart.legend.form = .circle
        viewMultiLineChart.legend.formLineWidth = 1
        viewMultiLineChart.legend.xEntrySpace = 10
    
        
        
        viewMultiLineChart.chartDescription.enabled = false
        viewMultiLineChart.backgroundColor = UIColor.white
        viewMultiLineChart.leftAxis.drawAxisLineEnabled = true
        viewMultiLineChart.leftAxis.drawGridLinesEnabled = true
        viewMultiLineChart.leftAxis.drawAxisLineEnabled = true
        viewMultiLineChart.leftAxis.axisLineWidth = 1

        viewMultiLineChart.leftAxis.granularity = 100
        viewMultiLineChart.leftAxis.valueFormatter = self // Thêm valueFormatter
        viewMultiLineChart.rightAxis.enabled = false
        
        
        viewMultiLineChart.xAxis.drawAxisLineEnabled = true
        viewMultiLineChart.xAxis.drawGridLinesEnabled = true
        viewMultiLineChart.xAxis.labelPosition = .bottom
        viewMultiLineChart.xAxis.drawGridLinesEnabled = true
        viewMultiLineChart.xAxis.axisLineWidth = 1
        viewMultiLineChart.xAxis.axisMinimum = 0
        viewMultiLineChart.xAxis.axisMaximum = Double(revenueCostProfitArray.count)
        viewMultiLineChart.xAxis.labelCount = ChartUtils.setLabelCountForChart(reportType: reportType, totalDataPoint: revenueCostProfitArray.count)
        viewMultiLineChart.xAxis.labelFont = UIFont.systemFont(ofSize: 9)

        
        
        viewMultiLineChart.pinchZoomEnabled = true
        viewMultiLineChart.doubleTapToZoomEnabled = false
        viewMultiLineChart.xAxis.labelRotationAngle = reportType == REPORT_TYPE_LAST_YEAR || reportType == REPORT_TYPE_THIS_YEAR ? -50 : 0
        viewMultiLineChart.xAxis.labelRotatedHeight = reportType == REPORT_TYPE_LAST_YEAR || reportType == REPORT_TYPE_THIS_YEAR ? 60 : 20
        viewMultiLineChart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)

        viewMultiLineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_label)
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
