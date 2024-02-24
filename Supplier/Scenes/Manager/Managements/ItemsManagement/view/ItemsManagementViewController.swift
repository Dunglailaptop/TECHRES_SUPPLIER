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
class ItemsManagementViewController: BaseViewController {
    var viewModel = ItemsManagementViewModel()
    var router = ItemsManagementRouter()
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var supplying_view: UIView!
    @IBOutlet weak var lbl_supplying: UILabel!
    @IBOutlet weak var stop_supplying_view: UIView!
    @IBOutlet weak var lbl_stop_supplying: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var view_empty_data: UIView!
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var lbl_number_of_material: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
        firstSetup()
    }
    
    private func firstSetup(){
        Utils.isHideAllView(isHide: true, view: self.view_empty_data)
        self.text_field_search.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(text_field_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       viewModel.key_search.accept(query!)
                       viewModel.clearDataAndCallAPI()
        }).disposed(by: rxbag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actionToGetSupplyingMaterials("")
    }
    
    @IBAction func actionNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionToGetSupplyingMaterials(_ sender: Any) {
        changeButtonBackGroundColor(view: supplying_view, label: lbl_supplying)
        viewModel.status.accept(1)
        viewModel.clearDataAndCallAPI()
    }
    
    @IBAction func actionNavigatetoDetailedItemsManagementViewController(_ sender: Any) {
        viewModel.makeDetailedItemsManagemenTViewController(item:Material(),isAllowEditting: true)
    }
    
    @IBAction func actionToGetStopSupplyingMaterials(_ sender: Any) {
        changeButtonBackGroundColor(view: stop_supplying_view, label: lbl_stop_supplying)
        viewModel.status.accept(0)
        viewModel.clearDataAndCallAPI()
    }
    
    private func changeButtonBackGroundColor(view:UIView, label: UILabel){
        supplying_view.backgroundColor = ColorUtils.gray_200()
        stop_supplying_view.backgroundColor = ColorUtils.gray_200()
        lbl_supplying.textColor = ColorUtils.gray_600()
        lbl_stop_supplying.textColor = ColorUtils.gray_600()
        view.backgroundColor = ColorUtils.blue_000()
        label.textColor = ColorUtils.blue_700()
    }
}
