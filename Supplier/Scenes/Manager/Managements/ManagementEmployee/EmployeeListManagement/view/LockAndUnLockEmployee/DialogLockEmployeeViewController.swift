//
//  DialogLockEmployeeViewController.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 17/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxRelay
import RxSwift

class DialogLockEmployeeViewController: BaseViewController {

    var viewModel = EmployeeListManagementViewModel()
    
    @IBOutlet weak var lb_notyAceess: UILabel!
    @IBOutlet weak var lbl_employee_name_locked: UILabel!
    @IBOutlet weak var lbl_text_warning_lock: UILabel!
    
  
    @IBOutlet weak var root_view: UIView!
    
    @IBOutlet weak var btnConfirmLock: UIButton!
    
    var delegate: LockEmployeeDelegate?
    var position = 0
    var idLock = 0
    var typeLockEmployee = 0
    var txtname_employee = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        root_view.roundCorners(corners: .allCorners, radius: 8)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_employee_name_locked.text = txtname_employee
        viewModel.idLock.accept(idLock)
        viewModel.node_access_token.accept(ManageCacheObject.getCurrentUser().access_token)
    }

    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionLocked(_ sender: Any) {
        if (typeLockEmployee == 1){ // Type = 1: Khoá tài khoản nhân viên
            self.lockEmployee()
        } else { // Type = 2: Mở khoá tài khoản nhân viên
            self.unLockEmployee()
        }
    }

}
