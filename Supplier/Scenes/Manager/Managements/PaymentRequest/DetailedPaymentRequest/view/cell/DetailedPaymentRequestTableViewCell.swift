//
//  DetailedPaymentRequestTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 23/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedPaymentRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_code: UILabel!
    
    @IBOutlet weak var lbl_created_date: UILabel!
    
    @IBOutlet weak var lbl_amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

    }
    
    var data:SupplierOrders? = nil {
        didSet{
            let created_time = data?.created_at.components(separatedBy: " ")
            
            lbl_code.text = data?.code
            lbl_created_date.attributedText = Utils.setMultipleFontAndColorForLabel(
                label: lbl_created_date,
                attributes: [
                    (str:created_time?[0] ?? "",font:UIFont.systemFont(ofSize: 10, weight: .regular),color:.black),
                    (str:created_time?[1] ?? "",font:UIFont.systemFont(ofSize: 12, weight: .regular),color:ColorUtils.gray_600())
                ])
            lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount_reality ?? 0)
            
        }
    }
    
}
