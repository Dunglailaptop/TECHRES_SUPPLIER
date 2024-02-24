//
//  ReportDayOffViewController.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift
import JonAlert
//import iOSDropDown
import TagListView
class DetailedItemsManagementViewController: BaseViewController {
    var viewModel = DetailedItemsManagementViewModel()
    var router = DetailedItemsManagementRouter()
    var item:Material = Material()
    var isAllowEditing:Bool = false
    
    
    @IBOutlet weak var category_view: UIView!
    @IBOutlet weak var measure_unit_view: UIView!
    
    @IBOutlet weak var unit_specification_view: UIView!
    
    @IBOutlet weak var imported_price_btn: UIButton!

    @IBOutlet weak var retailed_price_btn: UIButton!
    
    @IBOutlet weak var remaining_stock_btn: UIButton!
    
    @IBOutlet weak var wastage_ratio_btn: UIButton!
    

    
    @IBOutlet weak var lbl_module_title: UITextField!
    
    @IBOutlet weak var text_field_item_code: UITextField!
    @IBOutlet weak var lbl_item_code_err: UILabel!
    
    @IBOutlet weak var text_field_item_name: UITextField!
    @IBOutlet weak var lbl_item_name_err: UILabel!
    
    @IBOutlet weak var text_field_imported_price: UITextField!
    @IBOutlet weak var lbl_imported_price_err: UILabel!
    
    @IBOutlet weak var text_field_retailed_price: UITextField!
    @IBOutlet weak var lbl_retailed_price_err: UILabel!
    
    @IBOutlet weak var text_field_remaining_stock: UITextField!
    @IBOutlet weak var lbl_out_of_stock_alert_quan_err: UILabel!
    
    @IBOutlet weak var text_field_wastage_ratio: UITextField!
    @IBOutlet weak var lbl_wastage_ratio_err: UILabel!
    
    
    
    @IBOutlet weak var main_view: UIView!
    
    
    
    
    @IBOutlet weak var stack_view_of_category: UIStackView!
    
    @IBOutlet weak var view_of_text_field_category: UIView!
    @IBOutlet weak var text_field_category: UITextField!
    @IBOutlet weak var category_tag_list: TagListView!
    @IBOutlet weak var view_of_category_tag_list: UIView!
    @IBOutlet weak var lbl_category_err: UILabel!
    @IBOutlet weak var category_dropdown_icon: UIImageView!
    @IBOutlet weak var view_of_table1: UIView!
    @IBOutlet weak var table1: UITableView!
    @IBOutlet weak var height_of_view_of_table1: NSLayoutConstraint!

    
    
    @IBOutlet weak var stack_view_of_measure_unit: UIStackView!
    
    @IBOutlet weak var view_of_text_field_measure_unit: UIView!
    @IBOutlet weak var text_field_measure_unit: UITextField!
    @IBOutlet weak var unit_tag_list: TagListView!
    @IBOutlet weak var view_of_unit_tag_list: UIView!
    @IBOutlet weak var lbl_unit_err: UILabel!
    @IBOutlet weak var unit_dropdown_icon: UIImageView!
    @IBOutlet weak var view_of_table2: UIView!
    @IBOutlet weak var table2: UITableView!
    @IBOutlet weak var height_of_tableView2: NSLayoutConstraint!

    
    
    
    @IBOutlet weak var stack_view_measure_specs: UIStackView!
    
    @IBOutlet weak var view_of_text_field_measure_specification: UIView!
    @IBOutlet weak var text_field_measure_specification: UITextField!
    @IBOutlet weak var measure_spces_tag_list: TagListView!
    @IBOutlet weak var view_of_measure_specs_tag_list: UIView!
    @IBOutlet weak var lbl_measure_specs_err: UILabel!
    @IBOutlet weak var specification_dropdown_icon: UIImageView!
    @IBOutlet weak var view_of_table3: UIView!
    @IBOutlet weak var table3: UITableView!
    @IBOutlet weak var height_of_tableView3: NSLayoutConstraint!

    
    
    @IBOutlet weak var btn_bar_view: UIView!
    @IBOutlet weak var height_of_btn_bar_view: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_btn_confirm: UILabel!
    @IBOutlet weak var width_of_btn_confirm: NSLayoutConstraint!
    
    
    @IBOutlet weak var orange_aterisk_1: UIImageView!
    @IBOutlet weak var orange_aterisk_2: UIImageView!
    @IBOutlet weak var orange_aterisk_3: UIImageView!
    @IBOutlet weak var orange_aterisk_4: UIImageView!
    @IBOutlet weak var orange_aterisk_5: UIImageView!
    @IBOutlet weak var orange_aterisk_6: UIImageView!
    @IBOutlet weak var orange_aterisk_7: UIImageView!
    
    
    var ateriskArr:[UIImageView] = []
    
    var categoryListSwitcher:Bool = false
    var measureUnitListSwitcher:Bool = false
    var unitSpecsListSwitcher:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        viewModel.item.accept(item)
        firstSetUp()
        registerCellAndBindTable()
        getAllMaterialMeasureUnits()
        getAllCategoryItems()
        
       
       
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        text_field_item_code.adjustsFontSizeToFitWidth = true
        btn_bar_view.addShadow(shadowOffset: .zero, shadowOpacity: 0.7, shadowRadius: 10, color: .black)
        btn_bar_view.roundCorners(corners: [.topLeft,.topRight], radius: 20)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        hideView(view:btn_bar_view)
    }
    

       
    @IBAction func actionNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
 

    @IBAction func actionConfirm(_ sender: Any) {
        //combineLatest only contain 8 arguement,so we have to split it into two parts (first part names firstCombine )
        let firstCombine = Observable.combineLatest(
            isItemNameValid,
            isItemCodeValid,
            isPriceValid,
            isRetailedPriceValid,
            isOutOfStockAlertQuantityValid,
            isWastageRateValid,
            isCategoryValid,
            isMaterialUnitValid){$0 && $1 && $2 && $3 && $4 && $5 && $6 && $7}
        
        Observable.combineLatest(firstCombine.asObservable(),isUnitSpecsValid){$0 && $1}.take(1).subscribe(onNext: { [self] isValid in
            if isValid {
                //nếu id của item > 0 thì user đang ở chức năng update
                item.id > 0 ? updateItem() : createItem()
            }
        }).disposed(by: rxbag)
    }

    private func hideView(view:UIView){
        view.isHidden = true
        view.frame =  CGRect(x: 0, y: 0, width:  view.frame.width, height: 0)
    }
        
}


