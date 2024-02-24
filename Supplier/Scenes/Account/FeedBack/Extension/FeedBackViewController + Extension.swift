//
//  FeedBackViewController + Extension.swift
//  SEEMT
//
//  Created by Pham Khanh Huy on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert
extension FeedBackViewController: ArrayShowDropdownViewControllerDelegate {
        func showFilter(){
            let controller = ArrayShowDropdownViewController(Direction.allValues)
            controller.listString = listTypeOfFilterDialog
            controller.preferredContentSize = CGSize(width: 250, height: 160)
            controller.delegate = self
            showPopup(controller, sourceView: self.btn_show_filter)
        }
        
        private func showPopup(_ controller: UIViewController, sourceView: UIView) {
            let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
            presentationController.sourceView = sourceView
            presentationController.sourceRect = sourceView.bounds
            presentationController.permittedArrowDirections = [.up]
            self.present(controller, animated: true)
        }
        
        func selectAt(pos: Int) {
            if(pos == 0) { // if user choose this option, we're unable confirm btn
                lbl_filter_type.text = "Bạn muốn góp ý về điều gì?"
                lbl_filter_type.textColor = ColorUtils.gray_400()
                viewModel.type.accept(-1)
            }else if (pos == 1){
                lbl_filter_type.text = "Yêu cầu cải tiến"
                lbl_filter_type.textColor = .black
                viewModel.type.accept(0)
            }else if(pos == 2){
                lbl_filter_type.text = "Đề nghị làm lại"
                lbl_filter_type.textColor = .black
                viewModel.type.accept(1)
            }else {
                return
            }
        }
        
    
}



extension FeedBackViewController{
    func sendFeedBack(){
        viewModel.sendFeedBack().subscribe(onNext: {[weak self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Đã gửi yêu cầu thành công")
                self!.viewModel.makePopViewController()
            }else{
                dLog(response.message ?? "Có lỗi xảy ra trong quá trình kết nối tới máy chủ. Vui lòng thử lại")

            }
            
        })
    }
    
    
}
