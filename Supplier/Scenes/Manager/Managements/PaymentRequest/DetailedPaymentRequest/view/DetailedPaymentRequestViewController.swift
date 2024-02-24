//
//  DetailedPaymentRequestViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 23/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel
class DetailedPaymentRequestViewController: BaseViewController {
    var viewModel = DetailedPaymentRequestViewModel()
    var router = DetailedPaymentRequestRouter()
    var debt:SupplierDebtPayment = SupplierDebtPayment()
    var supplier_order_ids:[Int] = []
    
    
    @IBOutlet weak var lbl_order_code: UILabel!
    
    @IBOutlet weak var lbl_created_time: UILabel!
    
    @IBOutlet weak var lbl_creator: MarqueeLabel!
    
    @IBOutlet weak var lbl_category: UILabel!
    
    @IBOutlet weak var lbl_object_type: UILabel!

    @IBOutlet weak var note_view: UIView!
    @IBOutlet weak var lbl_note: UILabel!
    
    
    
    @IBOutlet weak var lbl_total_amount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var width_of_status_view: NSLayoutConstraint!
    @IBOutlet weak var status_view: UIView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var status_icon: UIImageView!
    
    @IBOutlet weak var btn_view: UIView!
    @IBOutlet weak var height_of_btn_view: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view:self,router:router)
        // Do any additional setup after loading the view.
        registerCell()
        bindTableViewData()
        getSupplierOrdersByIds()
        mapData(data: debt)
    }
    func mapData(data:SupplierDebtPayment){

        note_view.isHidden = true //QC & BA yêu cầu bỏ luôn trường này
        lbl_category.isHidden = true
        lbl_order_code.text = String(data.id)
        lbl_created_time.text = data.created_at
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_amount)
        lbl_note.text = data.reason
        lbl_creator.text = data.branch_name
        lbl_object_type.text = "Đơn hàng"
        /*
            status = 1 -> đang chờ xử lý
            status = 2 -> đã hoàn thành
            status = 0 -> đã huỷ
         */
        switch data.status {
            case 2:
                lbl_status.text = "HOÀN TẤT"
                lbl_status.textColor = ColorUtils.green_008()
                status_icon.image = UIImage(named: "icon-check-green-008")
                status_view.borderColor = ColorUtils.green_008()
                width_of_status_view.constant = 110
                btn_view.isHidden = true
                height_of_btn_view.constant = 0
                break
            
            case 1:
                lbl_status.text = "CHỜ THANH TOÁN"
                lbl_status.textColor = ColorUtils.orange_700()
                status_icon.image = UIImage(named: "icon-time-quarter-orange")
                status_view.borderColor = ColorUtils.orange_700()
                width_of_status_view.constant = 150
                btn_view.isHidden = false
                height_of_btn_view.constant = 70
                break
            
            case 0:
                lbl_status.text = "ĐÃ HUỶ"
                lbl_status.textColor = ColorUtils.red_600()
                status_icon.image = UIImage(named: "icon-cancel-red")
                status_view.borderColor = ColorUtils.red_600()
                width_of_status_view.constant = 90
                btn_view.isHidden = true
                height_of_btn_view.constant = 0
                break
            
            default:
                break
        }
        
        
    }

    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    

    
    @IBAction func btn_cancel_note(_ sender: Any) {
        prensentDialogConfirm(id: debt.id, status: 0)
    }
}
