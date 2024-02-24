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

class InventoryReportViewController: BaseViewController {
    var viewModel = InventoryReportViewModel()
    var router = InventoryReportRouter()
    
    var total_first_amount = [ChartDataEntry]()
    var total_import_amount = [ChartDataEntry]()
    var total_export_amount = [ChartDataEntry]()
    var total_cancel_amount = [ChartDataEntry]()
    var total_now_amount = [ChartDataEntry]()
    var colors = [UIColor]()
    
    
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
    
    @IBOutlet weak var view_chart: BarChartView!
    
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
    
    
    @IBOutlet weak var lbl_total_first_amount: UILabel!
    @IBOutlet weak var lbl_total_export_amount: UILabel!
    @IBOutlet weak var lbl_total_import_amount: UILabel!
    @IBOutlet weak var lbl_total_Now_amount: UILabel!
    @IBOutlet weak var lbl_total_cancel_amount: UILabel!
    
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
        getInventoryReport()
     
      
    }
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    

    
 
}
