//
//  CallAPI.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 03/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxRelay
extension GeneralReportViewController {
    
    func getGeneralReport(){
        viewModel.getGeneralReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let generalReport = Mapper<GeneralReport>().map(JSONObject: response.data) {
                    
                    viewModel.generalReport.accept(generalReport)
                    
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
    
    //Báo cáo đơn hàng
    func getOrderReport(){
        viewModel.getOrderReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var orderReport = Mapper<OrderReport>().map(JSONObject: response.data) {
                    orderReport.report_type = viewModel.orderReport.value.report_type
                    viewModel.orderReport.accept(orderReport)
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
        
    }
    
    //Báo cáo danh thu lợi nhuận ước tính
    func getEstimatedRevenueCostProfitReport() {
        viewModel.getEstimatedRevenueCostProfitReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var estimatedRevenueCostProfitReport = Mapper<RevenueCostProfitReport>().map(JSONObject: response.data) {

                    estimatedRevenueCostProfitReport.report_type = viewModel.estimatedRevenueCostProfitReport.value.report_type
                    viewModel.estimatedRevenueCostProfitReport.accept(estimatedRevenueCostProfitReport)
        
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
    
    //Báo cáo danh thu lợi nhuận thực tế
    func getActualRevenueCostProfitReport(){
        viewModel.getActualRevenueCostProfitReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var actualRevenueCostProfitReport = Mapper<RevenueCostProfitReport>().map(JSONObject: response.data) {
                    
                    actualRevenueCostProfitReport.report_type = viewModel.actualRevenueCostProfitReport.value.report_type
                   
                    viewModel.actualRevenueCostProfitReport.accept(actualRevenueCostProfitReport)
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
 
 
    //báo cao nguyên liệu
    func getMaterialReport() {
        viewModel.getMaterialReport().subscribe(onNext: { [self](response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if var materialReport = Mapper<MaterialReport>().map(JSONObject: response.data) {
                    materialReport.report_type = viewModel.materialReport.value.report_type
                    viewModel.materialReport.accept(materialReport)
                }
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")
            }
        }).disposed(by: rxbag)
    }
    
    
    
}
extension ReportGeneralViewController {
    func checkResetPassword() {
        if ManageCacheObject.getCurrentUser().is_reset_pasword == 1 {
            presentModalDialogResetPassword(type: 0)
        }
    }
    
    
    
    func presentModalDialogResetPassword(type:Int) {
        
        let DialogResetPasswordViewControllers = DialogResetPasswordViewController()
        
        DialogResetPasswordViewControllers.view.backgroundColor = ColorUtils.blackTransparent()
//        DialogConfrimShowInfoViewController.Delegate = self
        
        
        
        let nav = UINavigationController(rootViewController: DialogResetPasswordViewControllers)
        // 1
        nav.modalPresentationStyle = .overCurrentContext

        // 2
        if #available(iOS 15.0, *) {
            if let sheet = nav.sheetPresentationController {
                
                // 3
                sheet.detents = [.large()]
            }
        } else {
            // Fallback on earlier versions
        }
        // 4

        present(nav, animated: true, completion: nil)

        }
}
