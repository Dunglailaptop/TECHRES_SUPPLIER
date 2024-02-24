//
//  OrderReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import MarqueeLabel
class CancelItemReportViewController: BaseViewController {
    
    var viewModel = CancelItemReportViewModel()
    var router = CancelItemReportRouter()
    
    @IBOutlet weak var lbl_export: UILabel!
    @IBOutlet weak var lbl_cancel: UILabel!
    
    @IBOutlet weak var view_tittle: MarqueeLabel!
    
    @IBOutlet weak var view_export: UIView!
    @IBOutlet weak var view_cancel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)
        // Do any additional setup after loading the view.
       
        Utils.lableMarqueeLabel(marqueeLabel: view_tittle)
      NewViewController()
    }
    
    
    @IBAction func actionToNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func btn_NewViewController(_ sender: Any) {
       NewViewController()
    }
    
    
    @IBAction func btn_HistoryViewController(_ sender: Any) {
      HistoryViewController()
    }
    
    
    func NewViewController() {
        view_export.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_export.textColor = UIColor(hex: "1462B0")

        view_cancel.backgroundColor = .clear
        lbl_cancel.textColor = UIColor(hex: "7D7E81")
        let CancelReportViewController = CancelReportViewController(nibName: "CancelReportViewController", bundle: Bundle.main)
        addTopCustomViewController(CancelReportViewController, addTopCustom: 130)

        let ExportReportViewController = ExportReportViewController(nibName: "ExportReportViewController", bundle: Bundle.main)
        ExportReportViewController.remove()
    }
    
    func HistoryViewController() {
        view_cancel.backgroundColor = UIColor(hex: "E3ECF5")
        lbl_cancel.textColor = UIColor(hex: "1462B0")
//
        view_export.backgroundColor = .clear
        lbl_export.textColor = UIColor(hex: "7D7E81")
        let ExportReportViewController = ExportReportViewController(nibName: "ExportReportViewController", bundle: Bundle.main)
        addTopCustomViewController(ExportReportViewController, addTopCustom: 130)
        let CancelReportViewController = CancelReportViewController(nibName: "CancelReportViewController", bundle: Bundle.main)
        CancelReportViewController.remove()
    
    }
    
}
