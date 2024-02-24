//
//  DetailPendingInventoryTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 26/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class DetailPendingInventoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_supplier_material_name: UILabel! // tên nguyên liệu
    @IBOutlet weak var lbl_supplier_unit_name: UILabel! // đơn vị
    
    @IBOutlet weak var lbl_supplier_input_quantity: UILabel! // sl nhập
    @IBOutlet weak var lbl_quantity: UILabel! // sl tồn
    
    @IBOutlet weak var lbl_supplier_input_price: UILabel! // đơn giá
    @IBOutlet weak var lbl_total_amount: UILabel! // thành tiền

    @IBOutlet weak var btn_supplier_input_quantity: UIButton! // nút nhập sl nhập
    @IBOutlet weak var btn_supplier_input_price: UIButton! // nút nhập đơn giá
    
    @IBOutlet weak var handle_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        handle_view.roundCorners(corners: [.bottomLeft,.topLeft], radius: 8)
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
            
            // sl nhập
            self.lbl_supplier_input_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.supplier_input_quantity ?? 0)
            
            // sl tồn
            self.lbl_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.system_last_quantity ?? 0)
                
            // đơn giá
            self.lbl_supplier_input_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.supplier_input_price ?? 0)
            // thành tiền
            self.lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithDouble(amount: Double(data?.supplier_input_price ?? 0) * (data?.supplier_input_quantity ?? 0))
        }
    }
}
