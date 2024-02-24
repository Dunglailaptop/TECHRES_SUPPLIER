//
//  ReceiptAndPaymentCategoryTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 28/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ReceiptAndPaymentCategoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbl_note_type: UILabel!
    
    @IBOutlet weak var lbl_category: UILabel!
    
    @IBOutlet weak var lbl_object_name: UILabel!

    @IBOutlet weak var cancel_btn_view: UIView!
    @IBOutlet weak var edit_btn_view: UIView!
    
    var delegate:ReceiptAndPaymentCatetoryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cancel_btn_view.roundCorners(corners: [.bottomLeft], radius: 20)
        edit_btn_view.roundCorners(corners: [.bottomRight], radius: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel:ReceiptAndPaymentCategoryViewModel?
    
    var data: ReceiptPaymentCategory? = nil {
        didSet{
            lbl_note_type.text = data?.supplier_addition_fee_type == 0 ? "phiếu thu" : "Phiếu chi"
            lbl_category.text = data?.name
            lbl_object_name.text = data?.is_system_auto_generate == 1 ? "Đơn hàng" : "Thu tay"
            /*is_system_auto_generate = 1 là phiếu thu tự động, nên sẽ không thề chỉnh sửa được*/
            edit_btn_view.isHidden =  data?.is_system_auto_generate == 1 ? true : false
            
        }
        
    }
    
    
    @IBAction func actionToDeactive(_ sender: Any) {
        if let viewModel = self.viewModel{
            delegate?.callBackToShowDialogConfirm(content: String(format: "%@ sẽ chuyển sang trạng thái tạm ngưng", data?.name ?? ""))
            viewModel.closure.accept({})
            viewModel.closure.accept {
                viewModel.view?.changeReceiptAndPaymentCategoryStatus(id: self.data!.id)
            }

        }
    }
    
    
    @IBAction func actionToEdit(_ sender: Any) {
        if let viewModel = self.viewModel{
            viewModel.makeCreateReceiptAndPaymentCategoryViewController(receiptAndPaymentCategory: data!)
        }
    }
    
    
}



