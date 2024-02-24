//
//  OrderReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import Charts
class RestaurantOrderReportViewController: BaseViewController {
    var viewModel = RestaurantOrderReportViewModel()
    var router = RestaurantOrderReportRouter()
    @IBOutlet weak var pieChartRestaurantOrder: PieChartView!
    @IBOutlet weak var view_filter_today: UIView!
    @IBOutlet weak var view_filter_yesterday: UIView!
    @IBOutlet weak var view_filter_thisweek: UIView!
    @IBOutlet weak var view_filter_thismonth: UIView!
    
    @IBOutlet weak var view_filter_last_month: UIView!
    @IBOutlet weak var view_filter_three_month: UIView!
    @IBOutlet weak var view_filter_this_year: UIView!
    @IBOutlet weak var view_filter_last_year: UIView!
    @IBOutlet weak var view_filter_three_year: UIView!
    @IBOutlet weak var view_filter_All_year: UIView!

    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var height_tableView: NSLayoutConstraint!
    
    var time = ""
    var today = ""
    var yesterday = ""
    var monthCurrent = ""
    var yearCurrent = ""
    var Week = 1
    var thisWeek = ""
    var lastMonth = ""
    var thisMonth = ""
    var lastYear = ""
    var lastThreeMonth = ""
    var lastThreeYear = ""
    var currentYear = ""
    var dateTimeNow = ""
 
    @IBOutlet weak var view_nodata: UIView!
    var report_type = REPORT_TYPE_TODAY
    var colors = [UIColor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
        
        registerCell()
        bindTableView()
        // Do any additional setup after loading the view.
        getCurentTime()
        checkFilterSelected(view_selected: view_filter_today)
        viewModel.reportType.accept(REPORT_TYPE_TODAY)
        viewModel.dateString.accept(dateTimeNow)
        getRestaurantOrderReport()
    }
    
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
  
}

extension RestaurantOrderReportViewController{
    @IBAction func actionFilterToday(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_today)
        viewModel.reportType.accept(REPORT_TYPE_TODAY)
        viewModel.dateString.accept(dateTimeNow)
        dLog(dateTimeNow)
        getRestaurantOrderReport()
    }
    
    @IBAction func actionFilterYesterday(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_yesterday)
        viewModel.reportType.accept(REPORT_TYPE_YESTERDAY)
        viewModel.dateString.accept(yesterday)
        getRestaurantOrderReport()
    }
    
    @IBAction func actionFilterThisWeek(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_thisweek)
        viewModel.reportType.accept(REPORT_TYPE_THIS_WEEK)
        viewModel.dateString.accept(thisWeek)
        getRestaurantOrderReport()
    }
    
    @IBAction func actionFilterThisMonth(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_thismonth)
        viewModel.reportType.accept(REPORT_TYPE_THIS_MONTH)
        viewModel.dateString.accept(thisMonth)
        getRestaurantOrderReport()
    }
    
    @IBAction func actionFilterLastMonth(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_last_month)
        viewModel.reportType.accept(REPORT_TYPE_LAST_MONTH)
        viewModel.dateString.accept(lastMonth)
        getRestaurantOrderReport()
    }

    @IBAction func actionFilterThreeMonth(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_three_month)
        viewModel.reportType.accept(REPORT_TYPE_THREE_MONTHS)
        viewModel.dateString.accept(lastThreeMonth)
        getRestaurantOrderReport()
    }
    
    @IBAction func actionFilterThisYear(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_this_year)
        viewModel.reportType.accept(REPORT_TYPE_THIS_YEAR)
        viewModel.dateString.accept(currentYear)
        getRestaurantOrderReport()
    }

    @IBAction func actionFilterLastYear(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_last_year)
        viewModel.reportType.accept(REPORT_TYPE_LAST_YEAR)
        viewModel.dateString.accept(lastYear)
        getRestaurantOrderReport()
    }
    @IBAction func actionFilterThreeYear(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_three_year)
        viewModel.reportType.accept(REPORT_TYPE_THREE_YEAR)
        viewModel.dateString.accept(lastThreeYear)
        getRestaurantOrderReport()
    }
    
    
    @IBAction func actionFilterAllYear(_ sender: Any) {
        checkFilterSelected(view_selected: view_filter_All_year)
        viewModel.reportType.accept(REPORT_TYPE_ALL_YEAR)
        viewModel.dateString.accept(currentYear)
        getRestaurantOrderReport()
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        
        viewModel.makePopViewController()
    }
    func checkFilterSelected(view_selected:UIView){
        view_filter_today.backgroundColor = ColorUtils.gray_200()
        view_filter_yesterday.backgroundColor = ColorUtils.gray_200()
        view_filter_thisweek.backgroundColor = ColorUtils.gray_200()
        view_filter_thismonth.backgroundColor = ColorUtils.gray_200()
        view_filter_last_month.backgroundColor = ColorUtils.gray_200()
        view_filter_three_month.backgroundColor = ColorUtils.gray_200()
        view_filter_this_year.backgroundColor = ColorUtils.gray_200()
        view_filter_last_year.backgroundColor = ColorUtils.gray_200()
        view_filter_three_year.backgroundColor = ColorUtils.gray_200()
        view_filter_All_year.backgroundColor = ColorUtils.gray_200()

        view_selected.backgroundColor = ColorUtils.blue_000()
    }
    
    func getCurentTime(){
        yesterday = Utils.getYesterdayString()
        dateTimeNow = Utils.getCurrentDateString()
        thisWeek = Utils.getCurrentWeekString()
        lastThreeMonth = Utils.getLastThreeMonthString()
        lastMonth = Utils.getLastMonthString()
        thisMonth = Utils.getCurrentMonthString()
        lastThreeYear = Utils.getLastThreeYearString()
        lastYear = Utils.getLastYearString()
        currentYear = Utils.getCurrentYearString()
    }
}
