//
//  UnitManagementTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 26/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class UnitManagementTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_unit_name: UILabel!
    
    @IBOutlet weak var lbl_description: UILabel!
    
    @IBOutlet weak var lbl_unit_specification: UILabel!
    @IBOutlet weak var holder_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holder_view.roundCorners(corners: [.bottomLeft,.topLeft], radius: 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var data:MaterialUnit? = nil{
        didSet{
            lbl_unit_name.text = data?.name ?? ""
            lbl_description.text = data?.description ?? ""
            lbl_unit_specification.text = String(data?.material_unit_specifications.count ?? 0)
        }
    }
    
}
