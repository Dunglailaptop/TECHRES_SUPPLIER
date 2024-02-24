//
//  CellOfMaterialDetailPendingOrder.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class DetailPendingOrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_supplier_material_name: UILabel! // tên nguyên liệu
    @IBOutlet weak var lbl_supplier_unit_name: UILabel! // đơn vị
    
    @IBOutlet weak var lbl_system_last_quantity: UILabel! // tồn hệ thống
    @IBOutlet weak var lbl_quantity: UILabel! // sl đặt

    @IBOutlet weak var lbl_supplier_quantity: UILabel! // sl giao
    
    @IBOutlet weak var lbl_total_amount: UILabel! // thành tiền
    @IBOutlet weak var lbl_retail_price: UILabel! // đơn giá

    @IBOutlet weak var btn_supplier_quantity: UIButton! // nút nhập sl giao
    @IBOutlet weak var btn_retail_price: UIButton! // nút nhập đơn giá
    
    
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
    
    var data: DetailSupplierOrderResponse? {
        didSet{
            self.lbl_supplier_material_name.text = data?.supplier_material_name
            self.lbl_supplier_unit_name.text = data?.supplier_unit_name
            self.lbl_system_last_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.system_last_quantity ?? 0)
            self.lbl_supplier_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.supplier_quantity ?? 0)
            self.lbl_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.quantity ?? 0)
                
            self.lbl_retail_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.retail_price ?? 0)
            
            self.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: Double(data?.retail_price ?? 0) * (data?.supplier_quantity ?? 0))
            }
        }
}
