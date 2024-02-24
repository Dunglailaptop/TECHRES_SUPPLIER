//
//  PaymentBillDebtTableViewCell.swift
//  SEEMT
//
//  Created by macmini_techres_04 on 05/06/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class AccountsPayableTableViewCell: UITableViewCell {
    

    @IBOutlet weak var lbl_order_code: UILabel!
    
    @IBOutlet weak var lbl_note: UILabel!
    
//    @IBOutlet weak var lbl_created_date: UILabel!
//
    @IBOutlet weak var lbl_created_time: UILabel!
    
    @IBOutlet weak var lbl_total_amount: UILabel!
    
    
    @IBOutlet weak var btnCheck: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private(set) var disposeBag = DisposeBag()
        override func prepareForReuse() {
            super.prepareForReuse()
            disposeBag = DisposeBag()
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var viewModel:AccountsPayableViewModel?
    
    public var data: WarehouseReceipt? = nil {
        didSet {
            dLog(data)
            lbl_order_code.text = data?.code
                        
            lbl_created_time.attributedText = Utils.setMultipleFontAndColorForLabel(
                label: lbl_created_time,
                attributes: [
                    (str:data?.created_at.components(separatedBy: " ")[0] ?? "" + "\n",font:UIFont.systemFont(ofSize: 10),color:.black),
                    (str:data?.created_at.components(separatedBy: " ")[1] ?? "",font:UIFont.systemFont(ofSize: 14),color:ColorUtils.gray_600())
                ])
        
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount: data?.total_amount.rounded(.towardZero) ?? 0.0)
            lbl_note.text = data?.note
            btnCheck.setImage(UIImage(named: data!.isSelected == ACTIVE
                                      ?  "icon-check-blue"
                                      : "icon-uncheck-blue"), for: .normal)
            
            
                
        }
    }
    
    
    @IBAction func actionCheck(_ sender: Any) {
        guard let viewModel = self.viewModel else {return}
        var dataArray = viewModel.warehouseReceiptList.value
        var dataSearch = viewModel.warehouseReceiptListHisory.value
        if let position = viewModel.warehouseReceiptList.value.firstIndex(where: {(element) in element.id == data?.id}){
    
            dataArray[position].isSelected = data?.isSelected == DEACTIVE ? ACTIVE : DEACTIVE

    
        }
        if let positions = viewModel.warehouseReceiptListHisory.value.firstIndex(where: {(element) in element.id == data?.id}){
    
            dataSearch[positions].isSelected = data?.isSelected == DEACTIVE ? ACTIVE : DEACTIVE

    
        }
        if viewModel.warehouseReceiptListHisory.value.count > 0 {
          
            viewModel.view?.lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount:dataSearch.filter{$0.isSelected == ACTIVE}.map{$0.total_amount}.reduce(0, +))
        }else {
            viewModel.view?.lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumberDouble(amount:dataArray.filter{$0.isSelected == ACTIVE}.map{$0.total_amount}.reduce(0, +))
        }
     
        

        viewModel.warehouseReceiptList.accept(dataArray)
        viewModel.warehouseReceiptListHisory.accept(dataSearch)
       
        
        
        viewModel.view?.btnCheckAll.setImage(UIImage(named:
                dataArray.count == viewModel.warehouseReceiptList.value.filter{$0.isSelected == ACTIVE}.count
                ? "icon-check-blue"
                : "icon-uncheck-blue"),
        for: .normal)
    }
    
}



