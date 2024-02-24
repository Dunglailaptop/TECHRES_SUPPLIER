//
//  CreateReceiptAndPaymentCategoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 29/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import iOSDropDown
class CreateReceiptAndPaymentCategoryViewController: BaseViewController {
    var viewModel = CreateReceiptAndPaymentCategoryViewModel()
    var router = CreateReceiptAndPaymentCategoryRouter()
    var receiptAndPaymentCategory: ReceiptPaymentCategory = ReceiptPaymentCategory()    
    @IBOutlet weak var lbl_note_type: UILabel!
    @IBOutlet weak var btn_show_note_type: UIButton!
    @IBOutlet weak var lbl_category: UILabel!
    @IBOutlet weak var btn_show_category_type: UIButton!
    @IBOutlet weak var text_field_category_name: UITextField!
    @IBOutlet weak var lbl_category_name_err: UILabel!
    
    @IBOutlet weak var note_type_view: UIView!
    
    @IBOutlet weak var category_view: UIView!
    //Outlet btn-bar
    @IBOutlet weak var btn_bar_view: UIView!
    
    @IBOutlet weak var cancel_view: UIView!
    @IBOutlet weak var confirm_view: UIView!
    @IBOutlet weak var create_btn_view: UIView!

    @IBOutlet weak var category_dropdown: DropDown!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        // Do any additional setup after loading the view.
        firstSetup()
 
    }
    
    
    private func firstSetup(){
        getReceiptAndPaymentCategory()
        btn_bar_view.addShadow(shadowOffset: .zero, shadowOpacity: 0.7, shadowRadius: 10, color: .black)

        receiptAndPaymentCategory.id > 0 ? setUpForUpdateFunc() : setUpForCreateFunc()
        
        _ = text_field_category_name.rx.text.map{String($0!.prefix(50))}.map({(str) -> ReceiptPaymentCategory in
            var cloneReceiptPaymentCategory = self.viewModel.receiptPaymentCategory.value
            cloneReceiptPaymentCategory.name = Utils.blockSpecialCharacters(str)
            self.text_field_category_name.text = Utils.blockSpecialCharacters(str)
            return cloneReceiptPaymentCategory
        }).bind(to: viewModel.receiptPaymentCategory).disposed(by:rxbag)
        
        
        _ = isCategoryNameValid.subscribe(onNext:{[weak self] (isValid) in
            self!.lbl_category_name_err.isHidden = isValid ? true : false
        }).disposed(by: rxbag)
        
        lbl_category_name_err.isHidden = true
    }
    
    private func setUpForCreateFunc(){
        create_btn_view.isHidden = false
        confirm_view.isHidden = true
        cancel_view.isHidden = true
    }
    
    private func setUpForUpdateFunc(){
        create_btn_view.isHidden = true
        confirm_view.isHidden = false
        cancel_view.isHidden = false
        note_type_view.isHidden = true
        category_view.isHidden = true
//        /*
//            type = 0 -> phiếu thu
//            type = 1 -> phiếu chi
//         */
//        lbl_note_type.text = receiptAndPaymentCategory.supplier_addition_fee_type == 0 ? "Phiếu thu" : "Phiếu chi"
//        lbl_category.text = receiptAndPaymentCategory.supplier_addition_fee_reason_category_name
        text_field_category_name.text = receiptAndPaymentCategory.name
        viewModel.receiptPaymentCategory.accept(receiptAndPaymentCategory)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    @IBAction func actionBack(_ sender: Any) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func actionChooseNoteType(_ sender: Any) {
        viewModel.filterType.accept(0)
        showNoteType(btnShowPopup: btn_show_note_type)
        
    }
    
    
    @IBAction func actionChooseCategory(_ sender: Any) {
        viewModel.filterType.accept(1)
        showCategoryTypeList(btnShowPopup: btn_show_category_type)
    }
    
    
    
    
    @IBAction func btnCancel(_ sender: UIButton) {
        viewModel.makePopViewController()
    }
    
    
    @IBAction func btnConfirm(_ sender: Any) {
       
        isCategoryNameValid.take(1).subscribe(onNext: { [self] isValid in
            if isValid {
                receiptAndPaymentCategory.id > 0 ? updateReceiptAndPaymentCategory() : createReceiptAndPaymentCategory()
            }
        }).disposed(by: rxbag)
        
        
    }
    

}
