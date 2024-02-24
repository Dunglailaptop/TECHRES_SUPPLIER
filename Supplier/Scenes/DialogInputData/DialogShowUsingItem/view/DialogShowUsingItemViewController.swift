//
//  DialogShowUsingItemViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
class DialogShowUsingItemViewController: BaseViewController {
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lbl_warning_message: UILabel!
    @IBOutlet weak var lbl_content: UILabel!
    
    var dataArray = BehaviorRelay<[MaterialStatus]>(value: [])
    var warningMessage = "NGUYÊN LIỆU ĐANG ĐƯỢC SỬ DỤNG !"
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
        let dialogShowUsingItemTableViewCell = UINib(nibName: "DialogShowUsingItemTableViewCell", bundle: .main)
        tableView.register(dialogShowUsingItemTableViewCell, forCellReuseIdentifier: "DialogShowUsingItemTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func bindTableViewData() {
        dataArray.bind(to: tableView.rx.items(cellIdentifier: "DialogShowUsingItemTableViewCell", cellType: DialogShowUsingItemTableViewCell.self))
            {(row, materialStatus, cell) in
                cell.data = materialStatus
            }.disposed(by: rxbag)
    }
    


}
