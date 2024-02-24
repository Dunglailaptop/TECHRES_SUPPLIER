//
//  TotalAmountOrderTableViewCell.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class TotalAmountOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_name: UILabel! // Tên nguyên liệu
    @IBOutlet weak var lbl_material_unit_name: UILabel! // tên đơn vị
    
    @IBOutlet weak var lbl_total_quantity_from_order: UILabel! // SL đặt
    @IBOutlet weak var lbl_remain_quantity: UILabel! // Tồn kho
    
    @IBOutlet weak var lbl_total_import_quantity: UILabel! // nhập kho
    
    @IBOutlet weak var lbl_total_amount_from_quantity_import: UILabel! // thành tiền
    @IBOutlet weak var lbl_price: UILabel! // Đơn giá
    
    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var icon_check: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private(set) var disposeBag = DisposeBag()
        override func prepareForReuse() {
            super.prepareForReuse()
            disposeBag = DisposeBag()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    public var data: Material? = nil {
        didSet {
            
//            dLog(data!.toJSON())
            lbl_name.text = data?.name
            lbl_material_unit_name.text = data?.material_unit_name
            
            lbl_total_quantity_from_order.text = Utils.stringQuantityFormatWithNumberFloat(amount: data?.total_quantity_from_order ?? 0)
            lbl_remain_quantity.text = Utils.stringQuantityFormatWithNumberFloat(amount: data?.remain_quantity ?? 0)
            
            lbl_total_import_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.total_import_quantity ?? 0)
                
            lbl_total_amount_from_quantity_import.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount_from_quantity_import ?? 0)
            lbl_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.price ?? 0)
            
            if(data!.isSelected == ACTIVE){
                icon_check.image = UIImage(named: "icon-check-blue")
            }else{
                icon_check.image = UIImage(named: "icon-uncheck-blue")
            }
        }
    }
}
