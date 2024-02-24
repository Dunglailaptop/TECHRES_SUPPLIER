//
//  ManagementCustomerBranchTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel

class ManagementCustomerBranchTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_branch_name: UILabel!
    
    @IBOutlet weak var image_branch_logo: UIImageView!
    @IBOutlet weak var lbl_branch_address: MarqueeLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var viewModel: ManagementCustomerBranchViewModel? = nil {
        didSet {
        }
    }
    
    public var data: Branches? = nil {
        didSet {
            lbl_branch_name.text = Utils().capitalizeString(inputString: data!.name)
            lbl_branch_address.text = data?.address_full_text
            Utils.getMarqueeLabel(lblContent: lbl_branch_address)
            image_branch_logo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image_logo_url)), placeholder: UIImage(named: "icon-logo-gray"))        }
    }
}
