//
//  ManagementCustomerBrandTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ManagementCustomerBrandTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name_restaurant: UILabel!
    @IBOutlet weak var lbl_phone_restaurant: UILabel!
    @IBOutlet weak var image_logo_restaurant: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      
        // Configure the view for the selected state
    }
    
    var viewModel: ManagementCustomerBrandViewModel? = nil {
        didSet{
            
        }
    }
    
    public var data: Brand? = nil {
        didSet {
            lbl_name_restaurant.text = Utils().capitalizeString(inputString: data!.name)
            lbl_phone_restaurant.text = data?.phone
            image_logo_restaurant.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.logo_url)), placeholder: UIImage(named: "icon-logo-gray"))
        }
    }
}
