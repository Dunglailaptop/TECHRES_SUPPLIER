//
//  DialogFilterRestaurantBranchViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import JonAlert

class DialogFilterRestaurantBranchViewController: BaseViewController {

    var viewModel = DialogFilterRestaurantBranchViewModel()
    var router = DialogFilterRestaurantBranchRouter()
    
    var delegate: CreatePaymentRequestPopupDelegate?
//    var restaurant_id: Int = 0
    var dataRestaurant = Restaurant()
    var dataBrand = Restaurant()
    var dataBranch = Restaurant()
    var isCheckSpam:Bool = false
    var is_restaurant:Bool = false
    
    @IBOutlet weak var root_view_choose_filter: UIView!
    @IBOutlet weak var root_view_table: UIView!

    @IBOutlet weak var lbl_restaurant: UILabel!
    @IBOutlet weak var btn_choose_restaurant: UIButton!
    
    @IBOutlet weak var lbl_brand: UILabel!
    @IBOutlet weak var btn_choose_brand: UIButton!
    
    @IBOutlet weak var lbl_branch: UILabel!
    @IBOutlet weak var btn_choose_branch: UIButton!
    
    @IBOutlet weak var lbl_title_table: UILabel!
    @IBOutlet weak var text_field: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var no_data_view: UIView!
    
    @IBOutlet weak var view_restaurant: UIView!
    @IBOutlet weak var height_of_view_choose_filter: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        root_view_choose_filter.round(with: .both, radius: 10)
        
        setUpForTapOutSide()
        registerCell()
        bindTableViewData()
        self.text_field.rx.controlEvent(.editingChanged)
                   .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                   .withLatestFrom(text_field.rx.text)
                   .subscribe(onNext:{ [self] query in
                       
                       viewModel.clearData()
                       viewModel.key_search.accept(query!)
                       getBrandList()
        }).disposed(by: rxbag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dLog(dataRestaurant)
        viewModel.dataRestaurant.accept(dataRestaurant)
        viewModel.dataBrand.accept(dataBrand)
        viewModel.dataBranch.accept(dataBranch)
        lbl_restaurant.text = dataBrand.id == -1 ? "Vui lòng chọn nhà hàng" : dataRestaurant.name
        lbl_brand.text = dataBrand.id == -1 ? "Vui lòng chọn thương hiệu" : dataBrand.name
        lbl_branch.text = dataBranch.id == -1 ? "Vui lòng chọn chi nhánh" : dataBranch.name
        // MARK: IS_RESTAURANT = 1 - cho chọn nhà hàng, 0 - không cho chọn
        height_of_view_choose_filter.constant = is_restaurant ? 350 : 280
        Utils.isHideAllView(isHide: is_restaurant ? false : true, view: view_restaurant)
    }
    
    @IBAction func actionChooseRestaurant(_ sender: Any) {
        Utils.isHideAllView(isHide: false, view: root_view_table)
        Utils.isHideAllView(isHide: true, view: root_view_choose_filter)
        lbl_title_table.text = "CHỌN NHÀ HÀNG"
        viewModel.data_type.accept(0)
        viewModel.clearData()
        getRestaurantList()
    }
    
    @IBAction func actionChooseBrand(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                }
        if viewModel.dataRestaurant.value.id == -1 {
            JonAlert.show(message: "Vui lòng chọn nhà hàng", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        } else {
            Utils.isHideAllView(isHide: false, view: root_view_table)
            Utils.isHideAllView(isHide: true, view: root_view_choose_filter)
            lbl_title_table.text = "CHỌN THƯƠNG HIỆU"
            viewModel.restaurant_id.accept(viewModel.dataRestaurant.value.id)
            viewModel.data_type.accept(1)
            viewModel.clearData()
            getBrandList()
        }
    }
    
    @IBAction func actionChooseBranch(_ sender: Any) {
        if isCheckSpam { return }
                isCheckSpam = true
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                    self.isCheckSpam = false
                }
        if viewModel.dataBrand.value.id == -1 {
            JonAlert.show(message: "Vui lòng chọn thương hiệu", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        } else {
            Utils.isHideAllView(isHide: false, view: root_view_table)
            Utils.isHideAllView(isHide: true, view: root_view_choose_filter)
            lbl_title_table.text = "CHỌN CHI NHÁNH"
            viewModel.restaurant_id.accept(viewModel.dataRestaurant.value.id)
            viewModel.restaurant_brand_id.accept(viewModel.dataBrand.value.id)
            viewModel.data_type.accept(2)
            viewModel.clearData()
            getBranchList()
        }
    }
    
    @IBAction func actionReset(_ sender: Any) {
        dLog(dataRestaurant)
        viewModel.restaurant_id.accept(-1)
        viewModel.restaurant_brand_id.accept(-1)
        viewModel.branch_id.accept(-1)
        viewModel.dataRestaurant.accept(dataRestaurant.id != -1 ? dataRestaurant : Restaurant())
        viewModel.dataBrand.accept(Restaurant())
        viewModel.dataBranch.accept(Restaurant())
        lbl_restaurant.text = "Vui lòng chọn nhà hàng"
        lbl_brand.text = "Vui lòng chọn thương hiệu"
        lbl_branch.text = "Vui lòng chọn chi nhánh"
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        delegate?.callBackToGetResult(restaurant: viewModel.dataRestaurant.value, brand: viewModel.dataBrand.value, branch: viewModel.dataBranch.value)
        dismiss(animated: true)
    }
    
    private func setUpForTapOutSide() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
    }
    
    
    @objc func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation = gesture.location(in: self.root_view_choose_filter)
        if !root_view_choose_filter.bounds.contains(tapLocation) {
            dismiss(animated: true, completion: nil)
        }
    }
}
