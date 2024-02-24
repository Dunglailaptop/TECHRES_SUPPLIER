//
//  UnitSpecsManagementTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class UnitSpecsManagementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_unit_specs: UILabel!
    
    @IBOutlet weak var lbl_exchange_value: UILabel!
    
    @IBOutlet weak var holder_view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holder_view.roundCorners(corners: [.bottomLeft,.topLeft], radius: 6)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data:UnitSpecification? = nil{
        didSet{

            lbl_unit_specs.text = data?.name ?? ""
            
            lbl_exchange_value.attributedText = Utils.setMultipleColorForLabel(
                label: lbl_exchange_value,
                attributes: [
                    (str:Utils.stringQuantityFormatWithNumber(amount: data!.exchange_value), color:ColorUtils.blue_700()),
                    (str:data!.material_unit_specification_exchange_name, color:ColorUtils.green_007())
                ])
            

        }
    }
    
}
