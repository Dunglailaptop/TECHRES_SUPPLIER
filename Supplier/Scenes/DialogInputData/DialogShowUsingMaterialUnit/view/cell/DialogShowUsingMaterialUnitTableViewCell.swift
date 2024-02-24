//
//  DialogShowUsingMaterialUnitTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogShowUsingMaterialUnitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_item_name: UILabel!
    
    @IBOutlet weak var lbl_category: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
    var data:MaterialUnitStatus? = nil{
        didSet{
            lbl_item_name.text = data?.name
            lbl_category.text = data?.material_category_name
        }
    }
}
