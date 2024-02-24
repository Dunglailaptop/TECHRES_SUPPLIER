//
//  DebtTableItemTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DebtTableItemTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name_supplier: UILabel!
    
    @IBOutlet weak var lbl_total_amount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: DebtReportViewModel? = nil {
        didSet {
            
        }
    }
    
    public var data: SupplierDebtPayment? = nil {
        didSet {
            lbl_name_supplier.text = data?.supplier_name
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_amount ?? 0)
        }
    }
}


