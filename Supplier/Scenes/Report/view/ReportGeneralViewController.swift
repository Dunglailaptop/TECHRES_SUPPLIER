//
//  ReportGeneralViewController.swift
//  Supplier
//
//  Created by Kelvin on 12/07/2023.
//

import UIKit

class ReportGeneralViewController: BaseViewController {
    
    @IBOutlet weak var general_report_view: UIView!
    @IBOutlet weak var lbl_general_report: UILabel!
    @IBOutlet weak var detailed_report_view: UIView!
    @IBOutlet weak var lbl_detailed_report: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGeneralReportViewController()
       
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkResetPassword()
    }
    

    @IBAction func actionNavigateToGeneralViewController(_ sender: Any) {
        loadGeneralReportViewController()
    }
    
    
    @IBAction func actionNavigateToReportViewController(_ sender: Any) {
        loadDetailedReportViewController()
    }
    
    
    
    private func loadGeneralReportViewController(){
        changeButtonBackGroundColor(view: general_report_view, label: lbl_general_report)
        let generalReportViewController = GeneralReportViewController(nibName: "GeneralReportViewController", bundle: Bundle.main)
        addTopCustomViewController(generalReportViewController, addTopCustom: 66)
        let detailedReportViewController = DetailedReportViewController(nibName: "DetailedReportViewController", bundle: Bundle.main)
        detailedReportViewController.remove()
    }
    
    private func loadDetailedReportViewController(){
        changeButtonBackGroundColor(view: detailed_report_view, label: lbl_detailed_report)
        let detailedReportViewController = DetailedReportViewController(nibName: "DetailedReportViewController", bundle: Bundle.main)
        addTopCustomViewController(detailedReportViewController, addTopCustom: 66)
        let generalReportViewController = GeneralReportViewController(nibName: "GeneralReportViewController", bundle: Bundle.main)
        generalReportViewController.remove()
    }
    
    
    private func changeButtonBackGroundColor(view:UIView, label: UILabel){
        general_report_view.backgroundColor = ColorUtils.gray_200()
        detailed_report_view.backgroundColor = ColorUtils.gray_200()
        lbl_detailed_report.textColor = ColorUtils.gray_600()
        lbl_general_report.textColor = ColorUtils.gray_600()
        
        view.backgroundColor = ColorUtils.blue_000()
        label.textColor = ColorUtils.blue_700()
    }
    
}
