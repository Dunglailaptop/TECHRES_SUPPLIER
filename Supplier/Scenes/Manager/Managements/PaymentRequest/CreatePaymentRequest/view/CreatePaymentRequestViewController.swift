//
//  CreatePaymentRequestViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 31/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import TagListView
import RxRelay
import iOSDropDown
import MarqueeLabel
class CreatePaymentRequestViewController: BaseViewController {
    var viewModel = CreatePaymentRequestViewModel()
    var router = CreatePaymentRequestRouter()
    
    var debtReceivables:[SupplierDebtReceivable]?
    var from_date:String = ""
    var to_date:String = ""
    

    @IBOutlet weak var main_view: UIView!
    
    @IBOutlet weak var restaurant_avatar: UIImageView!
    
    
    @IBOutlet weak var view_of_restaurant_name: UIView!
    
    @IBOutlet weak var lbl_restaurant_name: MarqueeLabel!
    @IBOutlet weak var lbl_brand: MarqueeLabel!
    @IBOutlet weak var lbl_branch: MarqueeLabel!
    @IBOutlet weak var lbl_please_to_choose_restaurant: UILabel!
    
    
    @IBOutlet weak var stack_view_of_choose_date: UIStackView!
    
    @IBOutlet weak var lbl_from_date: UILabel!
    @IBOutlet weak var lbl_to_date: UILabel!
    @IBOutlet weak var lbl_amount: UILabel!

    
    
    
    @IBOutlet weak var description_view: UIView!
    @IBOutlet weak var text_view: UITextView!
    @IBOutlet weak var lbl_number_of_text_view: UILabel!
    
    
    
    @IBOutlet weak var receivable_stack_view: UIStackView!
    
    @IBOutlet weak var view_of_text_field: UIView!
    @IBOutlet weak var text_field: UITextField!
    
    @IBOutlet weak var view_of_tag_list: UIView!
    @IBOutlet weak var tag_list: TagListView!
    
    @IBOutlet weak var height_of_unit_specs_view: NSLayoutConstraint!
    @IBOutlet weak var lbl_no_data: UILabel!
    
    @IBOutlet weak var btn_show_popup: UIButton!
    
    @IBOutlet weak var icon_show_popup: UIImageView!
    
    
    
    @IBOutlet weak var view_of_table: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var receivableListSwitcher:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.bind(view: self, router: router)
        firstSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lbl_from_date.text = viewModel.APIParameter.value.from_date
        lbl_to_date.text = viewModel.APIParameter.value.to_date
    }
    
    
    private func firstSetup(){
        registerCellAndBindTable()
        /*ẩn đi text_view theo yêu cầu của QC&BA*/
        description_view.isHidden = true
        view_of_restaurant_name.isHidden = true
        mapData()
        getSupplierOrder()
        tag_list.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        tag_list.delegate = self
        text_view.withDoneButton()
       _ = text_view.rx.text.map{String($0!.prefix(255))}.map({ (str) ->
           
           (restaurant_id: Int, brand_id: Int, branch_id: Int, status: Int, from_date: String, to_date: String, supplier_order_ids: Array<Int>, reason: String)
           
           in

           self.text_view.text = str
           self.lbl_number_of_text_view.text = String(format: "%d/255", str.count)
           var cloneAPIParameter = self.viewModel.APIParameter.value
           cloneAPIParameter.reason = str
           return cloneAPIParameter
       }).bind(to: viewModel.APIParameter)

        Utils.lableMarqueeLabel(marqueeLabel: lbl_restaurant_name)
        Utils.lableMarqueeLabel(marqueeLabel: lbl_brand)
        Utils.lableMarqueeLabel(marqueeLabel: lbl_branch)
        
    
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    private func mapData(){
        guard let debtReceivables = self.debtReceivables else {return}
    
        if debtReceivables.count > 0{
            btn_show_popup.isEnabled = false
            icon_show_popup.isHidden = true
            

            view_of_text_field.isHidden = true
            view_of_tag_list.isHidden = false
            tag_list.enableRemoveButton = false
            stack_view_of_choose_date.isUserInteractionEnabled = false
            
            restaurant_avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: debtReceivables[0].restaurant_avatar)), placeholder:  UIImage(named: "image_default_logo"))
            lbl_restaurant_name.text = debtReceivables[0].restaurant_name
            lbl_brand.text = String(format: "%@", debtReceivables[0].restaurant_brand_name)
            lbl_branch.text = String(format: "%@", debtReceivables[0].branch_name)
            lbl_please_to_choose_restaurant.isHidden = true
            view_of_restaurant_name.isHidden = false
       
            lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumberInt(amount: debtReceivables.map{$0.restaurant_debt_amount}.reduce(0, +))
            viewModel.APIParameter.accept((restaurant_id: debtReceivables[0].restaurant_id,
                                           brand_id: debtReceivables[0].restaurant_brand_id,
                                           branch_id: debtReceivables[0].branch_id,
                                           status: 0,
                                           from_date: from_date,
                                           to_date: to_date,
                                           supplier_order_ids: [],
                                           reason:""))
            viewModel.receivableList.accept(debtReceivables)
        }else{
            btn_show_popup.isEnabled = true
            icon_show_popup.isHidden = false
        }
  
       
    }
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    @IBAction func actionShowPopup(_ sender: Any) {
        showPopup()
    }

    
    @IBAction func actionChooseFromDate(_ sender: Any) {
        viewModel.dateType.accept(1)
        showDateTimePicker(dataDateTime: viewModel.APIParameter.value.from_date)
    }
    
    
    @IBAction func actionChooseToDate(_ sender: Any) {
        viewModel.dateType.accept(2)
        showDateTimePicker(dataDateTime: viewModel.APIParameter.value.to_date)
    }
    
    @IBAction func actionShowDropDown(_ sender: Any) {
        receivableListSwitcher = !receivableListSwitcher
        view_of_table.isHidden = receivableListSwitcher ? false : true
    }

    
    @IBAction func actionConfirm(_ sender: Any) {
        createSupplierDebtPayment()
    }
    
    

    @objc private func keyboardWillShow(notification: NSNotification ) {


        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if text_view.isFirstResponder{
                main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height / 1.35)
            }else if text_field.isFirstResponder{
                view_of_table.isHidden = false
            }
        }
    }


    @objc private func keyboardWillHide(notification: NSNotification) {
        if text_view.isFirstResponder {
            main_view.transform = .identity

        }else if text_field.isFirstResponder{
            view_of_table.isHidden = true
        }


    }
    
}


extension CreatePaymentRequestViewController: TagListViewDelegate {

    
    func tagRemoveButtonPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        tag_list.removeTag(title)
        var cloneOrderList = viewModel.receivableList.value
        if let position = cloneOrderList.firstIndex(where: {$0.code == title}){
            cloneOrderList[position].isSelected = DEACTIVE
            
        }
        viewModel.receivableList.accept(cloneOrderList)
        viewModel.updateFullReceivableList()
        view_of_tag_list.isHidden = viewModel.receivableList.value.filter{$0.isSelected == ACTIVE}.count > 0 ? false : true
        var sum:Int = viewModel.receivableList.value.filter{$0.isSelected == ACTIVE}.map{$0.restaurant_debt_amount}.reduce(0, +)
        lbl_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: sum)
        
    }
}
