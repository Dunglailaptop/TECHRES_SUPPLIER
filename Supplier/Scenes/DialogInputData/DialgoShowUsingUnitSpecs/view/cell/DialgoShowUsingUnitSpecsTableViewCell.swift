//
//  DialgoShowUsingUnitSpecsTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 14/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialgoShowUsingUnitSpecsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_number: UILabel!
    
    
    @IBOutlet weak var lbl_material_name: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data:UnitSpecificationStatus? = nil{
        didSet{
            lbl_material_name.text = data?.name
        }
    }
}
