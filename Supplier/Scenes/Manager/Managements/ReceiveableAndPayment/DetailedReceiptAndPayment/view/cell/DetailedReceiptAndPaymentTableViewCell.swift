//
//  DetailedReceiptAndPaymentTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DetailedReceiptAndPaymentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    // MARK: - Variable -
//    public var data: SupplierOrders? = nil {
//        didSet {
//            lbl_code.text = data?.code
//
//            lbl_date.attributedText = Utils.setMultipleFontAndColorForLabel(
//                label: lbl_date,
//                attributes: [
//                    (str:data!.received_at.components(separatedBy: " ")[0],font:UIFont.systemFont(ofSize:10, weight:.regular),color:ColorUtils.black()),
//                    (str:data!.received_at.components(separatedBy: " ")[1],font:UIFont.systemFont(ofSize:12, weight:.regular),color:ColorUtils.gray_600())
//            ])
//
//            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data!.total_amount)
//        }
//    }
    
    
}
