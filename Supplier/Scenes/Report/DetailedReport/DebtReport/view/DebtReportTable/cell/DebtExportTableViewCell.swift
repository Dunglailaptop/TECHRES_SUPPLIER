//
//  DebtExportTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 08/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DebtExportTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var lbl_supplierWarehouseSessions_name: UILabel!
    
    @IBOutlet weak var lbl_supplierWarehouseSessions_total_amount: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel: DebtReportViewModel? = nil {
        didSet{
            
        }
    }
    
    public var data: SupplierWarehouseSessions? = nil {
        didSet{
            lbl_supplierWarehouseSessions_name.text = data?.supplier_employee_name
            lbl_supplierWarehouseSessions_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_amount ?? 0)
        }
    }
   
}
