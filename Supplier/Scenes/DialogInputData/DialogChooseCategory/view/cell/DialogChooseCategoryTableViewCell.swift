//
//  DialogChooseCategoryTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 25/08/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class DialogChooseCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_text_1: UILabel!
    
    @IBOutlet weak var lbl_text_2: UILabel!
    @IBOutlet weak var icon_check: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        // Configure the view for the selected state
    }

    @IBAction func actionCheck(_ sender: Any) {
        guard let viewModel = self.viewModel else {return}
        var objectArray = viewModel.objectArray.value
        
        if let position = objectArray.firstIndex(where: {$0.id == object?.id}){
            objectArray[position].isSelected = objectArray[position].isSelected == ACTIVE ? DEACTIVE : ACTIVE
        }
        
        viewModel.objectArray.accept(objectArray)
        
        
        switch viewModel.view?.dialogType {
           
            case .order:
                break
            
            default:
            
                viewModel.view?.delegate?.callBackToGetSingleResult(result: object!)
                viewModel.view?.dismiss(animated: true)
                break
        }
        
        
    }
    
    var viewModel:DialogChooseCategoryViewModel?
    
    var object:GeneralObject?{
        didSet{

            
            lbl_text_1.text = object?.name
            lbl_text_2.text = object?.name
            icon_check.image = UIImage(named: object?.isSelected == ACTIVE  ? "icon-check-blue" :"icon-uncheck-blue")
            
            
            lbl_text_1.text = object?.name
            
            
            guard let viewModel = self.viewModel else {return}
            switch viewModel.view?.dialogType {
             
                case .restaurant: //chọn nhà hàng
                    lbl_text_2.text = object?.address
                case .brand: //chọn thương hiệu
                    lbl_text_2.text = object?.address
                case .branch: //chọn chi nhánh
                    lbl_text_2.text = object?.address
                case .order://chọn đơn hàng
                    lbl_text_2.text = object?.code
                lbl_text_1.isHidden = true
                default:
                    return
            }
            
            
        }
     
    }
    
}
