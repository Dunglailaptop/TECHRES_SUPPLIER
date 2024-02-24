//
//  ReceiptBillDebtTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher
import MarqueeLabel
class AccountsReceivableTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurant_logo: UIImageView!
    @IBOutlet weak var lbl_restaurant_name: MarqueeLabel!
    @IBOutlet weak var lbl_restaurant_phone: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Variable -
    public var data: RestaurantWithReceipt? = nil {
        didSet {
            restaurant_logo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.restaurant_logo)), placeholder:  UIImage(named: "image_default_logo"))
            lbl_restaurant_name.text = data?.restaurant_name == "" ? "---"  : data?.restaurant_name
            Utils.lableMarqueeLabel(marqueeLabel: lbl_restaurant_name)
            
            lbl_restaurant_phone.text = data?.restaurant_phone == "" ? "---"  : data?.restaurant_phone
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: data?.total_amount ?? 0.0)
            dLog(data)
        }
    }
}
