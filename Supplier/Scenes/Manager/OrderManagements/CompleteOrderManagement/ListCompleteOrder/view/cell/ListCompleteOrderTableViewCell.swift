//
//  ListCompleteOrderTableViewCell.swift
//  SEEMT
//
//  Created by Huynh Quang Huy on 07/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class ListCompleteOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_received_at: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    @IBOutlet weak var lbl_restaurant_brand_name: UILabel!
    @IBOutlet weak var lbl_branch_name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Variable -
    public var data: SupplierOrders? = nil {
        didSet {
            
            lbl_received_at.text = data?.received_at
            lbl_code.text = data?.code
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount ?? 0)
            
            lbl_total_order.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_material ?? 0)
            
            lbl_restaurant_brand_name.text = data?.restaurant_brand_name
            lbl_branch_name.text = data?.branch_name
        }
    }
}
