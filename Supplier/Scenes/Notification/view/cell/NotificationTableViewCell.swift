//
//  NotificationTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 20/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet weak var lbl_title: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var data:Notification? = nil {
        didSet{
            var avatarLink = Utils.getFullMediaLink(string: "")
            avatar.kf.setImage(with: URL(string:avatarLink),placeholder: UIImage(named: "image_defauft_medium"))
            lbl_title.text = data?.title
        }
    }
    
}
