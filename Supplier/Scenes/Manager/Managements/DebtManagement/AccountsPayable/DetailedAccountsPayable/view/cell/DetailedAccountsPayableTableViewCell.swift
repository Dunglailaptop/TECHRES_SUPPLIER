//
//  DetailedAccountsPayableTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import MarqueeLabel
class DetailedAccountsPayableTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_material_name: MarqueeLabel!
    
    @IBOutlet weak var lbl_unit_name: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    
    @IBOutlet weak var lbl_total_amount: UILabel!
    
    @IBOutlet weak var lbl_price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    var data:MaterialWarehouseSessions?{
        didSet{
            lbl_material_name.text = data?.material_category_name
            Utils.lableMarqueeLabel(marqueeLabel: lbl_material_name)
            lbl_unit_name.attributedText = Utils.setMultipleColorForLabel(
                label: lbl_unit_name,
                attributes:[
                    (str:Utils.stringQuantityFormatWithNumberDouble(amount: data?.quantity ?? 0.0),color:ColorUtils.green_007()),
                    (str:"  |  ",color:ColorUtils.gray_600()),
                    (str:data?.supplier_input_unit_name ?? "",color:ColorUtils.green_007())
                ]
                                    
            )
            
            lbl_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount:  data?.supplier_input_quantity ?? 0)
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_price ?? 0)
            lbl_price.text = Utils.stringQuantityFormatWithNumber(amount: data?.supplier_input_price ?? 0)
            
        }
    }
    
}
