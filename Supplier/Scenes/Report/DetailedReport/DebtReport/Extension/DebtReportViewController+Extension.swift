//
//  DebtReportViewController+Extension.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//


import UIKit


extension DebtReportViewController {
   
    func newViewController() {
        view_table.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_table.textColor = UIColor(hex: "1462B0")

        view_Barchart.backgroundColor = .clear
        lbl_Barchart.textColor = UIColor(hex: "7D7E81")
        let DebtReportTableViewController = DebtReportTableViewController(nibName: "DebtReportTableViewController", bundle: Bundle.main)
        addTopCustomViewController(DebtReportTableViewController, addTopCustom: 130)

        let DebtReportBarChartViewController = DebtReportBarChartViewController(nibName: "DebtReportBarChartViewController", bundle: Bundle.main)
        DebtReportBarChartViewController.remove()
    }
 
    func historyViewController() {
        view_Barchart.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_Barchart.textColor = UIColor(hex: "1462B0")

        view_table.backgroundColor = .clear
        lbl_table.textColor = UIColor(hex: "7D7E81")
        let DebtReportBarChartViewController = DebtReportBarChartViewController(nibName: "DebtReportBarChartViewController", bundle: Bundle.main)
        addTopCustomViewController(DebtReportBarChartViewController, addTopCustom: 130)
        DebtReportBarChartViewController.viewModel = self.viewModel
        let DebtReportTableViewController = DebtReportTableViewController(nibName: "DebtReportTableViewController", bundle: Bundle.main)
        DebtReportTableViewController.remove()
    }
    
}
