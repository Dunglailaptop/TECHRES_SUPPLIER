//
//  ReportDayOffTableViewCell.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 12/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import MarqueeLabel
class ItemsManagementTableViewCell: UITableViewCell {
    
    @IBOutlet weak var handle_view: UIView!
    
    @IBOutlet weak var lbl_category_name: MarqueeLabel!
        
    @IBOutlet weak var lbl_material_name: UILabel!
    
    @IBOutlet weak var lbl_measure_unit: UILabel!
    

    
    
    @IBOutlet weak var lbl_remaining_quantity: UILabel!
    
    @IBOutlet weak var lbl_wastage_rate: UILabel!
    
    @IBOutlet weak var lbl_price: UILabel!
    
    @IBOutlet weak var lbl_retail_price: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        handle_view.roundCorners(corners: [.bottomLeft,.topLeft], radius: 8)
        lbl_price.adjustsFontSizeToFitWidth = true
        lbl_retail_price.adjustsFontSizeToFitWidth = true
        lbl_material_name.adjustsFontSizeToFitWidth = true

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private(set) var disposeBag = DisposeBag()
           override func prepareForReuse() {
               super.prepareForReuse()
               disposeBag = DisposeBag()
    }
    
    // MARK: - Variable -
    public var data: Material? = nil {
        didSet {
            if let data = data{
                lableMarqueeLabel(marqueeLabel: lbl_category_name)
                lbl_category_name.text = data.material_category_name + " |"
                dLog(data)
                lbl_category_name.attributedText = Utils.setMultipleColorForLabel(
                    label: lbl_category_name,
                    attributes: [
                        (str:"",color:ColorUtils.gray_400()),
                        (str:String(format:"",data.id) ,color:ColorUtils.green_007())
                    ])
                
                lbl_material_name.text = data.name.uppercased()
                
                lbl_measure_unit.attributedText = Utils.setMultipleColorForLabel(
                    label: lbl_measure_unit,
                    attributes: [
                        (str:data.material_unit_name ,color:ColorUtils.green_007()),
                        (str:"",color:ColorUtils.gray_400()),
                        (str:"",color:ColorUtils.gray_600())
                    ])
                
                
         
                lbl_remaining_quantity.text = Utils.stringQuantityFormatWithNumberFloat(amount: data.out_stock_alert_quantity)
                lbl_wastage_rate.text =  Utils.removeZeroFromNumberFloat(number: data.wastage_rate)
                lbl_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.price)
                lbl_retail_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.retail_price)
            }
        }
    }
    var viewModel: ItemsManagementViewModel? {
           didSet {
              
           }
    }

    
    func lableMarqueeLabel(marqueeLabel:MarqueeLabel){
            marqueeLabel.type = .continuous
            marqueeLabel.scrollDuration = 5.0
            marqueeLabel.animationCurve = .easeInOut
            marqueeLabel.speed = .duration(15)
            marqueeLabel.fadeLength = 10.0
            marqueeLabel.leadingBuffer = 2.0
            marqueeLabel.trailingBuffer = 2.0
    }
    
}
