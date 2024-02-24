//
//  DetailedReceiptAndPaymentViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel
class DetailedReceiptAndPaymentViewController: BaseViewController {
    var viewModel = DetailedReceiptAndPaymentViewModel()
    var router = DetailedReceiptAndPaymentRouter()
    var receiptPaymentId:Int = 0
    var receiptPayment:ReceiptPayment = ReceiptPayment.init()
    
    
//    let status:[Int:(text:String,color:UIColor,image:UIImage)] = [
//        1:(text:"CHỜ XỬ LÝ",color:ColorUtils.orange_700(),image:UIImage(named: "icon-time-quarter-orange")),
//        2:(text:"HOÀN TẤT",color:ColorUtils.green_008(),image:UIImage(named: "icon-check-green-008")),
//        3:(text:"ĐÃ HUỶ",color:ColorUtils.red_600(),image:UIImage(named: "icon-cancel"))
//    ]
    
    @IBOutlet weak var view_cancelbtn: UIView!
    
    @IBOutlet weak var lbl_total_payment: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_created_date: UILabel!
    @IBOutlet weak var lbl_creator: MarqueeLabel!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_object_name: UILabel!
    @IBOutlet weak var lbl_note: UILabel!
    
    @IBOutlet weak var status_icon: UIImageView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var status_view: UIView!
    
    @IBOutlet weak var width_of_status_view: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var btn_bar_view: UIView!
    
    @IBOutlet weak var btn_confirm_view: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        viewModel.receiptPaymentDetail.accept(receiptPayment)
        mapData(receiptPaymentDetail: viewModel.receiptPaymentDetail.value)
        // Do any additional setup after loading the view.
        registerCell()
        bindTableViewData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getReceiptAndPaymentDetail()
    }

    @IBAction func actionNavigateBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    func mapData(receiptPaymentDetail: ReceiptPayment){
        lbl_code.text = receiptPaymentDetail.code
        lbl_created_date.text = receiptPaymentDetail.created_at
        lbl_creator.text = receiptPaymentDetail.supplier_employee_create_full_name
        Utils.lableMarqueeLabel(marqueeLabel: lbl_creator)
        lbl_category.text = receiptPaymentDetail.supplier_addition_fee_reason_name
        lbl_object_name.text = Constants.RECEIPT_PAYMENT_MODULE.OBJECT_TYPE[receiptPaymentDetail.object_type]
        lbl_note.text = receiptPaymentDetail.note
        lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: receiptPaymentDetail.amount)
        lbl_status.text = Constants.RECEIPT_PAYMENT_MODULE.STATUS[receiptPaymentDetail.status]
    
        switch receiptPaymentDetail.status {
            case 2:
                lbl_status.textColor = ColorUtils.green_008()
                status_icon.image = UIImage(named: "icon-check-green-008")
                status_view.borderColor = ColorUtils.green_008()
                width_of_status_view.constant = 110
                btn_bar_view.isHidden = false
                btn_confirm_view.isHidden = true
                view_cancelbtn.isHidden = receiptPaymentDetail.type == 0 && receiptPaymentDetail.object_type == 1 ? true : false
            
                break
            case 1:
                lbl_status.textColor = ColorUtils.orange_700()
                status_icon.image = UIImage(named: "icon-time-quarter-orange")
                status_view.borderColor = ColorUtils.orange_700()
                width_of_status_view.constant = 140
                btn_bar_view.isHidden = false
                break
            case 3:
                lbl_status.textColor = ColorUtils.red_600()
                status_icon.image = UIImage(named: "icon-cancel-red")
                status_view.borderColor = ColorUtils.red_600()
                width_of_status_view.constant = 90
                btn_bar_view.isHidden = true
                break
            
            default:
                break
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        prensentDialogConfirm(content: "Bạn chắc chắn muốn huỷ phiếu chi này", dialogType: 2)
    }
    
    @IBAction func actionConfirm(_ sender: Any) {
        prensentDialogConfirm(content: "Bạn chắc chắn muốn xác nhận phiếu chi này ?",dialogType: 1)
        
    }
    
}
