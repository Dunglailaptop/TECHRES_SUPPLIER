//
//  CreateMaterialUnitViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import TagListView
import Foundation
import RxSwift
import JonAlert
import iOSDropDown
class CreateMaterialUnitViewController: BaseViewController {
    var viewModel = CreateMaterialUnitViewModel()
    var router = CreateMaterialUnitRouter()
    var materialUnit:MaterialUnit?
    var isAllowToEdit:Bool = true
//    var heightConstraint: NSLayoutConstraint?
    
    
    
    
    
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var text_field_code: UITextField!
    
    @IBOutlet weak var lbl_unit_code_error: UILabel!
    @IBOutlet weak var text_field_unit_name: UITextField!
    @IBOutlet weak var lbl_unit_name_error: UILabel!
    
    @IBOutlet weak var description_view: UIView!
    @IBOutlet weak var text_view_description: UITextView!
    
    @IBOutlet weak var lbl_description_err: UILabel!
    
    @IBOutlet weak var lbl_number_of_text_in_text_view: UILabel!
    
    
    @IBOutlet weak var tag_list_view: TagListView!

    @IBOutlet weak var lbl_no_data: UILabel!
    @IBOutlet weak var height_of_btn_filter: NSLayoutConstraint!
    @IBOutlet weak var height_of_tag_view: NSLayoutConstraint!
    
    @IBOutlet weak var icon_dropdown: UIButton!
    @IBOutlet weak var dropDown: DropDown!
    @IBOutlet weak var lbl_tag_view_err: UILabel!
    
    @IBOutlet weak var width_of_btn_confirm: NSLayoutConstraint!
    
    
    
    //Outlet btn-bar
    @IBOutlet weak var cancel_view: UIView!
    @IBOutlet weak var cancel_icon: UIImageView!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var confirm_view: UIView!
    @IBOutlet weak var confirm_icon: UIImageView!
    @IBOutlet weak var lbl_confirm: UILabel!
    @IBOutlet weak var btn_bar_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        firstSetUp()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self)
    }
    
    private func firstSetUp(){
        tag_list_view.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        tag_list_view.delegate = self
        tag_list_view.enableRemoveButton = isAllowToEdit ? true : false
        btn_bar_view.addShadow(shadowOffset: .zero, shadowOpacity: 0.7, shadowRadius: 10, color: .black)
        dropDown.hideOptionsWhenSelect = false
        dropDown.placeholder = isAllowToEdit ? "Vui Lòng chọn" : ""
        dropDown.isUserInteractionEnabled = isAllowToEdit ? true : false
        dropDown.showTextAfterSelect = false
        icon_dropdown.isHidden = isAllowToEdit ? false : true
        text_field_code.isUserInteractionEnabled = isAllowToEdit ? true : false
        text_field_unit_name.isUserInteractionEnabled = isAllowToEdit ? true : false
        text_view_description.isUserInteractionEnabled = isAllowToEdit ? true : false
        height_of_btn_filter.constant = isAllowToEdit ? 30 : 0
        btn_bar_view.isHidden = isAllowToEdit ? false : true
        width_of_btn_confirm.constant = materialUnit!.id > 0 ? 110 : 130
        lbl_confirm.text = materialUnit!.id > 0 ? "LƯU LẠI" : "XÁC NHẬN"
        text_view_description.addDoneButtonOnKeyboard()
        
        if materialUnit!.id > 0 {
            //if update -> "CHÌNH SỬA ĐƠN VỊ" , else -> "CHI TIẾT ĐƠN VỊ"
            lbl_title.text = isAllowToEdit ? "CHỈNH SỬA ĐƠN VỊ" : "CHI TIẾT ĐƠN VỊ"
            text_field_code.text = materialUnit?.code
            text_field_unit_name.text = materialUnit?.name
            text_view_description.text = materialUnit?.description
            viewModel.newMaterialUnit.accept(materialUnit!)
        }
        
        
        if isAllowToEdit{
            //----------------------------------------mapping & subscribe validation of unit code------------------------------------------------------------------------
            _ = text_field_code.rx.text.distinctUntilChanged().map{String($0!.prefix(51))}.map({[self](str) -> MaterialUnit in
                var cloneNewMaterialUnit = self.viewModel.newMaterialUnit.value

                var content = Utils.blockSpecialCharacters(Utils.blockSpace(str))
                content = Utils().removeDiacriticsAndD(from: content).uppercased()
                
                
                cloneNewMaterialUnit.code = content
                text_field_code.text = content
            
                return cloneNewMaterialUnit
            }).bind(to: viewModel.newMaterialUnit)
            
            
            _ = isUnitCodeValid.subscribe(onNext:{[weak self] (isValid) in
                self!.lbl_unit_code_error.isHidden = isValid ? true : false
            }).disposed(by: rxbag)
            
            //----------------------------------------mapping & subscribe validation of unit name------------------------------------------------------------------------
            
        
            _ = text_field_unit_name.rx.text.distinctUntilChanged().map{String($0!.prefix(51))}.map({[self](str) -> MaterialUnit in
                var cloneNewMaterialUnit = self.viewModel.newMaterialUnit.value
                let content = Utils.blockSpecialCharacters(str)
                
                cloneNewMaterialUnit.name = content
                text_field_unit_name.text = content
                
                
                cloneNewMaterialUnit.code = Utils().processString(input: content).uppercased()
                text_field_code.text = Utils().processString(input: content).uppercased()
                
                return cloneNewMaterialUnit
            }).bind(to: viewModel.newMaterialUnit)
            
            
            _ = isUnitNameValid.subscribe(onNext:{[weak self] (isValid) in
                self!.lbl_unit_name_error.isHidden = isValid ? true : false
            }).disposed(by: rxbag)
            
            //----------------------------------------mapping & subscribe validation of measure specification------------------------------------------------------------------------
            
    
            dropDown.didSelect{ [self](selectedText , index ,id) in
              
                var cloneunitSpecsList = viewModel.unitSpecsList.value
                if let position = cloneunitSpecsList.firstIndex(where: {(element) in element.id == id}){
                    cloneunitSpecsList[position].isSelected = ACTIVE
                }
                viewModel.unitSpecsList.accept(cloneunitSpecsList)
                    
                tag_list_view.addTag(selectedText,id: id)
                lbl_no_data.isHidden = true
                dropDown.optionArray = viewModel.unitSpecsList.value.filter{$0.isSelected == DEACTIVE}.map{String(format: "%@ (%@ %@)",
                                                                                                      $0.name,
                                                                                                      Utils.stringQuantityFormatWithNumber(amount: $0.exchange_value),
                                                                                                      $0.material_unit_specification_exchange_name)}
         
                dropDown.optionIds = viewModel.unitSpecsList.value.filter{$0.isSelected == DEACTIVE}.map{$0.id}
                
                self.height_of_tag_view.constant = tag_list_view.intrinsicContentSize.height
                self.view.layoutIfNeeded()
            }
            

                
            _ = isUnitSpecsQuantityValid.subscribe(onNext:{[weak self] (isValid) in
                self!.lbl_tag_view_err.isHidden = isValid ? true : false
            }).disposed(by: rxbag)
            
            //----------------------------------------mapping & subscribe validation of description------------------------------------------------------------------------
            _ = text_view_description.rx.text.map{String($0!.prefix(1001))}.map({(str) -> MaterialUnit in
                self.text_view_description.text = str
                self.lbl_number_of_text_in_text_view.text = String(format: "%d/1000", str.prefix(1000).count)
                var cloneNewMaterialUnit = self.viewModel.newMaterialUnit.value
                cloneNewMaterialUnit.description = str
                return cloneNewMaterialUnit
            }).bind(to: viewModel.newMaterialUnit)
            
            _ = isDescriptionValid.subscribe(onNext:{[weak self] (isValid) in
                self!.lbl_description_err.isHidden = isValid ? true : false
            }).disposed(by: rxbag)
            
            
          hideAllError()
        }
        getMaterialUnitSpecifications()
    }
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    
    @IBAction func actionShowDropDown(_ sender: Any) {
        dropDown.showList()
    }
    

    
    @IBAction func btnCancel(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.4, delay: 0, options: [.autoreverse] ,animations:{[self] in
            cancel_view.backgroundColor = ColorUtils.red_800()
            cancel_icon.image = UIImage(named: "icon-cancel-white")
            lbl_cancel.textColor = .white
        },completion: { [self] _ in
            cancel_view.backgroundColor = ColorUtils.gray_200()
            cancel_icon.image = UIImage(named: "icon-cancel-red")
            lbl_cancel.textColor = ColorUtils.red_600()
        })
       
    }
    

    
    @IBAction func btnConfirm(_ sender: Any) {
       
        UIView.animate(withDuration: 0.4, delay: 0, options: [.autoreverse] ,animations:{[self] in
            confirm_view.backgroundColor = ColorUtils.green_008()
            confirm_icon.image = UIImage(named: "icon-check-white")
            lbl_confirm.textColor = .white
        },completion: { [self] _ in
            confirm_view.backgroundColor = ColorUtils.green_100()
            confirm_icon.image = UIImage(named: "icon-check-green-008")
            lbl_confirm.textColor = ColorUtils.green_008()  
        })
        
        Observable.combineLatest(isUnitNameValid, isUnitCodeValid,isUnitSpecsQuantityValid,isDescriptionValid){$0 && $1 && $2 && $3}.take(1).subscribe(onNext: { [self] isValid in
            if isValid {
                materialUnit!.id > 0 ? updateMaterialUnit() : CreateMaterialUnit()
            }
        }).disposed(by: rxbag)
           
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification ) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if text_view_description.isFirstResponder {
                main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height/1.35)
            }else if dropDown.isFirstResponder {
                main_view.transform = CGAffineTransform(translationX: 0, y: -100)
                dropDown.hideListWithoutAnimation()
                dropDown.showListWithoutAnimation()
            }
        }
    }
    
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if text_view_description.isFirstResponder{
            main_view.transform = .identity
        } else if dropDown.isFirstResponder{
            main_view.transform = .identity
            dropDown.hideListWithoutAnimation()
        }
    }
    
    func hideAllError(){
        lbl_unit_code_error.isHidden = true
        lbl_unit_name_error.isHidden = true
        lbl_tag_view_err.isHidden = true
        lbl_description_err.isHidden = true
    }
        
}


