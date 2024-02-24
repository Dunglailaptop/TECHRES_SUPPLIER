//
//  ListItemsReportTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 07/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class ListCancelItemsReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_categor_name: UILabel!
    @IBOutlet weak var lbl_percent_category: UILabel!
    @IBOutlet weak var lbl_total_amount_category: UILabel!
    @IBOutlet weak var lbl_index_category: UILabel!
    @IBOutlet weak var view_color_category: UIView!
    
    var colors = [UIColor]()
    var indexItem = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    var viewModel: CancelItemsReportViewModel?{
        didSet{}
    }
    
    var data: MaterialReportData?{
        didSet{
            dLog(data?.toJSON() as Any)
            lbl_categor_name.text = data?.supplier_material_name
            lbl_total_amount_category.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.total_cancel ?? 0)

            lbl_index_category.text = String(indexItem + 1)
//            lbl_percent_category.text = Utils.doubleToPrecent(value: Double((data?.total_amount ?? 0)) / Double(viewModel?.totalAmount.value ?? 0))
        }
    }
    
}
