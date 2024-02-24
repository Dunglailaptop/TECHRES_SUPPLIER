//
//  ManagementViewController.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ManagementViewController: BaseViewController {
    var viewModel = ManagementViewModel()
    var router = ManagementRouter()
    
    // NHÂN VIÊN
    @IBOutlet weak var image_icon_employee_manager: UIImageView!
    @IBOutlet weak var lbl_text_employee_manager: UILabel!
    @IBOutlet weak var btn_employee_manager: UIButton!
    
    // CÔNG NỢ
    @IBOutlet weak var image_icon_debt_manager: UIImageView!
    @IBOutlet weak var lbl_text_debt_manager: UILabel!
    @IBOutlet weak var btn_debt_manager: UIButton!
    
    //NGHỈ PHÉP
    @IBOutlet weak var image_icon_leave_manager: UIImageView!
    @IBOutlet weak var lbl_text_leave_manager: UILabel!
    @IBOutlet weak var btn_leave_manager: UIButton!
    @IBOutlet weak var view_record_waiting_leave_manager: UIView!
    @IBOutlet weak var lbl_record_waiting_leave_manager: UILabel!
    
    //TẠM ỨNG LƯƠNG
    @IBOutlet weak var image_icon_advance_salary_manager: UIImageView!
    @IBOutlet weak var lbl_text_advance_salary_manager: UILabel!
    @IBOutlet weak var btn_advance_salary_manager: UIButton!
    @IBOutlet weak var view_record_waiting_advance_salary_manager: UIView!
    @IBOutlet weak var lbl_record_waiting_advance_salary_manager: UILabel!
    
    //DUYỆT MỤC TIÊU
    @IBOutlet weak var image_icon_target_manager: UIImageView!
    @IBOutlet weak var lbl_text_target_manager: UILabel!
    @IBOutlet weak var btn_target_manager: UIButton!
    @IBOutlet weak var view_record_waiting_target_manager: UIView!
    @IBOutlet weak var lbl_record_waiting_target_manager: UILabel!
    
    //THƯỞNG PHẠT
    @IBOutlet weak var image_icon_addition_manager: UIImageView!
    @IBOutlet weak var lbl_text_addition_manager: UILabel!
    @IBOutlet weak var btn_addition_manager: UIButton!
    @IBOutlet weak var view_record_waiting_addition_manager: UIView!
    @IBOutlet weak var lbl_record_waiting_addition_manager: UILabel!
    
    //BẢNG LƯƠNG TỔNG HỢP
    @IBOutlet weak var image_icon_salary_table: UIImageView!
    @IBOutlet weak var lbl_text_salary_table: UILabel!
    @IBOutlet weak var btn_salary_table: UIButton!
    @IBOutlet weak var view_record_waiting_salary_table: UIView!
    @IBOutlet weak var lbl_record_waiting_salary_table: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: router)
        
        // SEPUP LAYOUT VIEW RECORD COUNT WAITING
        view_record_waiting_leave_manager.round(with: .northeast, radius: 6)
        view_record_waiting_advance_salary_manager.round(with: .northeast, radius: 6)
        view_record_waiting_target_manager.round(with: .northeast, radius: 6)
        view_record_waiting_addition_manager.round(with: .northeast, radius: 6)
        view_record_waiting_salary_table.round(with: .northeast, radius: 6)
        
        dLog(ManageCacheObject.getCurrentUser().permissions)
        
//        NotificationCenter.default
//                               .addObserver(self,
//                                            selector:#selector(notificationLocalUpdateAfterChangeBranch(_:)),
//                              name: NSNotification.Name ("vn.techres.seemt.change.branch"),
//                             object: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    // NHÂN VIÊN
    @IBAction func actionEmployeeManagement(_ sender: Any) {
        viewModel.makeEmployeeListManagementViewController()
    }
 
    // CÔNG NỢ
     @IBAction func actionNavigateToDebtManagementViewController(_ sender: Any) {
         // Navigator Debt Management ViewController
         viewModel.makeDebtManagementViewController()
     }
     
    // BẢNG GIÁ
    @IBAction func actionPriceListManagement(_ sender: Any) {
        viewModel.makePriceListManagementViewController()
    }

    // MẶT HÀNG
    @IBAction func actionNavigateToItemsManagementViewController(_ sender: Any) {
        viewModel.makeItemsManagementViewController()
    }

    // THU / CHI
     @IBAction func actionNavigateToReceiptAndPaymentViewController(_ sender: Any) {
         viewModel.makeReceiptAndPaymentViewController()
     }
     
    // YÊU CẦU THANH TOÁN
     @IBAction func actionNavigateToPaymentRequestViewController(_ sender: Any) {
         viewModel.makePaymentRequestViewController()
     }
         
//    @IBAction func actionDayOff(_ sender: Any) {
//        viewModel.makePriceListManagementViewController()
//    }
    
    // KHO
    @IBAction func actionNavigateToInventoryManagementViewController(_ sender: Any) {
        viewModel.makeInventoryManagementViewController()
     }
         
    // KHÁCH HÀNG
    @IBAction func actionNavigateToManagementListCustomerViewController(_ sender: Any) {
        viewModel.makeManagementListCustomerViewController()
     }
     
    // ĐƠN VỊ
     @IBAction func actionNavigateToUnitManagementViewController(_ sender: Any) {
         viewModel.makeUnitManagementViewController()
     }

    // QUY CÁCH
     @IBAction func actionNavigateToUnitSpecsManagementViewController(_ sender: Any) {
         viewModel.makeUnitSpecsManagementViewController()
     }
}
