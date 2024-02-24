//
//  ReportDayOffViewController+Extension.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import JonAlert

extension DetailedItemsManagementViewController:CaculatorDelegate,DialogDelegate{
   
    
    func presentCalculator(currentFigure:Double,min:Int = 0,max:Int,isAllowDecimalNumber:Bool=true) {
        let inputQuantityViewController = InputQuantityViewController()
        inputQuantityViewController.delegate = self
        inputQuantityViewController.result = currentFigure
        inputQuantityViewController.max_quantity = Double(max)
        inputQuantityViewController.min_quantity = Double(min)
        inputQuantityViewController.isAllowDecimalNumber = isAllowDecimalNumber
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
        /*
            type = 1 -> giá nhập
            type = 2 -> giá niêm yết
            type = 3 -> số lượng stock còn lại
            type = 4 -> tỉ lệ hao hụt
            type = 5 -> danh mục
            type = 6 -> đơn vị
            type = 7 -> quy cách
         */
        switch viewModel.inputType.value{
            case 1:
                var cloneItem = viewModel.item.value
                cloneItem.price = Int(number)
                viewModel.item.accept(cloneItem)
                text_field_imported_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(number))
                isPriceValid.take(1).subscribe().disposed(by: rxbag)
                break
            case 2:
                var cloneItem = viewModel.item.value
                cloneItem.retail_price = Int(number)
                viewModel.item.accept(cloneItem)
                text_field_retailed_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(number))
                isRetailedPriceValid.take(1).subscribe().disposed(by: rxbag)
                break
            case 3:
                var cloneItem = viewModel.item.value
                cloneItem.out_stock_alert_quantity = Float(number)
                viewModel.item.accept(cloneItem)
                text_field_remaining_stock.text = Utils.stringQuantityFormatWithNumberFloat(amount: Float(String(format: "%.2f", number))!)
                isOutOfStockAlertQuantityValid.take(1).subscribe().disposed(by: rxbag)
                break
                
            case 4:
                var cloneItem = viewModel.item.value
                cloneItem.wastage_rate = Float(String(format: "%.2f", number))!
                viewModel.item.accept(cloneItem)
                text_field_wastage_ratio.text = Utils.removeZeroFromNumberFloat(number: Float(number))
                isWastageRateValid.take(1).subscribe().disposed(by: rxbag)
                break
                
            default:
                return
        }
    }
    
    
    
    func presentDialogChooseCategory() {
        let dialogChooseCategoryViewController = DialogChooseCategoryViewController()
        let item = viewModel.item.value
        switch viewModel.inputType.value{
            case 5:
                dialogChooseCategoryViewController.dialogType = .category
                dialogChooseCategoryViewController.selectedOption = GeneralObject.init(id: item.material_category_id,name: "",isSelected: ACTIVE)!
                dialogChooseCategoryViewController.dialogTitle = "Danh mục"
            case 6:
                dialogChooseCategoryViewController.dialogType = .measureUnit
                dialogChooseCategoryViewController.selectedOption = GeneralObject.init(id: item.material_unit_id,name: "",isSelected: ACTIVE)!
                dialogChooseCategoryViewController.dialogTitle = "Đơn vị"
            case 7:
                dialogChooseCategoryViewController.dialogType = .unitSpecification
                dialogChooseCategoryViewController.inputList = viewModel.measureUnitSpecifications.value.map({(element) in GeneralObject.init(id: element.id,name: element.name,isSelected: DEACTIVE)!})
                dialogChooseCategoryViewController.selectedOption = GeneralObject.init(id: item.material_unit_specification_id,name: "",isSelected: ACTIVE)!
                dialogChooseCategoryViewController.dialogTitle = "Quy cách"
            default:
                return
        }
        
        
   
        dialogChooseCategoryViewController.delegate = self
        dialogChooseCategoryViewController.view.backgroundColor = ColorUtils.blackTransparent()
        let nav = UINavigationController(rootViewController: dialogChooseCategoryViewController)
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

    
    func callBackToGetSingleResult(result: GeneralObject) {
        /*
            type = 5 -> danh mục
            type = 6 -> đơn vị
            type = 7 -> quy cách
         */
        switch viewModel.inputType.value{
            case 5:
                var cloneItem = viewModel.item.value
                cloneItem.material_category_id =  result.id
                viewModel.item.accept(cloneItem)
                text_field_category.text = result.name
                break
            
            case 6:
                var cloneItem = viewModel.item.value
                cloneItem.material_unit_id = result.id
                cloneItem.material_unit_specification_id = 0
               
                if let position = viewModel.measureUnits.value.firstIndex(where: {(element) in element.id == result.id}){
                    viewModel.measureUnitSpecifications.accept(viewModel.measureUnits.value[position].material_unit_specifications)
                }
                viewModel.item.accept(cloneItem)
                text_field_measure_specification.text = "Vui lòng chọn"
                text_field_measure_unit.text = result.name
                break
            
            case 7:
                var cloneItem = viewModel.item.value
                cloneItem.material_unit_specification_id = result.id
                viewModel.item.accept(cloneItem)
                text_field_measure_specification.text = result.name
                break
                
            default:
                return
        }
    }
    
    func callBackToGetMultipleResult(results: [GeneralObject]) {}
    

    
}








