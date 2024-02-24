//
//  DebtReportBarChartViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts
import ObjectMapper

class DebtReportBarChartViewController: BaseViewController {
    var colors = ColorUtils.chartColors()

    
    @IBOutlet weak var view_Chart: BarChartView!
    
    @IBOutlet weak var view_filter_today: UIView!
    @IBOutlet weak var view_filter_yesterday: UIView!
    @IBOutlet weak var view_filter_thisweek: UIView!
    @IBOutlet weak var view_filter_thisMonth: UIView!
    @IBOutlet weak var view_filter_lastMonth: UIView!
    @IBOutlet weak var view_filter_three_Month: UIView!
    @IBOutlet weak var view_filter_thisYear: UIView!
    @IBOutlet weak var view_filter_lastYear: UIView!
    @IBOutlet weak var view_filter_threeYear: UIView!
    @IBOutlet weak var view_filter_AllYear: UIView!
    
    
    @IBOutlet weak var lbl_today: UILabel!
    @IBOutlet weak var lbl_yesterday: UILabel!
    @IBOutlet weak var lbl_thisWeek: UILabel!
    @IBOutlet weak var lbl_thisMonth: UILabel!
    @IBOutlet weak var lbl_lastMonth: UILabel!
    @IBOutlet weak var lbl_threeMonth: UILabel!
    @IBOutlet weak var lbl_thisYear: UILabel!
    @IBOutlet weak var lbl_lastYear: UILabel!
    @IBOutlet weak var lbl_threeYear: UILabel!
    @IBOutlet weak var lbl_AllYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        // Do any additional setup after loading the view.
    }


    var viewModel: DebtReportViewModel? = nil {
        didSet {
            getReportBarChart()
        }
    }
    
    @IBAction func actionChooseReportType(_ sender: UIButton) {
        
        guard let viewModel = self.viewModel else {return}
        
        var dataModel = viewModel.dataArray.value
        dLog(sender.tag)
        switch sender.tag{
            case REPORT_TYPE_TODAY:
            self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
            dataModel.report_type = REPORT_TYPE_TODAY
            dataModel.date_string = Utils.getDateString().today
                break
            case REPORT_TYPE_YESTERDAY:
            self.checkFilterSelected(view_selected: self.view_filter_yesterday, textTitle: self.lbl_yesterday)
            dataModel.report_type = REPORT_TYPE_YESTERDAY
            dataModel.date_string = Utils.getDateString().yesterday
                break
            case REPORT_TYPE_THIS_WEEK:
            self.checkFilterSelected(view_selected: self.view_filter_thisweek, textTitle: self.lbl_thisWeek)
            dataModel.report_type = REPORT_TYPE_THIS_WEEK
            dataModel.date_string = Utils.getDateString().thisWeek
                break
            case REPORT_TYPE_THIS_MONTH:
            self.checkFilterSelected(view_selected: self.view_filter_thisMonth, textTitle: self.lbl_thisMonth)
            dataModel.report_type = REPORT_TYPE_THIS_MONTH
            dataModel.date_string = Utils.getDateString().thisMonth
                break
            case REPORT_TYPE_THREE_MONTHS:
            self.checkFilterSelected(view_selected: self.view_filter_three_Month, textTitle: self.lbl_threeMonth)
            dataModel.report_type = REPORT_TYPE_THREE_MONTHS
            dataModel.date_string = Utils.getDateString().threeLastMonth
                break
            case REPORT_TYPE_THIS_YEAR:
            self.checkFilterSelected(view_selected: self.view_filter_thisYear, textTitle: self.lbl_thisYear)
            dataModel.report_type = REPORT_TYPE_THIS_YEAR
            dataModel.date_string = Utils.getDateString().thisYear
                break
            case REPORT_TYPE_LAST_YEAR:
            self.checkFilterSelected(view_selected: self.view_filter_lastYear, textTitle: self.lbl_lastYear)
            dataModel.report_type = REPORT_TYPE_LAST_YEAR
            dataModel.date_string = Utils.getDateString().lastYear
                break
            case REPORT_TYPE_THREE_YEAR:
            self.checkFilterSelected(view_selected: self.view_filter_threeYear, textTitle: self.lbl_threeYear)
            dataModel.report_type = REPORT_TYPE_THREE_YEAR
            dataModel.date_string = Utils.getDateString().threeLastYear
                break
            case REPORT_TYPE_LAST_MONTH:
            self.checkFilterSelected(view_selected: self.view_filter_lastMonth, textTitle: self.lbl_lastMonth)
            dataModel.report_type = REPORT_TYPE_LAST_MONTH
            dataModel.date_string = Utils.getDateString().lastMonth
                break
            case REPORT_TYPE_ALL_YEAR:
            self.checkFilterSelected(view_selected: self.view_filter_AllYear, textTitle: self.lbl_AllYear)
            dataModel.report_type = REPORT_TYPE_ALL_YEAR
            dataModel.date_string = ""
                break
            default:
                break
        }
        viewModel.dataArray.accept(dataModel)
        getReportBarChart()
//        viewModel.actualRevenueCostProfitReport.accept(cloneActualRevenueCostProfitReport)
//        viewModel.view?.getActualRevenueCostProfitReport()
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


extension DebtReportBarChartViewController: AxisValueFormatter{
    func setupBarChart(revenues:DebtReport){
        view_Chart.noDataText = "Chưa có dữ liệu !!"
        let totalpending = revenues.order_pending_payment_amount
        let totalwarehouse = revenues.warehouse_session_pending_payment_amount
        var barChartItems = [BarChartDataEntry]()
        
        //Chart Data
        barChartItems.append(BarChartDataEntry(x: Double(0), y: Double(totalpending/1000)))
        barChartItems.append(BarChartDataEntry(x: Double(1), y: Double(totalwarehouse/1000)))
        //Bar Chart
        let barChartDataSet = BarChartDataSet(entries: barChartItems, label: "")
        barChartDataSet.setColors(ColorUtils.blue_color(), ColorUtils.red_color(), ColorUtils.main_color())
        barChartDataSet.drawValuesEnabled = false
        barChartDataSet.colors = colors
//        barChartDataSet.valueFormatter = MyValueFormatter()
        
        view_Chart.data = BarChartData(dataSet: barChartDataSet)
        view_Chart.fitScreen()
        view_Chart.legend.enabled = false
        view_Chart.chartDescription.enabled = false
        view_Chart.backgroundColor = UIColor.white
        view_Chart.leftAxis.drawAxisLineEnabled = true
        view_Chart.leftAxis.drawGridLinesEnabled = true
        view_Chart.leftAxis.axisMinimum = 0
        view_Chart.leftAxis.valueFormatter = self // Thêm valueFormatter
        view_Chart.rightAxis.enabled = false
        view_Chart.xAxis.drawAxisLineEnabled = false
        view_Chart.xAxis.drawGridLinesEnabled = true
        view_Chart.xAxis.labelPosition = .bottom
        view_Chart.xAxis.drawGridLinesEnabled = false
        view_Chart.xAxis.axisMinimum = -1
        view_Chart.xAxis.axisMaximum = Double(barChartItems.count)
        view_Chart.xAxis.labelCount = barChartItems.count + 1
        view_Chart.xAxis.labelFont = NSUIFont(descriptor: UIFontDescriptor(name: "System", size: 10), size: 10)
        //        bar_chart.xAxis.labelRotationAngle = -60.0
        //            cell.bar_chart.xAxis.labelRotatedHeight = CGFloat(100.0)
        view_Chart.animate(xAxisDuration: 2.0, yAxisDuration: 3.0, easingOption: ChartEasingOption.easeInOutQuart)
        view_Chart.pinchZoomEnabled = false
        view_Chart.doubleTapToZoomEnabled = false
        view_Chart.xAxis.labelRotationAngle = -50
        view_Chart.xAxis.labelRotatedHeight = CGFloat(60)
        //label
        var x_label = [String]()
        x_label.append("Công nợ thu")
        x_label.append("Công nợ trả")
        view_Chart.xAxis.valueFormatter = IndexAxisValueFormatter(values: x_label)
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
}


//CALL MARK: API
extension DebtReportBarChartViewController {
    private func getReportBarChart(){
        viewModel?.getDebtReport().subscribe(onNext: { [self](response) in
                if(response.code == RRHTTPStatusCode.ok.rawValue){
                    if let debtReport = Mapper<DebtReport>().map(JSONObject: response.data) {
                        dLog(debtReport)
                        setupBarChart(revenues: debtReport)
                    }
                }else{
                    dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
                }
            }).disposed(by: rxbag)
    }
}
