//
//  DialgoShowUsingUnitSpecsViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DialgoShowUsingUnitSpecsViewController: BaseViewController {

    @IBOutlet weak var mainView: UIView!
    

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_warning_message: UILabel!
    @IBOutlet weak var lbl_content: UILabel!
    
    var dataArray = BehaviorRelay<[UnitSpecificationStatus]>(value: [])
    var warningMessage = "QUY CÁCH ĐANG ĐƯỢC SỬ DỤNG !"
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
    }
    
    @objc func handleTapOutSide(_ gesture:UIGestureRecognizer){
        let tapLocation = gesture.location(in: mainView)
        if !mainView.bounds.contains(tapLocation){
           dismiss(animated: true)
        }
    }
    
    
    func registerCell() {
        let dialgoShowUsingUnitSpecsTableViewCell = UINib(nibName: "DialgoShowUsingUnitSpecsTableViewCell", bundle: .main)
        tableView.register(dialgoShowUsingUnitSpecsTableViewCell, forCellReuseIdentifier: "DialgoShowUsingUnitSpecsTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindTableViewData() {
        dataArray.bind(to: tableView.rx.items(cellIdentifier: "DialgoShowUsingUnitSpecsTableViewCell", cellType: DialgoShowUsingUnitSpecsTableViewCell.self))
            {(row, unitSpecsStatus, cell) in
                cell.lbl_number.text = String(row)
                cell.data = unitSpecsStatus
            }.disposed(by: rxbag)
    }
}
