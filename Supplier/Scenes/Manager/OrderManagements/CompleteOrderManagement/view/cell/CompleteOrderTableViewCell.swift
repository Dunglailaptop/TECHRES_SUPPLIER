//
//  CompleteOrderTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher

class CompleteOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var avatar_supplier: UIImageView!
    @IBOutlet weak var lbl_restaurant_name: UILabel!
    @IBOutlet weak var lbl_restaurant_phone: UILabel!
    @IBOutlet weak var lbl_total_material: UILabel!
    
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
            avatar_supplier.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.contactor_avatar)), placeholder:  UIImage(named: "image_default_logo"))
            
            lbl_restaurant_name.text = data?.name == "" ? "---"  : data?.name
            lbl_restaurant_phone.text = data?.phone == "" ? "---"  : data?.phone
            lbl_total_material.text = Utils.stringQuantityFormatWithNumber(amount: data?.total_done ?? 0)
        }
    }
}
