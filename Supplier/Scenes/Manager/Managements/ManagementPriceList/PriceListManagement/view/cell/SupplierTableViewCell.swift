//
//  SupplierTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class SupplierTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_supplier_phone: UILabel!
    @IBOutlet weak var lbl_supplier_name: UILabel!
    
    @IBOutlet weak var image_avatar: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lbl_supplier_name.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   public var data:Supplier? = nil{
        didSet{
            lbl_supplier_name.text = Utils().capitalizeString(inputString: data!.name)
            lbl_supplier_phone.text = data?.phone
            image_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data!.logo)), placeholder: UIImage(named: "LogoSupplier"))
        }
    }
    
    var viewModel: PriceListManagementViewModel? = nil {
        didSet {
        
        }
    }
    
    
    @IBAction func btnDetailPrice(_ sender: Any) {
        viewModel?.makePriceListDetailViewController(supplier: data!)
    }
    
}


