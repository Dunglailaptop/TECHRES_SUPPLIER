//
//  CreateInventoryViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Huynh Quang Huy on 27/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import JonAlert

class CreateInventoryViewController: BaseViewController {

    var viewModel = CreateInventoryViewModel()
    var router = CreateInventoryRouter()
    
    
    @IBOutlet weak var lbl_title: UILabel! // tiêu đề màn hình
    @IBOutlet weak var lbl_title_total_amount: UILabel! // tiêu đề tổng thành tiền or thanh toán
    
    @IBOutlet weak var lbl_title_quantity: UILabel! // tiêu đề số lượng
    @IBOutlet weak var view_total_price: UIView! // view tổng tiền
    
    @IBOutlet weak var view_discount: UIView! // view giảm giá
    @IBOutlet weak var view_vat: UIView! // view vat
    @IBOutlet weak var height_stackview_amount: NSLayoutConstraint! // chiều cao stack số tiền
    

    @IBOutlet weak var icon_create: UIImageView!
    @IBOutlet weak var lbl_create: UILabel!
    @IBOutlet weak var view_btn_create: UIView!
    @IBOutlet weak var btn_create: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textview_note: UITextView! // text view
    @IBOutlet weak var lbl_limit_character: UILabel! // limit text

    @IBOutlet weak var lbl_total_amount: UILabel! // thanh toán
    @IBOutlet weak var lbl_total_price: UILabel! // tổng tiền
    
    @IBOutlet weak var lbl_discount_percent: UILabel! // % giảm giá
    @IBOutlet weak var lbl_discount_amount: UILabel! // tiền giảm giá
    
    @IBOutlet weak var lbl_vat_percent: UILabel! // % vat
    @IBOutlet weak var lbl_vat_amount: UILabel! // tiền vat
    
    @IBOutlet weak var lbl_total_quantity: UILabel! // tổng mặt hàng
    
    @IBOutlet weak var icon_check: UIImageView!
    @IBOutlet weak var icon_check02: UIImageView!
    
    @IBOutlet weak var icon_edit_discount: UIImageView!
    @IBOutlet weak var icon_edit_vat: UIImageView!
    
    @IBOutlet weak var constraint_icon_edit_discount: NSLayoutConstraint!
    @IBOutlet weak var constraint_discount_percent: NSLayoutConstraint!
    
    @IBOutlet weak var height_table_view: NSLayoutConstraint!
    @IBOutlet weak var root_view_empty_data: UIView!
    
    let refreshControl = UIRefreshControl()
    var isCheckSpam:Bool = false
    var dataArrayMaterial = [Material]()
    var dataSelectedMaterial = [Material]()
    var btnCreateType = 0 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.bind(view: self, router: router)
        registerCell()
        bindTableViewData()
        firstSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        viewModel.dataArray.accept(dataArrayMaterial)
        Utils.isHideAllView(isHide: dataArrayMaterial.isEmpty ? false : true, view: root_view_empty_data)
    }
    
    func firstSetup() {
        dLog(btnCreateType)
        let isImport = btnCreateType == Constants.SUPPLIER_CREATE_INVENTORY_TYPE.IMPORT
        
        textview_note.setPlaceholderColor(isImport ? "Hãy nhập ghi chú" : "Lý do huỷ", false)
        lbl_title.text = isImport ? "TẠO PHIẾU NHẬP KHO" : "TẠO PHIẾU HUỶ"
        lbl_title_total_amount.text = isImport ? "THANH TOÁN" : "TỔNG THÀNH TIỀN"
        lbl_title_quantity.text = isImport ? "SL NHẬP" : "SL HUỶ"
        Utils.isHideAllView(isHide: !isImport, view: view_total_price)
        Utils.isHideAllView(isHide: !isImport, view: view_discount)
        Utils.isHideAllView(isHide: !isImport, view: view_vat)
        height_stackview_amount.constant = isImport ? 140 : 35
        
        textview_note.withDoneButton()
        // Cắt chuỗi khi vượt quá 255 kí tự
        textview_note.rx.text
            .orEmpty // convert to non-optional string
            .map { $0.prefix(255) } // limit to max length
            .subscribe(onNext: { [weak self] newText in
                self?.textview_note.text = String(newText)
            })
            .disposed(by: rxbag)
    
        // Đếm kí tự gõ văn bản
        textview_note.rx.text
                      .subscribe(onNext: {
                          self.lbl_limit_character.text = String(format: "%d/%d", $0!.count, 255)
                      })
                      .disposed(by: rxbag)
                
        _ = textview_note.rx.text.map { $0?.trimmingCharacters(in: .whitespacesAndNewlines) ?? "" }.bind(to: viewModel.note)
        
        var totalAmount:Double = 0.00
        dataArrayMaterial.enumerated().forEach { (index, value) in
            totalAmount += Double(dataArrayMaterial[index].price) * Double(dataArrayMaterial[index].total_import_quantity)
        }
        viewModel.total_amount.accept(Int(totalAmount))
        viewModel.total_price.accept(Int(totalAmount))
        lbl_total_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
        lbl_total_price.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: Int(totalAmount))
        lbl_total_quantity.text = Utils.stringQuantityFormatWithNumber(amount: dataArrayMaterial.count)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        if viewModel.dataArray.value.isEmpty == true {
            self.viewModel.makePopViewController()
        }else{
            self.viewModel.type_dialog.accept(2)
            self.presentModalDialogAcceptSupplierWarehouse(index: 0)
        }
    }
    
    @IBAction func actionShowChooseInputDiscount(_ sender: Any) {
        if isCheckSpam { return }
            isCheckSpam = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                self.isCheckSpam = false
        }
        if (viewModel.dataArray.value.count == 0) {
            JonAlert.show(message: "Vui lòng chọn nguyên liệu", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        } else if viewModel.discount_amount.value == 0{
            self.presentModalDialogChooseInput()
        }else {
            viewModel.discount_amount.accept(0)
            viewModel.discount_percent.accept(0)
            lbl_discount_amount.text = "0"
            lbl_discount_percent.isHidden = true
            icon_edit_discount.isHidden = true
            icon_check.image = UIImage(named: "icon-uncheck-blue")
            self.calculateAmount()
        }
    }
    
    @IBAction func actionShowChooseInputVAT(_ sender: Any) {
        if isCheckSpam { return }
            isCheckSpam = true
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                self.isCheckSpam = false
        }
        if (viewModel.dataArray.value.count == 0) {
            JonAlert.show(message: "Vui lòng chọn nguyên liệu", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        }else if viewModel.vat_amount.value == 0 {
            viewModel.type_select_input_quantity.accept(1)
            self.presentModalInputQuantityViewController(number: viewModel.vat_percent.value, position: 1)
        }else{
            viewModel.vat_percent.accept(0)
            viewModel.vat_amount.accept(0)
            lbl_vat_amount.text = "0"
            lbl_vat_percent.isHidden = true
            icon_edit_vat.isHidden = true
            icon_check02.image = UIImage(named: "icon-uncheck-blue")
            self.calculateAmount()
        }
    }
    
    @IBAction func actionShowEditDiscount(_ sender: Any) {
        if viewModel.discount_amount.value != 0 {
            self.presentModalDialogChooseInput()
        }
    }
    
    @IBAction func actionShowEditVAT(_ sender: Any) {
        if viewModel.vat_amount.value != 0 {
            self.presentModalInputQuantityViewController(number: Float(viewModel.vat_percent.value), position: 1)
        }
    }
    
    @IBAction func actionChooseMaterial(_ sender: Any) {
        self.presentModalDialogChooseMaterial()
    }
    
    @IBAction func actionCreateInventory(_ sender: Any) {
        if isCheckSpam { return }
        isCheckSpam = true
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.isCheckSpam = false
        }
        if (viewModel.dataArray.value.count == 0) {
            JonAlert.show(message: "Vui lòng chọn nguyên liệu", andIcon: UIImage(named: "icon-warning"), duration: 2.0)
        }else{
            viewModel.type_dialog.accept(1)
            self.presentModalDialogAcceptSupplierWarehouse(index: 1)
        }
    }
    
    public func calculateAmount() {
        let discountAmount = viewModel.discount_amount.value
        let cloneDataArray = self.viewModel.dataArray.value
        // biến tính toán
        var totalAmount:Double = 0.00
        var vatAmount = 0
        var totalChange = 0
        var totalAfter = 0
        var discountPercent = 0
        
        cloneDataArray.enumerated().forEach { (index, value) in
            totalAmount += Double(cloneDataArray[index].price) * Double(cloneDataArray[index].total_import_quantity)
        }
        if viewModel.discount_percent.value == 0 {
            totalChange = Int(totalAmount) - discountAmount // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = totalChange + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
        } else {
            discountPercent = Int(totalAmount) * Int(viewModel.discount_percent.value) / 100 // tính giảm giá theo %
            totalChange = Int(totalAmount) - discountPercent // tổng sau giảm giá số tiền
            vatAmount = Int(totalChange) * Int(viewModel.vat_percent.value) / 100 // vat
            totalAfter = Int(totalAmount) - Int(discountPercent) + vatAmount
            
            lbl_total_amount.text = Utils.stringQuantityFormatWithNumber(amount: Int(totalAfter))
            lbl_discount_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: discountPercent)
        }
        lbl_vat_amount.text = Utils.stringVietnameseMoneyFormatWithNumber(amount: vatAmount)
    }
}
