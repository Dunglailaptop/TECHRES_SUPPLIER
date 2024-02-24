//
//  DialogChooseCategoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChooseCategoryViewController: BaseViewController {
    var viewModel = DialogChooseCategoryViewModel()
    
    
    var delegate:DialogDelegate?
    var inputList:[GeneralObject] = []
    var selectedOption:GeneralObject = GeneralObject.init()!
    var dialogType:DialogType?
    var dialogTitle = ""
    
    public enum DialogType {
        case category //chọn danh mục
        case measureUnit // chọn
        case unitSpecification // chọn quy cách
        case restaurant //chọn nhà hàng
        case brand //chọn thương hiệu
        case branch //chọn chi nhánh
        case order//chọn đơn hàng
    }
    
    @IBOutlet weak var lbl_dialog_title: UILabel!
    
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var text_field_search: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var btn_bar_view: UIView!
    
    @IBOutlet weak var height_of_btn_bar_view: NSLayoutConstraint!
    @IBOutlet weak var no_data_view: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self)
        // Do any additional setup after loading the view.
       
        registerCellAndBindTableView()
        firstSetup()
        lbl_dialog_title.text = dialogTitle
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        
        text_field_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(text_field_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       let cloneDataFilter = viewModel.fullObjectArray.value
                       if !query!.isEmpty{
                           let filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.objectArray.accept(filteredDataArray)
                       }else{
                           viewModel.objectArray.accept(cloneDataFilter)
                       }
                       
        }).disposed(by: rxbag)
    }
    
    @objc func handleTapOutSide(_ gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: main_view)
        if !main_view.bounds.contains(tapLocation){
           dismiss(animated: true)
        }
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        delegate?.callBackToGetMultipleResult(results: viewModel.objectArray.value.filter{$0.isSelected == ACTIVE})
        dismiss(animated: true)
        
    }
    
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}

