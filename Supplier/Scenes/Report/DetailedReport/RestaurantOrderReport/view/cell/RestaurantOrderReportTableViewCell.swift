//
//  RestaurantOrderReportTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_01 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class RestaurantOrderReportTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: RestaurantOrderReportViewModel? = nil {
        didSet {
            
        }
    }
    
    var data:RestaurantOrderReport?{
        didSet{
            lbl_restaurant_name.text = data?.name
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: data!.total_amount)
            lbl_total_order.text = String(data!.total_order)
        }
    }
}
