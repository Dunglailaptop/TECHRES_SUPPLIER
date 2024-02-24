//
//  ExportReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts

class ExportReportViewController: BaseViewController {

    var viewModel = ExportReportViewModel()
    var router = ExportReportRouter()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contraints_height_tableView: NSLayoutConstraint!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_total_money: UILabel!
    
    
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
    
    var today = ""
    var yesterday = ""
    var monthCurrent = ""
    var yearCurrent = ""
    var Week = 1
    var thisWeek = ""
    var lastMonth = ""
    var thisMonth = ""
    var lastYear = ""
    var dateTimeNow = ""
    
    var pieChartItems = [PieChartDataEntry]()
    @IBOutlet weak var PieChart_View: PieChartView!
    var colors = ColorUtils.chartColors()
    
    @IBOutlet weak var view_nodata: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
        registerCell()
        bindTableViewData()
        getCurentTime()
        // Do any additional setup after loading the view.
    }
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        getExportItemReport()
      
    }

  

}
