//
//  CreatePaymentRequestPopupTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 01/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class CreatePaymentRequestPopupTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var restaurant_avatar: UIImageView!
    @IBOutlet weak var lbl_name: UILabel!
    
    @IBOutlet weak var lbl_address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Restaurant?{
        didSet{
            lbl_name.text = data?.name
            lbl_address.text = data?.address
        }
    }
    
}
