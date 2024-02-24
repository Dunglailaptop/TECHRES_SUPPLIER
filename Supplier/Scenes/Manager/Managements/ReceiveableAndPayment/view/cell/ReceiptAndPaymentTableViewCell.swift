//
//  ReportDayOffTableViewCell.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import MarqueeLabel
class ReceiptAndPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var status_view: UIView!
    @IBOutlet weak var content_view: UIView!
    
    
    
    @IBOutlet weak var icon_status: UIImageView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var lbl_created_date: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_creator_name: MarqueeLabel!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var lbl_object_name: UILabel!
    @IBOutlet weak var lbl_note: UILabel!

    let WAITING_COMPLETE = 1
    let COMPLETED = 2
    let CANCELLED = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        status_view.roundCorners(corners: [.topLeft, .topRight], radius: 20)
        content_view.roundCorners(corners:[.bottomLeft, .bottomRight], radius: 20)
   
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private(set) var disposeBag = DisposeBag()
           override func prepareForReuse() {
               super.prepareForReuse()
               disposeBag = DisposeBag()
    }
    
    public var viewModel:ReceiptAndPaymentViewModel?
    
    // MARK: - Variable -
    public var data: ReceiptPayment? = nil {
        didSet {
            guard let viewModel = self.viewModel else {return}
            
            
            lableMarqueeLabel(marqueeLabel: lbl_creator_name)
            
            lbl_status.text = Constants.RECEIPT_PAYMENT_MODULE.STATUS[data?.status ?? -1]
            lbl_created_date.text = data?.created_at
            lbl_code.text = data?.code
            lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.amount ?? 0)
            lbl_creator_name.text = data?.supplier_employee_create_full_name
            lbl_category.text =  data?.supplier_addition_fee_reason_name
            lbl_object_name.text = Constants.RECEIPT_PAYMENT_MODULE.OBJECT_TYPE[data?.object_type ?? -1]
            lbl_note.text = data?.note
            
            if viewModel.type.value == 0 && data?.object_type == 0 {
                lbl_object_name.text = "Khoản thu khác"
            }else if viewModel.type.value == 1 && data?.object_type == 0{
                lbl_object_name.text = "Khoản chi khác"
            }
            
            
            switch data?.status {
                case COMPLETED:
                    lbl_status.textColor = ColorUtils.green_008()
                    icon_status.image = UIImage(named: "icon-check")
                    status_view.backgroundColor = ColorUtils.green_100()
                  
                   
    
                case WAITING_COMPLETE:
                    lbl_status.textColor = ColorUtils.orange_700()
                    icon_status.image = UIImage(named: "icon-time-orange")
                    status_view.backgroundColor = ColorUtils.orange_000()
                
                   
                
                case CANCELLED:
                    icon_status.image = UIImage(named: "icon-cancel-red")
                    lbl_status.textColor = ColorUtils.red_600()
                    status_view.backgroundColor = ColorUtils.gray_200()
                
                
                default:
                    break
            }
        }
    }
    
    
    
    func lableMarqueeLabel(marqueeLabel:MarqueeLabel){
        marqueeLabel.type = .continuous
        marqueeLabel.scrollDuration = 5.0
        marqueeLabel.animationCurve = .easeOut
        marqueeLabel.speed = .duration(10)
        marqueeLabel.fadeLength = 10.0
        marqueeLabel.leadingBuffer = 2.0
        marqueeLabel.trailingBuffer = 2.0
    }
}
