//
//  DeliveringOrderTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 15/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher

class DeliveringOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var restaurant_logo: UIImageView!
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    @IBOutlet weak var lbl_restaurant_phone: UILabel!
    @IBOutlet weak var lbl_total_order: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Variable -
    public var data: Restaurant? = nil {
        didSet {
            restaurant_logo.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.contactor_avatar)), placeholder: UIImage(named: "image_default_logo"))
            
            lbl_restaurant_name.text = data?.name == "" ? "---"  : data?.name
            lbl_restaurant_phone.text = data?.phone == "" ? "---"  : data?.phone
            lbl_total_order.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_delivering ?? 0)
        }
    }
    
}
