//
//  PopupChooseRestaurantViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 09/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//
import UIKit
import RxSwift
import RxRelay
class PopupChooseRestaurantViewController: BaseViewController {
    var viewModel = PopupChooseRestaurantViewModel()
    var delegate:CreatePaymentRequestPopupDelegate?
    var input:Restaurant = Restaurant()
    var popupType:PopupType?
    var isChooseOnceTime:Bool = false
    
    
    public enum PopupType {
        case restaurant
        case brand
        case branch
    }

    @IBOutlet weak var lbl_popup_title: UILabel!
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
        viewModel.bind(view: self)
        registerCell()
        bindTableViewData()
        firstSetup(data: input)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dLog(input)
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
    
    
    private func firstSetup(data:Restaurant){
        switch popupType {
            case .restaurant:
                getRestaurantList()
            case .brand:
                var cloneSelectedData = viewModel.selectedData.value
                cloneSelectedData.restaurant = data
                viewModel.selectedData.accept(cloneSelectedData)
                getBrandList()
            default:
                var cloneSelectedData = viewModel.selectedData.value
                cloneSelectedData.brand = data
                viewModel.selectedData.accept(cloneSelectedData)
                getBranchList()
        }
    }
    
    
    
    private func getData(data:Restaurant){
        switch popupType {
            case .restaurant:
                var cloneSelectedData = viewModel.selectedData.value
                cloneSelectedData.restaurant = data
                viewModel.selectedData.accept(cloneSelectedData)
                popupType = .brand
                viewModel.clearDataAndCallAPI()
            case .brand:
                var cloneSelectedData = viewModel.selectedData.value
                cloneSelectedData.brand = data
                viewModel.selectedData.accept(cloneSelectedData)
                popupType = .branch
                viewModel.clearDataAndCallAPI()
                if isChooseOnceTime {
                    delegate?.callBackToGetResult(
                        restaurant: viewModel.selectedData.value.restaurant,
                        brand: viewModel.selectedData.value.brand,
                        branch: viewModel.selectedData.value.branch)
                    dismiss(animated: true)
                }
            case .branch:
                var cloneSelectedData = viewModel.selectedData.value
                cloneSelectedData.branch = data
                viewModel.selectedData.accept(cloneSelectedData)
                popupType = .branch
                delegate?.callBackToGetResult(
                    restaurant: viewModel.selectedData.value.restaurant,
                    brand: viewModel.selectedData.value.brand,
                    branch: viewModel.selectedData.value.branch)
                viewModel.clearDataAndCallAPI()
                dismiss(animated: true)
                
            default:
                return
        }
    }
    
   
    
}

//MARK: register cell and binding data
extension PopupChooseRestaurantViewController:UITextFieldDelegate,UITableViewDelegate{
    
    func textFieldShouldClear(_: UITextField) -> Bool{
        viewModel.keySearch.accept("")
        viewModel.clearDataAndCallAPI()
        return true
    }
    
    func registerCell() {
        let popupChooseRestaurantTableViewCell = UINib(nibName: "PopupChooseRestaurantTableViewCell", bundle: .main)
        tableView.register(popupChooseRestaurantTableViewCell, forCellReuseIdentifier: "PopupChooseRestaurantTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.rx.setDelegate(self).disposed(by: rxbag)
        
        tableView.rx.modelSelected(Restaurant.self).subscribe(onNext: { [self] element in
            getData(data: element)
        }).disposed(by: rxbag)
        
    }
    
    
    func bindTableViewData() {

        viewModel.dataArray.bind(to: tableView.rx.items(cellIdentifier: "PopupChooseRestaurantTableViewCell", cellType: PopupChooseRestaurantTableViewCell.self))
        {(row, data, cell) in
            cell.data = data
        }.disposed(by: rxbag)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
     
        if(viewModel.dataArray.value.count < viewModel.pagination.value.totalRecord && !viewModel.pagination.value.isGetFullData){
            var clonePagination = viewModel.pagination.value
            clonePagination.page += 1
            viewModel.pagination.accept(clonePagination)
            switch popupType{
                case .restaurant:
                    getRestaurantList()
                case .brand:
                    getBrandList()
                case .branch:
                    getBranchList()
                default:
                    return
            }
            
        }
    }
    
}


