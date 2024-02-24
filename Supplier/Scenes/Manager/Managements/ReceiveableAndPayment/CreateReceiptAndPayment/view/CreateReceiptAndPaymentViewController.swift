//
//  CreateReceiptAndPaymentViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 20/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import TagListView
import iOSDropDown
class CreateReceiptAndPaymentViewController: BaseViewController {
    var viewModel = CreateReceiptAndPaymentViewModel()
    var router = CreateReceiptAndPaymentRouter()
    var warehouseReceiptViewConstraint : NSLayoutConstraint?
    var originalDropDownYPosition: CGFloat = 0.0
    /*
         type = 0 -> phiếu nhập
         type = 1 -> phiếu xuất
         type = 2 -> phiếu nhập trả
         type = 3 -> phiếu nhập huỷ
         type = 4 -> phiếu xuất huỷ
         type = 1 -> Đang xử lý
         type = 2 -> Hoàn tất
         type = 3 -> Hủy
      
     */
    var noteType = 1

    
    @IBOutlet weak var main_view: UIView!
    @IBOutlet weak var btn_choose_warehouse_receipt: UIButton!
    @IBOutlet weak var btn_choose_other_cost: UIButton!
    
    
    @IBOutlet weak var lbl_date_title: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    
    @IBOutlet weak var category_drop_down: DropDown!
    @IBOutlet weak var lbl_category_err: UILabel!
    @IBOutlet weak var btn_show_drop_down: UIButton!
    
    
    @IBOutlet weak var top_contraint_of_warehouse_receipt_dropdown: NSLayoutConstraint!
    @IBOutlet weak var warehouse_receipt_dropdown: DropDown!
    @IBOutlet weak var lbl_warehouse_receipt_err: UILabel!
    
    @IBOutlet weak var tag_view: TagListView!
    @IBOutlet weak var height_of_tag_view: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_amount: UILabel!
    @IBOutlet weak var lbl_amount_err: UILabel!
    
    @IBOutlet weak var header_view: UIView!
    @IBOutlet weak var warehouse_receipt_view: UIView!
    @IBOutlet weak var lbl_number_of_char_in_text_view: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var lbl_description_err: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        textView.withDoneButton()
        _ = textView.rx.text.map{String($0!.prefix(255))}.map({ [self](str) -> ReceiptPayment in
            lbl_number_of_char_in_text_view.text = String(format: "%d/255", str.count)
            var cloneAPIParamter = viewModel.APIParameter.value
            cloneAPIParamter.note = str
            textView.text = str
            return cloneAPIParamter
        }).bind(to:viewModel.APIParameter)
        
        firstSetup()
        hideAllErr()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object:nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification , object:nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
     }
    
    private func firstSetup(){
        
        var cloneAPIParamter = viewModel.APIParameter.value
        cloneAPIParamter.fee_month = Utils.getCurrentDateString()
        viewModel.APIParameter.accept(cloneAPIParamter)
        
        tag_view.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
        tag_view.delegate = self
        lbl_date.text = Utils.getCurrentDateString()
        warehouse_receipt_dropdown.hideOptionsWhenSelect = false
        warehouse_receipt_dropdown.didSelect{ [self](selectedText , index ,id) in
            tag_view.addTag(selectedText)
            height_of_tag_view.constant = 10 + tag_view.intrinsicContentSize.height
            self.view.layoutIfNeeded()
            
            var warehouseReceiptList = viewModel.warehouseReceiptList.value
            if let position = warehouseReceiptList.firstIndex(where: {(element) in element.code == selectedText}){
                warehouseReceiptList[position].isSelected = ACTIVE
            }
            viewModel.warehouseReceiptList.accept(warehouseReceiptList)
            warehouse_receipt_dropdown.optionArray = warehouseReceiptList.filter{$0.isSelected == DEACTIVE}.map{$0.code}
            warehouse_receipt_dropdown.text = ""
        }
        
        
        category_drop_down.didSelect{ [self](selectedText , index ,id) in
            category_drop_down.text = selectedText
            var cloneAPIParameter = viewModel.APIParameter.value
            cloneAPIParameter.supplier_addition_fee_reason_id = id
            viewModel.APIParameter.accept(cloneAPIParameter)
        }
        
        noteType == 1 ? setUpForPaymentCreateFunc() : setUpForReceiptCreateFunc()
        viewModel.noteType.accept(noteType)
        getReceiptAndPaymentCategory()
    }

    	
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func actionChooseWarehouseReceipt(_ sender: Any) {
        changeHeader(btn: btn_choose_warehouse_receipt)
        warehouse_receipt_view.isHidden = false
        warehouseReceiptViewConstraint?.isActive = false
        top_contraint_of_warehouse_receipt_dropdown.constant = 15
        self.view.layoutIfNeeded()
        getSupplierWarehouseSession()
        viewModel.object_type.accept(2)
    }
    
    
    @IBAction func actionChooseOtherCost(_ sender: Any) {
        changeHeader(btn: btn_choose_other_cost)
        warehouse_receipt_view.isHidden = true
        warehouseReceiptViewConstraint = warehouse_receipt_view.heightAnchor.constraint(equalToConstant: 0)
        warehouseReceiptViewConstraint?.isActive = true
        self.view.layoutIfNeeded()
        viewModel.object_type.accept(0)
    }
    
    
    
    @IBAction func actionChooseDate(_ sender: Any) {
        showDateTimePicker(dateTimeData: viewModel.APIParameter.value.fee_month)
    }
    
    
    @IBAction func actionShowCategoryDropdown(_ sender: Any) {
        category_drop_down.showList()
    }
    
    @IBAction func actionShowCaculator(_ sender: Any) {
        presentCalculator(currentFigure:0.0)
    }
    
    
    @IBAction func actionConfirm(_ sender: Any) {
        createReceiptAndPayment()
    }
    
    
    
    func hideAllErr(){
        lbl_category_err.isHidden = true
        lbl_warehouse_receipt_err.isHidden = true
        lbl_amount_err.isHidden = true
        lbl_description_err.isHidden = true
        
    }
    
    
    @objc private func keyboardWillShow(notification: NSNotification ) {

        if warehouse_receipt_dropdown.isFirstResponder {
            self.main_view.transform = CGAffineTransform(translationX: 0, y: -100)
            warehouse_receipt_dropdown.hideListWithoutAnimation()
            warehouse_receipt_dropdown.showList()
        }else {
            guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return}
            self.main_view.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
        }
       
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        if warehouse_receipt_dropdown.isFirstResponder{
            self.main_view.transform = .identity
            warehouse_receipt_dropdown.hideListWithoutAnimation()
        }else {
            self.main_view.transform = .identity
        }
    }
    
    
    private func setUpForPaymentCreateFunc(){
        lbl_date_title.text = "NGÀY CHI"
        warehouse_receipt_view.isHidden = false
        header_view.isHidden = false
        actionChooseWarehouseReceipt("")
    }
    
    private func setUpForReceiptCreateFunc(){
        lbl_date_title.text = "NGÀY THU"
        warehouse_receipt_view.isHidden = true
        header_view.isHidden = true
        header_view.heightAnchor.constraint(equalToConstant: 0).isActive = true
        top_contraint_of_warehouse_receipt_dropdown.constant = 0
        warehouseReceiptViewConstraint = warehouse_receipt_view.heightAnchor.constraint(equalToConstant: 0)
        warehouseReceiptViewConstraint?.isActive = true
        self.view.layoutIfNeeded()
        viewModel.object_type.accept(0)
    }
    
    private func changeHeader(btn:UIButton){
        btn_choose_warehouse_receipt.backgroundColor = ColorUtils.gray_200()
        btn_choose_other_cost.backgroundColor = ColorUtils.gray_200()
        top_contraint_of_warehouse_receipt_dropdown.constant = 0
        btn_choose_warehouse_receipt.setTitleColor(ColorUtils.gray_600(),for: .normal)
        btn_choose_other_cost.setTitleColor(ColorUtils.gray_600(),for: .normal)
       
        btn.backgroundColor = ColorUtils.blue_000()
        btn.setTitleColor(ColorUtils.blue_700(),for: .normal)
    }
    
}
