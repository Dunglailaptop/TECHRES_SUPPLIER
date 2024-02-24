//
//  CreateUnitSpecificationViewController + Extension + API.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import JonAlert
//MARK:call API
extension CreateUnitSpecificationViewController{

    func createMaterialUnitSpecification(){
        viewModel.CreateMaterialUnitSpecification().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Thêm mới Quy cách thành công",duration:2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }
    
    
    func updateMaterialUnitSpecs(){
        viewModel.updateMaterialUnitSpecs().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                JonAlert.showSuccess(message: "Chỉnh sửa Quy cách thành công",duration:2.0)
                viewModel.makePopViewController()
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
        }).disposed(by: rxbag)
    }

    
    


    
    func getExchangeUnitSpecsList(){
        viewModel.getExchangeUnitSpecsList().subscribe(onNext: {[self] (response) in
            if(response.code == RRHTTPStatusCode.ok.rawValue){
                if let dataFromServer = Mapper<ExchangeUnitSpecification>().mapArray(JSONObject: response.data) {
                    viewModel.ExchangeUnitSpecsList.accept(dataFromServer)
                         
                    
                    dropdown.optionArray = viewModel.ExchangeUnitSpecsList.value.map{$0.name}
          
                    dropdown.optionIds = viewModel.ExchangeUnitSpecsList.value.map{$0.id}
                    
                    if viewModel.unitSpecification.value.id > 0 {
                        if let position = viewModel.ExchangeUnitSpecsList.value.firstIndex(where: {(element) in element.id == viewModel.unitSpecification.value.material_unit_specification_exchange_name_id}){
                            dropdown.text = viewModel.ExchangeUnitSpecsList.value[position].name
                            dropdown.selectedIndex = position
                        }
                    }
                    

                    lbl_unit_specs_name_error.isHidden = true
                    lbl_exchange_unit_error.isHidden = true
                }
            }else{
                JonAlert.showError(message: response.message ?? "",duration:  2.0)
            }
            
        }).disposed(by: rxbag)
    }
    
    
}


extension CreateUnitSpecificationViewController:CaculatorDelegate{
    func presentCalculator() {
        let inputQuantityViewController = InputQuantityViewController()
        inputQuantityViewController.max_quantity = 100000.0
//        inputQuantityViewController.min_quantity = 
        inputQuantityViewController.result = Double(viewModel.unitSpecification.value.exchange_value)
        inputQuantityViewController.isAllowDecimalNumber = false
        inputQuantityViewController.titleCalculator = "NHẬP SỐ LƯỢNG"
        inputQuantityViewController.delegate = self
        inputQuantityViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: inputQuantityViewController)
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


            present(nav, animated: true, completion: nil)
        }
      
    func callbackToGetResult(number: Double) {
        lbl_exchange_value.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: number)
        var cloneNewUnitSpecification = viewModel.unitSpecification.value
        cloneNewUnitSpecification.exchange_value = Int(number)
        viewModel.unitSpecification.accept(cloneNewUnitSpecification)
    }
    
}

