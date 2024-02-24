//
//  DialogShowUsingMaterialUnitViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DialogShowUsingMaterialUnitViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbl_warning_message: UILabel!
    @IBOutlet weak var lbl_content: UILabel!
    
    var dataArray = BehaviorRelay<[MaterialUnitStatus]>(value: [])
    var warningMessage = "ĐƠN VỊ NGUYÊN LIỆU ĐANG ĐƯỢC SỬ DỤNG !"
    var content = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        lbl_content.text = content
        lbl_warning_message.text = warningMessage
        registerCell()
        bindTableViewData()
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleTapOutSide(_ gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: mainView)
        if !mainView.bounds.contains(tapLocation){
           dismiss(animated: true)
        }
    }
    
    
    func registerCell() {
        let dialogShowUsingMaterialUnitTableViewCell = UINib(nibName: "DialogShowUsingMaterialUnitTableViewCell", bundle: .main)
        tableView.register(dialogShowUsingMaterialUnitTableViewCell, forCellReuseIdentifier: "DialogShowUsingMaterialUnitTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindTableViewData() {
        dataArray.bind(to: tableView.rx.items(cellIdentifier: "DialogShowUsingMaterialUnitTableViewCell", cellType: DialogShowUsingMaterialUnitTableViewCell.self))
            {(row, materialUnitStatus, cell) in
                cell.data = materialUnitStatus
            }.disposed(by: rxbag)
    }
}
