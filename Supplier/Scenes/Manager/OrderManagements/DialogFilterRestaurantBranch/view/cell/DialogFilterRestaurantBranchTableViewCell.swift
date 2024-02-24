//
//  DialogFilterRestaurantBranchTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogFilterRestaurantBranchTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    
    var data: Restaurant?{
        didSet{
            lbl_name.text = data?.name
        }
    }
    
}
