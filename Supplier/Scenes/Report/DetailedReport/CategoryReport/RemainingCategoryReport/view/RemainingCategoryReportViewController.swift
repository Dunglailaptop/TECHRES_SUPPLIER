//
//  RemainingCategoryReportViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import Charts

class RemainingCategoryReportViewController: BaseViewController {
    
    var viewModel = RemainingCategoryReportViewModel()
    var router = RemainingCategoryReportRouter()
    
    
    @IBOutlet weak var root_view_empty_data_chart: UIView!
    @IBOutlet weak var root_view_empty_data: UIView!
    @IBOutlet weak var pie_chart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableItemView: UITableView!
    
    // MARK: Biến của button filter
    @IBOutlet weak var view_filter_today: UIView!
    @IBOutlet weak var view_filter_yesterday: UIView!
    @IBOutlet weak var view_filter_thisweek: UIView!
    @IBOutlet weak var view_filter_thismonth: UIView!
    @IBOutlet weak var view_filter_lastmonth: UIView!
    @IBOutlet weak var view_filter_three_month: UIView!
    @IBOutlet weak var view_filter_this_year: UIView!
    @IBOutlet weak var view_filter_last_year: UIView!
    @IBOutlet weak var view_filter_three_year: UIView!
    @IBOutlet weak var view_filter_all_year: UIView!
    
    @IBOutlet weak var btnFilterToday: UIButton!
    @IBOutlet weak var btnFilterYesterday: UIButton!
    @IBOutlet weak var btnFilterThisweek: UIButton!
    @IBOutlet weak var btnFilterThismonth: UIButton!
    @IBOutlet weak var btnFilterLastmonth: UIButton!
    @IBOutlet weak var btnFilterThreeMonth: UIButton!
    @IBOutlet weak var btnFilterThisYear: UIButton!
    @IBOutlet weak var btnFilterLastYear: UIButton!
    @IBOutlet weak var btnFilterThreeYear: UIButton!
    @IBOutlet weak var btnFilterAllYear: UIButton!
    
    var pieChartItems = [PieChartDataEntry]()
    var colors = ColorUtils.chartColors()
    
    // MARK: Declare variable filter
    var (thisWeek, thisMonth, lastMonth, threeLastMonth, yearCurrent, lastYear, threeLastYear, dateTimeNow, today, yesterday) = Utils.getDateString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCellItem()
        bindTableItemView()
        registerCell()
        bindTableView()
}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkFilterSelected(view_selected: view_filter_thismonth)
        viewModel.date_string.accept(Utils.getCurrentDateString())
        viewModel.report_type.accept(REPORT_TYPE_TODAY)
        getCategoryReport()
        
    }
    
}
