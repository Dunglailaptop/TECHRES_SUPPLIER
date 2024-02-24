//
//  ListReceiptBillDebtTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import MarqueeLabel
class AccountsReceivableListTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_code: MarqueeLabel! // Tên nhà hàng
    @IBOutlet weak var lbl_create_at: UILabel! // ngày tạo
    @IBOutlet weak var lbl_total_amount: UILabel! // tổng tiền
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
    
    
    public var viewModel:AccountsReceivableListViewModel?
    
    public var data: SupplierDebtReceivable? = nil {
        didSet {
            lbl_code.text = data?.code
            Utils.getMarqueeLabel(lblContent: lbl_code)
            
            lbl_create_at.text = data?.updated_at
            lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data?.restaurant_debt_amount ?? 0)
            dLog(data)
            btnCheck.setImage(UIImage(named: data!.isSelected == ACTIVE
                                      ?  "icon-check-blue"
                                      : "icon-uncheck-blue"), for: .normal)
            
        }
    }
    
    
    
    
    @IBAction func actionCheck(_ sender: Any) {
        guard let viewModel = self.viewModel else {return}
        
        if let position = viewModel.dataArray.value.firstIndex(where: {(element) in element.id == data?.id}){
            var dataArray = viewModel.dataArray.value
            dataArray[position].isSelected = data?.isSelected == DEACTIVE ? ACTIVE : DEACTIVE
            viewModel.dataArray.accept(dataArray)
        }
        
        if let position = viewModel.dataArraySearch.value.firstIndex(where: {(element) in element.id == data?.id}){
            var dataArraySearch = viewModel.dataArraySearch.value
            dataArraySearch[position].isSelected = data?.isSelected == DEACTIVE ? ACTIVE : DEACTIVE
            viewModel.dataArraySearch.accept(dataArraySearch)
        }
        
        let dataArrayCapacity = viewModel.dataArray.value.count
        
        viewModel.view?.lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumber(amount:
                                                                                    viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}
                                                                                    .flatMap{$0.restaurant_debt_amount}.reduce(0){$0 + $1})
       
        if viewModel.dataArraySearch.value.count > 0 {
            
            
            viewModel.view?.lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumber(amount:
                                                                                        viewModel.dataArraySearch.value.filter{$0.isSelected == ACTIVE}
                                                                                        .flatMap{$0.restaurant_debt_amount}.reduce(0){$0 + $1})
          
        }else {
            viewModel.view?.lbl_total_payment.text = Utils.stringVietnameseMoneyFormatWithNumber(amount:
                                                                                        viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}
                                                                                        .flatMap{$0.restaurant_debt_amount}.reduce(0){$0 + $1})
        }
        
        viewModel.view?.btnCheckAll.setImage(UIImage(named:
                dataArrayCapacity == viewModel.dataArray.value.filter{$0.isSelected == ACTIVE}.count
                ? "icon-check-blue"
                : "icon-uncheck-blue"),
        for: .normal)
    }
    
    
    
    

    
    
}
