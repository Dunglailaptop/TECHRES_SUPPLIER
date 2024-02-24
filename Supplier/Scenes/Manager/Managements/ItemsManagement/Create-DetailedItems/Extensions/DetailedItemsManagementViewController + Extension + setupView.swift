//
//  DetailedItemsManagementViewController + Extension + setupView.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
extension DetailedItemsManagementViewController{
    
    
    
 
    func firstSetUp(){
        ateriskArr=[orange_aterisk_1,orange_aterisk_2,orange_aterisk_3,orange_aterisk_4,orange_aterisk_5,orange_aterisk_6,orange_aterisk_7]
        ateriskArr.forEach { (element) in
            element.isHidden = isAllowEditing ? false : true
        }
        item.id > 0
        ? isAllowEditing ? setUpForUpdateFunc() : setUpForShowDetailFunc()
        : setUpForCreateFunc()
        
    }
    
    

    private func setUpForCreateFunc(){
        lbl_module_title.text = "THÊM MỚI MẶT HÀNG"
        text_field_item_code.isUserInteractionEnabled = true
        text_field_item_name.isUserInteractionEnabled = true
        category_dropdown_icon.isHidden = false
        unit_dropdown_icon.isHidden = false
        specification_dropdown_icon.isHidden = false
        lbl_btn_confirm.text = "XÁC NHẬN"
        width_of_btn_confirm.constant = 130
        
        var cloneItem = viewModel.item.value
        cloneItem.price = 100
        cloneItem.retail_price = 100
        viewModel.item.accept(cloneItem)
        text_field_imported_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: viewModel.item.value.price)
        text_field_retailed_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: viewModel.item.value.retail_price)
        text_field_remaining_stock.text = Utils.stringQuantityFormatWithNumberFloat(amount: viewModel.item.value.out_stock_alert_quantity)
        text_field_wastage_ratio.text = Utils.removeZeroFromNumberFloat(number: viewModel.item.value.wastage_rate)
        mappingAndValidate()
    }
    
    private func setUpForUpdateFunc(){
        lbl_module_title.text = "CHỈNH SỬA MẶT HÀNG"
        text_field_item_code.isUserInteractionEnabled = false
        text_field_item_name.isUserInteractionEnabled = true
        category_dropdown_icon.isHidden = false
        unit_dropdown_icon.isHidden = false
        specification_dropdown_icon.isHidden = false
        lbl_btn_confirm.text = "LƯU LẠI"
        width_of_btn_confirm.constant = 110
        /*
             text_field_imported_price <=> item.price = giá nhập
             text_field_retailed_price <=> item.retail_price = giá niêm yết
             text_field_remaining_stock <=> item.out_stock_alert_quantity = số lượng báo sắp hết hàng
             text_field_wastage_ratio.text <=> item.wastage_rate = tỉ lệ hao hụt cho phép
         */
        text_field_item_code.text = item.code
        text_field_item_name.text = item.name
        text_field_imported_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: item.price)
        text_field_retailed_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: item.retail_price)
        text_field_remaining_stock.text = Utils.stringQuantityFormatWithNumberFloat(amount:item.out_stock_alert_quantity)
        text_field_wastage_ratio.text = Utils.removeZeroFromNumberFloat(number: item.wastage_rate)
        
        
        //===============================================================================================
        
        category_tag_list.addTag(item.material_category_name)
        unit_tag_list.addTag(item.material_unit_name)
        measure_spces_tag_list.addTag(item.material_unit_specification_name)
        view_of_unit_tag_list.isHidden = false
        view_of_category_tag_list.isHidden = false
        view_of_measure_specs_tag_list.isHidden = false
        
        mappingAndValidate()
        
    }
    
    private func setUpForShowDetailFunc(){
        
        lbl_module_title.text = "CHI TIẾT MẶT HÀNG"
        text_field_item_code.isUserInteractionEnabled = false
        text_field_item_name.isUserInteractionEnabled = false
        category_dropdown_icon.isHidden = true
        unit_dropdown_icon.isHidden = true
        specification_dropdown_icon.isHidden = true
        lbl_btn_confirm.text = item.id > 0 ? "LƯU LẠI" : "XÁC NHẬN"
        width_of_btn_confirm.constant = item.id > 0 ? 110 : 130
        btn_bar_view.isHidden = true
        height_of_btn_bar_view.constant = 0


        text_field_item_code.text = item.code
        text_field_item_name.text = item.name
        text_field_imported_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: item.price)
        text_field_retailed_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: item.retail_price)
        text_field_remaining_stock.text = Utils.stringQuantityFormatWithNumberFloat(amount: item.out_stock_alert_quantity)
        text_field_wastage_ratio.text = Utils.removeZeroFromNumberFloat(number: item.wastage_rate)

        
        
        
        
        //===============================================================================================
        stack_view_of_category.isUserInteractionEnabled = false
        stack_view_measure_specs.isUserInteractionEnabled = false
        stack_view_of_measure_unit.isUserInteractionEnabled = false
        category_tag_list.addTag(item.material_category_name)
        unit_tag_list.addTag(item.material_unit_name)
        measure_spces_tag_list.addTag(item.material_unit_specification_name)
        
        view_of_unit_tag_list.isHidden = false
        view_of_category_tag_list.isHidden = false
        view_of_measure_specs_tag_list.isHidden = false
        view_of_text_field_category.isHidden = true
        view_of_text_field_measure_unit.isHidden = true
        view_of_text_field_measure_specification.isHidden = true
        category_tag_list.enableRemoveButton = false
        unit_tag_list.enableRemoveButton = false
        measure_spces_tag_list.enableRemoveButton = false
    }
    
    
    private func mappingAndValidate(){
        /*
            type = 1 -> giá nhập
            type = 2 -> giá niêm yết
            type = 3 -> số lượng stock còn lại
            type = 4 -> tỉ lệ hao hụt
         */
        
        //-----------------------------------------------------mapping & subscribe validation of item name----------------------------------------------------------
        _ = text_field_item_name.rx.text.map{String($0!.prefix(51))}.map{[self] str in
            var cloneItem = viewModel.item.value
            let content = Utils.blockSpecialCharacters(str)
            
            cloneItem.name = content
            text_field_item_name.text = content
            
            if item.id <= 0{
                cloneItem.code = Utils().processString(input: content).uppercased()
                text_field_item_code.text = Utils().processString(input: content).uppercased()
            }
          
            return cloneItem
        }.bind(to:viewModel.item)
        
        isItemNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_item_name_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        //--------------------------------------------------mapping & subscribe validation of item code-------------------------------------------------------------
        
        _ = text_field_item_code.rx.text.map{String($0!.prefix(51))}.map{[self] str in
            var cloneItem = viewModel.item.value
            
            var content = Utils.blockSpecialCharacters(str)
            content = Utils().processString(input: content).uppercased()
   
            cloneItem.code = content
            text_field_item_code.text = content
            
            return cloneItem
        }.bind(to:viewModel.item)
        
        isItemCodeValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_item_code_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        
        //-----------------------------------------------------mapping & subscribe validation of import price-----------------------------------------------------------
        
        _ = imported_price_btn.rx.tap.asDriver().drive(onNext:{ [self] in
            viewModel.inputType.accept(1)
            presentCalculator(currentFigure:Double(viewModel.item.value.price),max:100000000,isAllowDecimalNumber:false)
        }).disposed(by: rxbag)
        
        isPriceValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_imported_price_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        //-------------------------------------------------------mapping & subscribe validation of retail price------------------------------------------------------
        
        
        _ = retailed_price_btn.rx.tap.asDriver().drive(onNext:{ [self] in
            viewModel.inputType.accept(2)
            presentCalculator(currentFigure:Double(viewModel.item.value.retail_price),max:100000000,isAllowDecimalNumber:false)
        }).disposed(by: rxbag)
        
        isRetailedPriceValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_retailed_price_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        //--------------------------------------------------------mapping & subscribe validation of out of stock alert quan-------------------------------------------------------
        
        
        _ = remaining_stock_btn.rx.tap.asDriver().drive(onNext:{ [self] in
            viewModel.inputType.accept(3)
            presentCalculator(currentFigure:Double(viewModel.item.value.out_stock_alert_quantity),max:100000)
        }).disposed(by: rxbag)
        
        
        isOutOfStockAlertQuantityValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_out_of_stock_alert_quan_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        //-------------------------------mapping & subscribe validation of wastage ratio---------------------------------------------------------------------------------
        
        _ = wastage_ratio_btn.rx.tap.asDriver().drive(onNext:{ [self] in
            viewModel.inputType.accept(4)
            presentCalculator(currentFigure:Double(viewModel.item.value.wastage_rate),max:100)
        }).disposed(by: rxbag)
    
        _ = isWastageRateValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_wastage_ratio_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
   
        //-------------------------------------------mapping & subscribe validation of category---------------------------------------------------------------------
//        _ = category_btn.rx.tap.asDriver().drive(onNext:{ [self] in
//            viewModel.inputType.accept(5)
//            presentDialogChooseCategory()
//        }).disposed(by: rxbag)
        

        _ = isCategoryValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_category_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        //-------------------------------------------mapping & subscribe validation of measure unit---------------------------------------------------------------------
        
        
//        _ = measure_unit_btn.rx.tap.asDriver().drive(onNext:{ [self] in
//            viewModel.inputType.accept(6)
//            presentDialogChooseCategory()
//        }).disposed(by: rxbag)

        _ = isMaterialUnitValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_unit_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        //----------------------------------------mapping & subscribe validation of measure specification------------------------------------------------------------------------
        
        
//        _ = unit_specification_btn.rx.tap.asDriver().drive(onNext:{ [self] in
//           //check the case of when user choose measure specification but not choosing measure unit at first
//            if viewModel.item.value.material_unit_id <= 0{
//                lbl_unit_err.text = "Không được bỏ trống Đơn vị"
//                lbl_unit_err.isHidden = false
//            }else {
//                viewModel.inputType.accept(7)
//                presentDialogChooseCategory()
//            }
//
//        }).disposed(by: rxbag)
        

        _ = isUnitSpecsValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_measure_specs_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        
        //----------------------------------------------------------------------------------------------------------------
        hideAllError()
        

    }
    
    
    func hideAllError(){
        lbl_item_name_err.isHidden = true
        lbl_item_code_err.isHidden = true
        lbl_imported_price_err.isHidden = true
        lbl_retailed_price_err.isHidden = true
        lbl_out_of_stock_alert_quan_err.isHidden = true
        lbl_wastage_ratio_err.isHidden = true
        lbl_category_err.isHidden = true
        lbl_unit_err.isHidden = true
        lbl_measure_specs_err.isHidden = true
    }
    
}
