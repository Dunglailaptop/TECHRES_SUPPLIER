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

class OrderReportViewController: BaseViewController {
    var viewModel = OrderReportViewModel()
    var router = OrderReportRouter()
    
    @IBOutlet weak var view_nodata: UIView!
    
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
    
    
    @IBOutlet weak var view_chart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
        // Do any additional setup after loading the view.
       
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCurentTime()
        self.checkFilterSelected(view_selected: self.view_filter_today, textTitle: self.lbl_today)
        self.viewModel.date_string.accept(dateTimeNow)
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        getOrderReport()
        Utils.isHideAllView(isHide: viewModel.dataArray.value.count > 0 ? true: false, view: view_nodata)
        
    }
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
}
