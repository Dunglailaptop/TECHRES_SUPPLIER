//
//  ItemTypeBusinessTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 20/09/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ItemTypeBusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var icon_image: UIImageView!
//    @IBOutlet weak var btn_check_list_TypeBusiness: UIButton!
    @IBOutlet weak var lbl_nametypeBusiness: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: TypeBusiness? = nil {
        didSet {
            lbl_nametypeBusiness.text = data?.name
            if data?.isSelected == ACTIVE {
                icon_image.isHidden = false
            }else {
                icon_image.isHidden = true
            }
        }
    }
    
}
