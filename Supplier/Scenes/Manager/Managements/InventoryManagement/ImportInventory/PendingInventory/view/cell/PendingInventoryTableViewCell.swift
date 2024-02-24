//
//  PendingInventoryTableViewCell.swift
//  SEEMT
//
//  Created by Huynh Quang Huy on 07/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class PendingInventoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_create_at: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    @IBOutlet weak var lbl_employee_created_full_name: UILabel!
    @IBOutlet weak var lbl_note: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Variable -
    public var data: SupplierWarehouseSessions? = nil {
        didSet {
            
            lbl_create_at.text = data?.created_at
            lbl_code.text = data?.code
            lbl_note.text = data?.note

            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount ?? 0)
            
            lbl_quantity.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_material ?? 0)
            
            lbl_employee_created_full_name.text = data?.supplier_employee_name
        }
    }
}
