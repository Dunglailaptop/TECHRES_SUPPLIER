//
//  DetailCompleteInventoryTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class DetailCompleteInventoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_supplier_material_name: UILabel! // tên nguyên liệu
    @IBOutlet weak var lbl_supplier_unit_name: UILabel! // đơn vị
    
    @IBOutlet weak var lbl_system_last_quantity: UILabel! // tồn hệ thống
    @IBOutlet weak var lbl_quantity: UILabel! // sl nhập

    @IBOutlet weak var lbl_retail_price: UILabel! // đơn giá
    @IBOutlet weak var lbl_total_amount: UILabel! // thành tiền

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private(set) var disposeBag = DisposeBag()
           override func prepareForReuse() {
               super.prepareForReuse()
               disposeBag = DisposeBag()
    }
    
    var data: MaterialWarehouseSessions? {
        didSet{
            self.lbl_supplier_material_name.text = data?.supplier_material_name
            self.lbl_supplier_unit_name.text = data?.unit_name
            self.lbl_system_last_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.system_last_quantity ?? 0)
            self.lbl_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.quantity ?? 0)
                
            self.lbl_retail_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.supplier_input_price ?? 0)
            
            self.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_price ?? 0)
        }
    }
}
