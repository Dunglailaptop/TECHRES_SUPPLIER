//
//  GeneralReportViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import ObjectMapper
class GeneralReportViewController: BaseViewController {
    var viewModel = GeneralReportViewModel()
    var router = GenenralReportRouter()
    weak var timer: Timer?
    
    @IBOutlet weak var lbl_username: UILabel!
    
    @IBOutlet weak var lbl_date_string: UILabel!
    
    @IBOutlet weak var lbl_time_string: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(self, router: router)

        
        firstSetup()
        registerTableSection()
        bindTableViewSection()
        getGeneralReport()
        getOrderReport()
        getEstimatedRevenueCostProfitReport()
        getActualRevenueCostProfitReport()
        getMaterialReport()
    }
    
    deinit {
        timer?.invalidate()
        timer = nil
    }
    
    private func firstSetup(){
        lbl_username.attributedText =  Utils.setMultipleColorForLabel(label: lbl_username,
                                                            attributes: [
                                                                (str:"Chào,", color:ColorUtils.gray_600()),
                                                                (str:ManageCacheObject.getCurrentUser().name, color:ColorUtils.orange_700())
                                                            ])
      
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self!.lbl_time_string.text = Utils.getDateString().today
            self!.lbl_date_string.text = Utils.getDateString().dateTimeNow
        }

        var cloneOrderReport = viewModel.orderReport.value
        var cloneEstimatedRevenueCostProfitReport = viewModel.estimatedRevenueCostProfitReport.value
        var cloneActualRevenueCostProfitReport = viewModel.actualRevenueCostProfitReport.value
        var cloneMaterialReport = viewModel.materialReport.value

        cloneOrderReport.report_type = REPORT_TYPE_TODAY
        cloneOrderReport.date_string = Utils.getCurrentDateString()
            
        cloneEstimatedRevenueCostProfitReport.report_type = REPORT_TYPE_TODAY
        cloneEstimatedRevenueCostProfitReport.date_string = Utils.getCurrentDateString()
        
        cloneActualRevenueCostProfitReport.report_type = REPORT_TYPE_TODAY
        cloneActualRevenueCostProfitReport.date_string = Utils.getCurrentDateString()
    
        cloneMaterialReport.report_type = REPORT_TYPE_TODAY
        cloneMaterialReport.date_string = Utils.getCurrentDateString()

        viewModel.orderReport.accept(cloneOrderReport)
        viewModel.estimatedRevenueCostProfitReport.accept(cloneEstimatedRevenueCostProfitReport)
        viewModel.actualRevenueCostProfitReport.accept(cloneActualRevenueCostProfitReport)
        viewModel.materialReport.accept(cloneMaterialReport)
    
    }
    
    
        
    
}

extension GeneralReportViewController:UITableViewDelegate{
    func registerTableSection(){
        
        let GeneralReportSection = UINib(nibName: "GeneralReportTableViewCell", bundle: Bundle.main)
        tableView.register(GeneralReportSection, forCellReuseIdentifier: "GeneralReportTableViewCell")
        
        
        let orderReportSection = UINib(nibName: "OrderReportTableViewCell", bundle: Bundle.main)
        tableView.register(orderReportSection, forCellReuseIdentifier: "OrderReportTableViewCell")
        
        let estimatedRevenueCostProfitReportSection = UINib(nibName: "EstimatedRevenueCostProfitReportTableViewCell", bundle: Bundle.main)
        tableView.register(estimatedRevenueCostProfitReportSection, forCellReuseIdentifier: "EstimatedRevenueCostProfitReportTableViewCell")
        
        let actualDataReportSection = UINib(nibName: "ActualDataReportTableViewCell", bundle: Bundle.main)
        tableView.register(actualDataReportSection, forCellReuseIdentifier: "ActualDataReportTableViewCell")
        
        let materialReportSection = UINib(nibName: "MaterialReportTableViewCell", bundle: Bundle.main)
        tableView.register(materialReportSection, forCellReuseIdentifier: "MaterialReportTableViewCell")

        tableView.rx.setDelegate(self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
    
    func bindTableViewSection(){
        viewModel.dataSection.asObservable().bind(to: tableView.rx.items){ [self](tableView,index,element) in
            switch(element){
                case 0:
                    let generalReportSection = tableView.dequeueReusableCell(withIdentifier: "GeneralReportTableViewCell") as! GeneralReportTableViewCell
                    generalReportSection.viewModel = viewModel
                    return generalReportSection
                case 1:
                    let orderReportSection = tableView.dequeueReusableCell(withIdentifier: "OrderReportTableViewCell") as! OrderReportTableViewCell
                    orderReportSection.viewModel = viewModel
                    return orderReportSection
                
                case 2:
                    let estimatedRevenueCostProfitReportSection = tableView.dequeueReusableCell(withIdentifier: "EstimatedRevenueCostProfitReportTableViewCell") as! EstimatedRevenueCostProfitReportTableViewCell
                    estimatedRevenueCostProfitReportSection.viewModel = viewModel
                    return estimatedRevenueCostProfitReportSection
                
                case 3:
                    let ActualDataReportSection = tableView.dequeueReusableCell(withIdentifier: "ActualDataReportTableViewCell") as! ActualDataReportTableViewCell
                    ActualDataReportSection.viewModel = viewModel
                    return ActualDataReportSection
                
                default:
                    let materialReportSection = tableView.dequeueReusableCell(withIdentifier: "MaterialReportTableViewCell") as! MaterialReportTableViewCell
                    materialReportSection.viewModel = viewModel
                    return materialReportSection
                
            }
        }.disposed(by: rxbag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row{
            //ĐƠN HÀNG HÔM NAY
            case 0:
                return 400
            case 1:
                return 600
            case 2:
                return 600
            case 3:
                return 600
            case 4:
                return 600
            default:
                return 600

        }
    }
}

