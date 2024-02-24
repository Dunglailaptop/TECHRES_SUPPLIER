//
//  ExportItemTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 05/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ExportItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_material: UILabel!
    @IBOutlet weak var lbl_listtag: UILabel!
    @IBOutlet weak var lbl_number: UILabel!
    @IBOutlet weak var lbl_totalMoney: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel:ExportReportViewModel? = nil {
        didSet{
            
        }
    }
    
    public var data: CancelItemReport? = nil {
        didSet{
            lbl_material.text = String(data!.supplier_material_name)
            lbl_listtag.text = String(data!.material_category_name)
            lbl_number.text = String(data!.quantity)
            lbl_totalMoney.text = Utils.stringQuantityFormatWithNumber(amount: data!.total_amount)
        }
    }
    
}
