//
//  CancelReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Charts

class CancelReportViewController: BaseViewController {

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
    
    @IBOutlet weak var view_nodata: UIView!
    
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_total_money: UILabel!
    
    var viewModel = CancelReportViewModel()
    var router = CancelReportRouter()
    let refreshControl = UIRefreshControl()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var contraints_height_tableView: NSLayoutConstraint!
    
    var colors = ColorUtils.chartColors()
    
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
        self.getCancelItemReport()
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
