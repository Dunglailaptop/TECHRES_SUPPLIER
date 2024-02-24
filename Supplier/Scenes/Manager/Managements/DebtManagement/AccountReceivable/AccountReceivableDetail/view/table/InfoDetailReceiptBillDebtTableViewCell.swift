//
//  InfoDetailReceiptBillDebtTableViewCell.swift
//  Techres-Seemt
//
//  Created by Huynh Quang Huy on 25/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import MarqueeLabel
class InfoDetailReceiptBillDebtTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_code: UILabel!
    @IBOutlet weak var lbl_delivery_at: UILabel!
    @IBOutlet weak var lbl_restaurant_name: MarqueeLabel!
    @IBOutlet weak var lbl_restaurant_brand_name: MarqueeLabel!
    @IBOutlet weak var lbl_branch_name: MarqueeLabel!
    @IBOutlet weak var lbl_employee_complete: MarqueeLabel!
    @IBOutlet weak var lbl_employee_delivering: MarqueeLabel!
    @IBOutlet weak var lbl_reason: UILabel!
    
    
    @IBOutlet weak var lbl_total_net_amount: UILabel!
    @IBOutlet weak var lbl_total_amount: UILabel!
    
    @IBOutlet weak var lbl_discount_percent: UILabel!
    @IBOutlet weak var lbl_discount: UILabel!
    
    @IBOutlet weak var lbl_VAT_percent: UILabel!
    @IBOutlet weak var lbl_VAT: UILabel!
    
    
    @IBOutlet weak var lbl_total_returned_amount: UILabel!
    
    @IBOutlet weak var lbl_total_material: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var height_of_tableView: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
        Utils.getMarqueeLabel(lblContent: lbl_restaurant_name)
        Utils.getMarqueeLabel(lblContent: lbl_restaurant_brand_name)
        Utils.getMarqueeLabel(lblContent: lbl_branch_name)
        Utils.getMarqueeLabel(lblContent: lbl_employee_complete)
        Utils.getMarqueeLabel(lblContent: lbl_employee_delivering)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
    private(set) var disposeBag = DisposeBag()
           override func prepareForReuse() {
               super.prepareForReuse()
               disposeBag = DisposeBag()
    }
    
    var viewModel: AccountReceivableDetailViewModel?{
        didSet{
            bindTableView()
            bindViewModel()
        }
    }
}

extension InfoDetailReceiptBillDebtTableViewCell:UITableViewDelegate{
    func bindViewModel(){
        if let viewModel = viewModel {
            viewModel.debtReceivable.subscribe( // Thực hiện subscribe Observable data
                  onNext: { [self] data in
                      dLog(data)
                      lbl_code.text = String(data.code)
                      lbl_delivery_at.text = data.received_at
                      lbl_restaurant_name.text = data.restaurant_name
                      lbl_restaurant_brand_name.text = data.restaurant_brand_name
                      lbl_branch_name.text = data.branch_name
                      lbl_employee_complete.text = data.employee_complete_full_name
                      lbl_employee_delivering.text = data.supplier_employee_delivering_name
                      lbl_reason.text = data.reason
                      lbl_total_net_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.restaurant_debt_amount)
                      lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.amount)
                      lbl_discount_percent.text = String(format: "-%.1f%%", data.discount_percent)
                      lbl_discount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.discount_amount)
                      lbl_VAT_percent.text = String(format: "%.1f%%", data.vat)
                      lbl_VAT.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: data.vat_amount)
//                      lbl_total_returned_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: )
                      lbl_total_returned_amount.text = Utils.stringQuantityFormatWithNumber(amount: data.total_return) 
            }).disposed(by: disposeBag)
        }
    }
    
    
    func registerCell() {
        let cellofAccountReceivableDetail = UINib(nibName: "CellofAccountReceivableDetail", bundle: .main)
        tableView.register(cellofAccountReceivableDetail, forCellReuseIdentifier: "CellofAccountReceivableDetail")
        tableView.isScrollEnabled = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
    }
    
    func bindTableView(){
        guard let viewModel = self.viewModel else {return}
        viewModel.debtReceivableDataArray.bind(to: tableView.rx.items(cellIdentifier: "CellofAccountReceivableDetail", cellType: CellofAccountReceivableDetail.self))
            {  (row, data, cell) in
                cell.data = data
            }.disposed(by: disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


