//
//  PopupChooseRestaurantTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 09/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class PopupChooseRestaurantTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    
    
    @IBOutlet weak var avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }
   
    var data: Restaurant?{
        didSet{
            dLog(data)
            lbl_name.text = data?.name
            lbl_address.isHidden = data?.type == 1 ? true: false
            if lbl_address.isHidden == true {
                self.lbl_name.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    self.lbl_name.leadingAnchor.constraint(equalTo: self.avatar.trailingAnchor, constant: 8),
                    self.lbl_name.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
                ])

            }
            lbl_address.text = data?.address
            if data?.logo_url != "" {
                dLog("vao khacv")
                avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.logo_url)), placeholder: UIImage(named: "icon-logo-gray"))
            } else if data?.image_logo_url != "" {
                dLog("vao")
                avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.image_logo_url)), placeholder: UIImage(named: "icon-logo-gray"))
            }
           
        }
    }
    
}

 
