//
//  ImportItemsReport+Extension+ActionFilter.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 16/05/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay

extension ExportItemsReportViewController {
    @IBAction func actionFilterToday(_ sender: Any) {
        
        self.checkFilterSelected(view_selected: self.view_filter_today)
        
        self.viewModel.report_type.accept(REPORT_TYPE_TODAY)
        self.viewModel.date_string.accept(self.dateTimeNow)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterYesterday(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_yesterday)
        
        self.viewModel.report_type.accept(REPORT_TYPE_YESTERDAY)
        self.viewModel.date_string.accept(self.yesterday)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterThisWeek(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thisweek)
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_WEEK)
        self.viewModel.date_string.accept(self.thisWeek)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterThisMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_thismonth)
        
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_MONTH)
        self.viewModel.date_string.accept(self.thisMonth)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterLastMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_lastmonth)
        
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_MONTH)
        self.viewModel.date_string.accept(self.lastMonth)
        self.getItemsReport()
    }
    
    
    @IBAction func actionFilterThreeMonth(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_three_month)
        
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_MONTHS)
        self.viewModel.date_string.accept(self.threeLastMonth)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterThisYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_this_year)
        
        self.viewModel.report_type.accept(REPORT_TYPE_THIS_YEAR)
        self.viewModel.date_string.accept(self.yearCurrent)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterLastYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_last_year)
        
        self.viewModel.report_type.accept(REPORT_TYPE_LAST_YEAR)
        self.viewModel.date_string.accept(self.lastYear)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterThreeYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_three_year)
        
        self.viewModel.report_type.accept(REPORT_TYPE_THREE_YEAR)
        self.viewModel.date_string.accept(self.threeLastYear)
        self.getItemsReport()
    }
    
    @IBAction func actionFilterAllYear(_ sender: Any) {
        self.checkFilterSelected(view_selected: self.view_filter_all_year)
        self.viewModel.report_type.accept(REPORT_TYPE_ALL_YEAR)
        self.viewModel.date_string.accept(self.yearCurrent)
        self.getItemsReport()
    }
    
    func checkFilterSelected(view_selected:UIView){
        view_filter_today.backgroundColor = .white
        view_filter_yesterday.backgroundColor = .white
        view_filter_thisweek.backgroundColor = .white
        view_filter_thismonth.backgroundColor = .white
        view_filter_lastmonth.backgroundColor = .white
        view_filter_three_month.backgroundColor = .white
        view_filter_this_year.backgroundColor = .white
        view_filter_last_year.backgroundColor = .white
        view_filter_three_year.backgroundColor = .white
        view_filter_all_year.backgroundColor = .white
        
        
        view_filter_today.borderWidth = 1
        view_filter_yesterday.borderWidth = 1
        view_filter_thisweek.borderWidth = 1
        view_filter_thismonth.borderWidth = 1
        view_filter_lastmonth.borderWidth = 1
        view_filter_three_month.borderWidth = 1
        view_filter_this_year.borderWidth = 1
        view_filter_last_year.borderWidth = 1
        view_filter_three_year.borderWidth = 1
        view_filter_all_year.borderWidth = 1
        
        view_selected.backgroundColor = ColorUtils.blueTransparent()
        view_selected.borderWidth = 0
    }
}
