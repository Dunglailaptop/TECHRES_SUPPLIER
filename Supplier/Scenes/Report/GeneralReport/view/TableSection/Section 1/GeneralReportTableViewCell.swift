//
//  GeneralReportTableViewCell.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 13/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
class GeneralReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbl_total_order_quantity: UILabel!
    @IBOutlet weak var lbl_total_order_amount: UILabel!
    
    @IBOutlet weak var lbl_delivering_order_quantity: UILabel!
    @IBOutlet weak var lbl_delivering_order_amount: UILabel!
    
    
    @IBOutlet weak var lbl_returned_order_quantity: UILabel!
    @IBOutlet weak var lbl_returned_order_amount: UILabel!
    
    @IBOutlet weak var lbl_total_revenue: UILabel!
    
    
    @IBOutlet weak var lbl_waiting_approve_order_quantity: UILabel!
    @IBOutlet weak var lbl_waiting_approve_order_amount: UILabel!
    
    @IBOutlet weak var lbl_delivered_order_quantity: UILabel!
    @IBOutlet weak var lbl_delivered_order_amount: UILabel!
    
    @IBOutlet weak var lbl_cancel_order_quantity: UILabel!
    @IBOutlet weak var lbl_cancel_order_amount: UILabel!
    
    @IBOutlet weak var lbl_total_cost: UILabel!
    
    @IBOutlet weak var total_order_view: UIView!
    @IBOutlet weak var delivering_order_view: UIView!
    @IBOutlet weak var returned_order_view: UIView!
    @IBOutlet weak var total_revenue_view: UIView!
    @IBOutlet weak var waiting_approve_order_view: UIView!
    @IBOutlet weak var delivered_order_view: UIView!
    @IBOutlet weak var cancel_order_view: UIView!
    @IBOutlet weak var total_spending_view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        firstSetup()
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
    
    func firstSetup(){
        let labelArray:[UILabel] = [lbl_total_order_quantity,lbl_delivering_order_quantity,lbl_returned_order_quantity,lbl_waiting_approve_order_quantity,lbl_delivered_order_quantity,lbl_cancel_order_quantity]
        let viewArray:[UIView]=[
            total_order_view,delivering_order_view,
            returned_order_view,total_revenue_view,
            waiting_approve_order_view,
            delivered_order_view,
            cancel_order_view,
            total_spending_view]
        
        

        for label in labelArray{
            label.roundCorners(corners: .allCorners, radius: 15)
        }
        
        for view in viewArray{
            view.addShadow(
                shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 0.1, shadowRadius: 2, color: UIColor(.black)
            )
        }
    }
    
    
    var viewModel:GeneralReportViewModel?{
        didSet{
            bindViewModel()
        }
    }
}

extension GeneralReportTableViewCell{
    func bindViewModel(){
        if let viewModel = viewModel{
            viewModel.generalReport.subscribe(onNext:  { [self] (data) in
                

                lbl_total_order_quantity.text = String(data.total_order)
                lbl_total_order_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_amount)
                
                lbl_delivering_order_quantity.text = String(data.order_not_delivered)
                lbl_delivering_order_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.order_not_delivered_amount)
                
                
                lbl_returned_order_quantity.text = String(data.total_return)
                
                lbl_returned_order_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_return_amount)
                
                lbl_total_revenue.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_revenue)
                
                lbl_waiting_approve_order_quantity.text = "0"
                lbl_waiting_approve_order_amount.text = "0"
                
                lbl_delivered_order_quantity.text = String(data.order_delivered)
                lbl_delivered_order_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.order_delivered_amount)
                
                lbl_cancel_order_quantity.text = String(data.order_cancel)
                lbl_cancel_order_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.order_cancel_amount)
                
                lbl_total_cost.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.total_cost)
              
            }).disposed(by: disposeBag)
        }
    }
}
 
