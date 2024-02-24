//
//  CreateUnitSpecificationViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert
import iOSDropDown
class CreateUnitSpecificationViewController: BaseViewController {
    var viewModel = CreateUnitSpecificationViewModel()
    var router = CreateUnitSpecificationRouter()
    var unitSpecification:UnitSpecification?
    
    
    @IBOutlet weak var lbl_title: UILabel!
    @IBOutlet weak var text_field_unit_specs_name: UITextField!
    @IBOutlet weak var lbl_unit_specs_name_error: UILabel!
    
    
    @IBOutlet weak var lbl_exchange_value: UILabel!
    @IBOutlet weak var lbl_exchange_value_error: UILabel!
        
    @IBOutlet weak var lbl_exchange_unit_error: UILabel!
    @IBOutlet weak var btn_show_popup: UIButton!
    
    @IBOutlet weak var icon_dropDown: UIImageView!
    
    @IBOutlet weak var dropdown: DropDown!
    
    @IBOutlet weak var search_icon_of_dropdown: UIImageView!
    //Outlet btn-bar
    @IBOutlet weak var cancel_view: UIView!
    @IBOutlet weak var cancel_icon: UIImageView!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var confirm_view: UIView!
    @IBOutlet weak var confirm_icon: UIImageView!
    @IBOutlet weak var lbl_confirm: UILabel!
    @IBOutlet weak var btn_bar_view: UIView!
    
    @IBOutlet weak var width_of_label_confirm: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        firstSetUp()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getExchangeUnitSpecsList()
    }
    

    
    private func firstSetUp(){

        lbl_confirm.text = "XÁC NHẬN"
        width_of_label_confirm.constant = 130
        
        if unitSpecification!.id > 0 {
            lbl_title.text = "CHỈNH SỬA QUY CÁCH"
            lbl_confirm.text = "LƯU LẠI"
            width_of_label_confirm.constant = 110
            viewModel.unitSpecification.accept(unitSpecification!)
            text_field_unit_specs_name.text = unitSpecification?.name
            lbl_exchange_value.text = Utils.stringQuantityFormatWithNumber(amount: unitSpecification!.exchange_value)
            btn_show_popup.isEnabled = false
            icon_dropDown.isHidden = true
            dropdown.isEnabled = false
            search_icon_of_dropdown.widthAnchor.constraint(equalToConstant: 0).isActive = true
            
            
        }
        
        btn_bar_view.addShadow(shadowOffset: .zero, shadowOpacity: 0.7, shadowRadius: 10, color: .black)
        
        _ = text_field_unit_specs_name.rx.text.map{String($0!.prefix(51))}.map({ [self](str) -> UnitSpecification in
            let content = Utils.blockSpecialCharacters(str)
            
            text_field_unit_specs_name.text = content
            var cloneNewUnitSpecification = self.viewModel.unitSpecification.value
            cloneNewUnitSpecification.name = content
            return cloneNewUnitSpecification
        }).bind(to: viewModel.unitSpecification).disposed(by:rxbag)
        
       _ = isUnitSpecsName.subscribe(onNext: {(isValid) in
           self.lbl_unit_specs_name_error.isHidden = isValid ? true : false
       }).disposed(by:rxbag)
        
        
        _ = isExchangeUnitValid.subscribe(onNext: {(isValid) in
            self.lbl_exchange_unit_error.isHidden = isValid ? true : false
        }).disposed(by:rxbag)
        
    
        dropdown.didSelect{ [self](selectedText , index ,id) in
            var cloneNewUnitSpecification = self.viewModel.unitSpecification.value
            cloneNewUnitSpecification.material_unit_specification_exchange_name_id = id
            self.viewModel.unitSpecification.accept(cloneNewUnitSpecification)
            dropdown.text = selectedText
            dropdown.selectedIndex = index
        }
     
        lbl_unit_specs_name_error.isHidden = true
        lbl_exchange_unit_error.isHidden = true
    }
    

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    
    @IBAction func actionShowCaculator(_ sender: Any) {
        presentCalculator()
    }
    
    @IBAction func actionShowFilter(_ sender: Any) {
        dropdown.showList()
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

        Observable.combineLatest(isExchangeValueValid, isUnitSpecsName,isExchangeUnitValid){$0 && $1 && $2}.take(1).subscribe(onNext: { [self] isValid in
            if isValid {
                viewModel.unitSpecification.value.id > 0 ? updateMaterialUnitSpecs() : createMaterialUnitSpecification()
            }
        }).disposed(by: rxbag)
           
    }


    
}



