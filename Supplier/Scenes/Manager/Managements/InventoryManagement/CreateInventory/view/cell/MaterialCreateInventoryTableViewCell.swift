//
//  MaterialCreateInventoryTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class MaterialCreateInventoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name: UILabel! // Tên nguyên liệu
    @IBOutlet weak var lbl_material_unit_name: UILabel! // tên đơn vị
    
    @IBOutlet weak var lbl_remain_quantity: UILabel! // Tồn kho
    
    @IBOutlet weak var lbl_total_import_quantity: UILabel! // nhập kho
    
    @IBOutlet weak var lbl_total_amount_from_quantity_import: UILabel! // thành tiền
    @IBOutlet weak var lbl_price: UILabel! // Đơn giá
    
    @IBOutlet weak var btn_supplier_quantity: UIButton! // nút nhập sl giao
    @IBOutlet weak var btn_retail_price: UIButton! // nút nhập đơn giá
    
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
    
    var data: Material? {
        didSet{
            dLog(data?.toJSON() as Any)
            lbl_name.text = data?.name
            lbl_material_unit_name.text = data?.material_unit_name
            
            lbl_remain_quantity.text = Utils.stringQuantityFormatWithNumberFloat(amount: data?.remain_quantity ?? 0)
            
            lbl_total_import_quantity.text = Utils.stringQuantityFormatWithNumberDouble(amount: data?.total_import_quantity ?? 0)
                
            let totalAmount = Double(data?.total_import_quantity ?? 0) * Double(data?.price ?? 0)
            lbl_total_amount_from_quantity_import.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
            lbl_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.price ?? 0)
            }
        }
} 
