//
//  ManagementCustomerTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher
import MarqueeLabel

class ManagementCustomerTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurant_avatar: UIImageView!
    
    @IBOutlet weak var restaurant_name: UILabel!
    
    @IBOutlet weak var restaurant_phone: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.restaurant_name.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var data:Restaurant? = nil {
        didSet{
            restaurant_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.logo)), placeholder: UIImage(named: "icon-logo-gray"))
            restaurant_name.text = Utils().capitalizeString(inputString: data!.name)
            restaurant_phone.text = String(data!.phone)
        }
    }
    
    var viewModel: ManagementCustomerViewModel? = nil {
        didSet{
            
        }
    }
}
