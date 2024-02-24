//
//  PaymentRequestTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel
class PaymentRequestTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var status_view: UIView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var status_icon: UIImageView!
    @IBOutlet weak var width_of_status_label: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_created_time: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    
    @IBOutlet weak var lbl_restaurant: MarqueeLabel!
    @IBOutlet weak var lbl_brand: MarqueeLabel!
    
    @IBOutlet weak var lbl_branch: MarqueeLabel!
    
    @IBOutlet weak var note_view: UIView!
    @IBOutlet weak var lbl_note: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        note_view.isHidden = true
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

    
    var data:SupplierDebtPayment?=nil{
        didSet{
            
            lbl_created_time.text = data?.created_at
            lbl_code.text = String(data?.code ?? "")
            lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount ?? 0)
            lbl_total_order.text = String(data!.supplier_order_ids.count)
            lbl_restaurant.text = data?.restaurant_name
            lbl_brand.text = data?.restaurant_brand_name
            lbl_branch.text = data?.branch_name
            lbl_note.text = data?.reason
            /*
                status = 1 -> đang chờ xử lý
                status = 2 -> đã hoàn thành
                status = 0 -> đã huỷ
             */
            switch data?.status {
                case 1:
                    status_icon.image = UIImage(named: "icon-time-quarter-orange")
                    lbl_status.text = "CHỜ XỬ LÝ"
                    lbl_status.textColor = ColorUtils.orange_700()
                    width_of_status_label.constant = 140
                    status_view.backgroundColor = ColorUtils.orange_000()
                case 2:
                    status_icon.image = UIImage(named: "icon-check")
                    lbl_status.text = "HOÀN TẤT"
                    width_of_status_label.constant = 110
                    lbl_status.textColor = ColorUtils.green_600()
                    status_view.backgroundColor = ColorUtils.green_000()
                case 0:
                    status_icon.image = UIImage(named: "icon-cancel-red")
                    lbl_status.text = "ĐÃ HUỶ"
                    width_of_status_label.constant = 110
                    lbl_status.textColor = ColorUtils.red_600()
                    status_view.backgroundColor = ColorUtils.gray_100()
                
                default:
                    return
            }
            lableMarqueeLabel(marqueeLabel: lbl_restaurant)
            lableMarqueeLabel(marqueeLabel: lbl_brand)
            lableMarqueeLabel(marqueeLabel: lbl_branch)
        }
    }
    
    
    func lableMarqueeLabel(marqueeLabel:MarqueeLabel){
            marqueeLabel.type = .continuous
            marqueeLabel.scrollDuration = 5.0
            marqueeLabel.animationCurve = .easeInOut
            marqueeLabel.speed = .duration(15)
            marqueeLabel.fadeLength = 5.0
            marqueeLabel.leadingBuffer = 2.0
            marqueeLabel.trailingBuffer = 2.0
    }
    
}
