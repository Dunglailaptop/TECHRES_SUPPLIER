//
//  CreateReceiptAndPaymentCategoryViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import JonAlert
import ObjectMapper
extension CreateReceiptAndPaymentCategoryViewController {
    
    
    func getReceiptAndPaymentCategory() {
        viewModel.getReceiptAndPaymentCategory().subscribe(onNext:{[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ReceiptPaymentCategoryType>().mapArray(JSONObject: response.data){
                    viewModel.categoryTypeList.accept(dataFromServer)
                }
            }else {
                JonAlert.showError(message: response.message ?? "",duration: 2.0)
            }
            
        }).disposed(by:rxbag)
    }
        
    func createReceiptAndPaymentCategory() {
        viewModel.createReceiptAndPaymentCategory().subscribe(onNext:{[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "đã thêm mới hạng mục thu chi thành công",duration: 2.0)
                viewModel.makePopViewController()
            }else {
                JonAlert.showError(message: response.message ?? "",duration: 2.0)
            }
            
        }).disposed(by:rxbag)
    }
    
    func updateReceiptAndPaymentCategory(){
        viewModel.updateReceiptAndPaymentCategory().subscribe(onNext:{[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "đã cập nhật thành công",duration: 2.0)
                viewModel.makePopViewController()
            }else {
                JonAlert.showError(message: response.message ?? "",duration: 2.0)
            }
            
        }).disposed(by:rxbag)
    }
    

}

extension CreateReceiptAndPaymentCategoryViewController: ArrayChooseCategoryViewControllerDelegate{
    func showCategoryTypeList(btnShowPopup: UIButton!){
        var listName = [String]()
        var listIcon = [String]()
        
        for categoryType in viewModel.categoryTypeList.value {
            listName.append(categoryType.name)
            listIcon.append("")
        }
           
        let controller = ArrayChooseCategoryViewController(Direction.allValues)

        controller.list_icons = listIcon
        controller.listString = listName
        controller.preferredContentSize = CGSize(width: 300, height: 300)
        controller.delegate = self

        showPopup(controller, sourceView: btnShowPopup)
    }
    
    func showNoteType(btnShowPopup: UIButton!){
        var listName = [String]()
        var listIcon = [String]()
        
        for noteType in viewModel.noteTypeArray.value {
            listName.append(noteType.description)
            listIcon.append("")
        }
           
        let controller = ArrayChooseCategoryViewController(Direction.allValues)

        controller.list_icons = listIcon
        controller.listString = listName
        controller.preferredContentSize = CGSize(width: 300, height: 300)
        controller.delegate = self
        showPopup(controller, sourceView: btnShowPopup)
    }
    
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        let presentationController = AlwaysPresentAsPopover.configurePresentation(forController: controller)
        presentationController.sourceView = sourceView
        presentationController.sourceRect = sourceView.bounds
        presentationController.permittedArrowDirections = [.down, .up]
        self.present(controller, animated: true)
    }
    
    func selectCategoryAt(pos: Int) {
        
         /*
             filterType = 0 -> loại phiếu
             filterType = 1 -> hạng mục
          */
        var cloneReceiptPaymentCategory = viewModel.receiptPaymentCategory.value
        
        switch viewModel.filterType.value {
            case 0:
                lbl_note_type.text = viewModel.noteTypeArray.value[pos].description
                cloneReceiptPaymentCategory.supplier_addition_fee_type = viewModel.noteTypeArray.value[pos].type
                break
            case 1:
                lbl_category.text = viewModel.categoryTypeList.value[pos].name
                cloneReceiptPaymentCategory.supplier_addition_fee_reason_category_id = viewModel.categoryTypeList.value[pos].id
                break
            default:
                return
        }
        viewModel.receiptPaymentCategory.accept(cloneReceiptPaymentCategory)
    }
}

