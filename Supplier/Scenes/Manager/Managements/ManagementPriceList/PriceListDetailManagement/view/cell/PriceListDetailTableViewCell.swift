//
//  PriceListDetailTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 17/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift

class PriceListDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_name_product: UILabel!
    
    @IBOutlet weak var lbl_price_product_unit: UILabel!
    
    @IBOutlet weak var lbl_price_product: UILabel!
    
    @IBOutlet weak var btn_EditPrice: UIButton!
    
  
    @IBOutlet weak var lbl_price_export: UILabel!
    
    var price_Detail = 0
    
    var delegateMoney: ShowInputMoneyPriceListDelegate?
    
    var view = PriceListDetailViewController()
    
    private(set) var Disposebag = DisposeBag()
    override func awakeFromNib() {
        super.awakeFromNib()
        Disposebag = DisposeBag()
        // Initialization code
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public var data: MaterialPriceList? = nil {
        didSet {
            lbl_name_product.text = Utils().capitalizeString(inputString: data!.name )
//            lbl_price_product_unit.text = data?.material_unit_full_name
            lbl_price_product.text = Utils.stringQuantityFormatWithNumber(amount: data!.retail_price)
            lbl_price_export.text = Utils.stringQuantityFormatWithNumber(amount: data!.price)
        }
    }
    
    public var viewModel: PriceListDetailViewModel? = nil {
        didSet {
         
        }
    }
    
  
    
    
//    func callBackPresentInputMoney() {
//        delegateMoney?.callbackShowInputPriceList()
//    }
   
}

