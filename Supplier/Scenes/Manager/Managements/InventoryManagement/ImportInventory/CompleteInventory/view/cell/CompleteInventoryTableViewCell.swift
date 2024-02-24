//
//  CompleteInventoryTableViewCell.swift
//  SEEMT
//
//  Created by Huynh Quang Huy on 07/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class CompleteInventoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_create_at: UILabel!
    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    @IBOutlet weak var lbl_quantity: UILabel!
    
    @IBOutlet weak var lbl_note: UILabel!
    @IBOutlet weak var lbl_employee_name: UILabel!
    @IBOutlet weak var view_status: UIView!
    @IBOutlet weak var lbl_status: UILabel!
    @IBOutlet weak var icon_status: UIImageView!
    
    @IBOutlet weak var view_bottom_radius: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view_bottom_radius.round(with: .bottom, radius: 8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    // MARK: - Variable -
    public var data: SupplierWarehouseSessions? = nil {
        didSet {
            
            lbl_create_at.text = data?.created_at
            lbl_code.text = data?.code
            lbl_employee_name.text = data?.supplier_employee_name
            lbl_note.text = data?.note
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_amount ?? 0)
            
            lbl_quantity.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_material ?? 0)
            if data?.status == 2 && data?.type == 0{
                view_status.backgroundColor = ColorUtils.greenTransparent()
                icon_status.image = UIImage(named: "icon-check")
                lbl_status.textColor = ColorUtils.green()
                lbl_status.text = "ĐÃ THANH TOÁN"
            }else if data?.status == 2 && data?.type == 2{
                view_status.backgroundColor = ColorUtils.greenTransparent()
                icon_status.image = UIImage(named: "icon-check")
                lbl_status.textColor = ColorUtils.green()
                lbl_status.text = "DUYỆT TRẢ & NHẬP KHO"
            }else{ // data?.status == 3 && data?.type == 0
                view_status.backgroundColor = ColorUtils.redTransparent()
                icon_status.image = UIImage(named: "icon-cancel-red")
                lbl_status.textColor = ColorUtils.red_color()
                lbl_status.text = "ĐÃ HUỶ"
            }
        }
    }
}
