//
//  DialogShowUsingItemTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 12/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogShowUsingItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    @IBOutlet weak var lbl_total_order_request: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    
    var data:MaterialStatus? = nil{
        didSet{
            lbl_restaurant_name.text = data?.restaurant_name
            lbl_total_order_request.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_supplier_order_request ?? 0)
            lbl_total_order.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_supplier_order ?? 0)
        }
    }
    
}
