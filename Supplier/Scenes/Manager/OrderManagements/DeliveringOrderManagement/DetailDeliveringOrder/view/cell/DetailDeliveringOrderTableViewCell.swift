//
//  CellOfMaterialDetailDeliveringOrder.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class DetailDeliveringOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_supplier_material_name: UILabel! // Tên nguyên liệu
    @IBOutlet weak var lbl_supplier_unit_name: UILabel! // tên đơn vị
    
    @IBOutlet weak var lbl_response_quantity: UILabel! // SL giao
    @IBOutlet weak var lbl_request_quantity: UILabel! // SL đặt
    
    @IBOutlet weak var lbl_price_reality: UILabel! // Đơn giá
    @IBOutlet weak var lbl_total_price_reality: UILabel! // thành tiền
    
    
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
    
    var data: SupplierOrdersDetailResponse? {
        didSet{
            self.lbl_supplier_material_name.text = data?.supplier_material_name
            self.lbl_supplier_unit_name.text = data?.supplier_unit_name
            
            self.lbl_response_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.response_quantity ?? 0)
            self.lbl_request_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.request_quantity ?? 0)
                
            self.lbl_price_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.price_reality ?? 0)
            self.lbl_total_price_reality.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_price_reality ?? 0)
            }
        }
}
