//
//  UnitManagementViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 24/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class UnitManagementViewController: BaseViewController {

    var viewModel = UnitManagementViewModel()
    var router = UnitManagementRouter()
    
    
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var btn_get_active_data: UIButton!
    @IBOutlet weak var btn_get_deactive_data: UIButton!
    
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
                           let filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.dataArray.accept(filteredDataArray)
                       }else{
                           viewModel.dataArray.accept(cloneDataFilter)
                       }
                       
        }).disposed(by: rxbag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actionGetActiveData("")
    }

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }

    @IBAction func actionGetActiveData(_ sender: Any) {
        viewModel.status.accept(ACTIVE)
        changeButtonBackGroundColor(btn: btn_get_active_data)
        getMaterialUnitList()
        
    }
    
    
    @IBAction func actionGetDeactiveData(_ sender: Any) {
        viewModel.status.accept(DEACTIVE)
        changeButtonBackGroundColor(btn: btn_get_deactive_data)
        getMaterialUnitList()
    }
    
    @IBAction func actionCreateUnitSpecs(_ sender: Any) {
        viewModel.makeCreateMaterialUnitViewController()
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
