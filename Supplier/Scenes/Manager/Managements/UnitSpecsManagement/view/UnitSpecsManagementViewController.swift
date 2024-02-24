//
//  UnitSpecsManagementViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
class UnitSpecsManagementViewController: BaseViewController {
    var viewModel = UnitSpecsManagementViewModel()
    var router = UnitSpecsManagementRouter()
    
    
    @IBOutlet weak var btn_get_active_data: UIButton!
    @IBOutlet weak var btn_get_deactive_data: UIButton!
    
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var no_data_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        registerCell()
        bindTableViewData()
      
        text_field_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(text_field_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let cloneDataFilter = viewModel.dataFilter.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str3 = String(value.exchange_value)
                               let str4 = value.material_unit_specification_exchange_name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               
                               let firstCondition = str2.contains(str1)
                               let secondCondition = str3.contains(str1)
                               let thirdCondition = str4.contains(str1)
                               
                               return firstCondition || secondCondition || thirdCondition
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                       }else{
                           viewModel.dataArray.accept(cloneDataFilter)
                       }
                       
        }).disposed(by: rxbag)
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        actionGetActiveData("")
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionGetActiveData(_ sender: Any) {
        viewModel.status.accept(ACTIVE)
        changeButtonBackGroundColor(btn: btn_get_active_data)
        getMaterialUnitSpecifications()
        
    }
    
    
    @IBAction func actionGetDeactiveData(_ sender: Any) {
        viewModel.status.accept(DEACTIVE)
        changeButtonBackGroundColor(btn: btn_get_deactive_data)
        getMaterialUnitSpecifications()
    }
    
    @IBAction func actionCreateUnitSpecs(_ sender: Any) {
        viewModel.makeCreateUnitSpecificationViewController()
    }
    
    
    
    private func changeButtonBackGroundColor(btn:UIButton){
        btn_get_active_data.backgroundColor = ColorUtils.gray_200()
        btn_get_deactive_data.backgroundColor = ColorUtils.gray_200()
        btn_get_active_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        btn_get_deactive_data.setTitleColor(ColorUtils.gray_600(),for: .normal)
        
        btn.backgroundColor = ColorUtils.blue_000()
        btn.setTitleColor(ColorUtils.blue_700(),for: .normal)
    }
    

}



