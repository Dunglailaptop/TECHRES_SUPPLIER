//
//  CreatePaymentRequestFilterViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 31/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class CreatePaymentRequestPopupViewController: BaseViewController {

    
    var viewModel = CreatePaymentRequestPopupViewModel()
    var delegate:CreatePaymentRequestPopupDelegate?
    
    
    
    @IBOutlet weak var text_field: UITextField!
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var no_data_view: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        registerCell()
        viewModel.bind(view: self)
    }
    
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindTableViewData()
       
            getRestaurantList()

        
            self.text_field.rx.controlEvent(.editingChanged)
                       .throttle(.milliseconds(1000), scheduler: MainScheduler.instance)
                       .withLatestFrom(text_field.rx.text)
                       .subscribe(onNext:{ [self]  query in
                           viewModel.keySearch.accept(query!)
                           viewModel.clearDataAndCallAPI()
            }).disposed(by: rxbag)
            
        
    }

    
    
    
    @objc func handleTapOutSide(_ gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: main_view)
        if !main_view.bounds.contains(tapLocation){
           dismiss(animated: true)
        }
    }
    
    
    
}

//MARK: register cell and binding data
extension CreatePaymentRequestPopupViewController:UITextFieldDelegate,UITableViewDelegate{
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.keySearch.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
    
    func registerCell() {
        let createPaymentRequestPopupTableViewCell = UINib(nibName: "CreatePaymentRequestPopupTableViewCell", bundle: .main)
        tableView.register(createPaymentRequestPopupTableViewCell, forCellReuseIdentifier: "CreatePaymentRequestPopupTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        tableView.rx.modelSelected(Restaurant.self).subscribe(onNext: { [self] element in
            switch viewModel.popupType.value{
                case "RESTAURANT":
                    var cloneSelectedData = viewModel.selectedData.value
                    cloneSelectedData.restaurant = element
                    viewModel.selectedData.accept(cloneSelectedData)
                    viewModel.popupType.accept("BRAND")
                    viewModel.clearDataAndCallAPI()
                    break
                
                case "BRAND":
                    var cloneSelectedData = viewModel.selectedData.value
                    cloneSelectedData.brand = element
                    viewModel.selectedData.accept(cloneSelectedData)
                    viewModel.popupType.accept("BRANCH")
                    viewModel.clearDataAndCallAPI()
                    break

                case "BRANCH":
                    var cloneSelectedData = viewModel.selectedData.value
                    cloneSelectedData.branch = element
                    viewModel.selectedData.accept(cloneSelectedData)
                    delegate?.callBackToGetResult(
                        restaurant: viewModel.selectedData.value.restaurant,
                        brand: viewModel.selectedData.value.brand,
                        branch: viewModel.selectedData.value.branch)
                    dismiss(animated: true)
                                        
                    break
                
                default:
                    return

            }
            
    
        }).disposed(by: rxbag)
        
    }
    
    
    func bindTableViewData() {

        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "CreatePaymentRequestPopupTableViewCell", cellType: CreatePaymentRequestPopupTableViewCell.self))
        {(row, data, cell) in
            cell.data = data
        }.disposed(by: rxbag)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
     
    
        if(viewModel.dataArray.value.count < viewModel.pagination.value.totalRecord && !viewModel.pagination.value.isGetFullData){
            var clonePagination = viewModel.pagination.value
            clonePagination.page += 1
            viewModel.pagination.accept(clonePagination)
            switch viewModel.popupType.value{
                case "RESTAURANT":
                    getRestaurantList()
                case "BRAND":
                    getBrandList()
                case "BRANCH":
                    getBranchList()
                default:
                    return
            }
            
        }
    }
    
}


