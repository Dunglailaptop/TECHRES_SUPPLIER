//
//  SettingAccountBusinessViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by macmini_techres_04 on 22/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Photos
import RxRelay
import RxCocoa
import RxSwift
import JonAlert
import iOSDropDown
import TagListView

class SettingAccountBusinessViewController: BaseViewController {
    
    @IBOutlet weak var txt_search: UITextField!
    @IBOutlet weak var height_viewoftable: NSLayoutConstraint!
    @IBOutlet weak var view_on_tableview: UIView!
    
    @IBOutlet weak var heightviewall: NSLayoutConstraint!
    @IBOutlet weak var heightview: NSLayoutConstraint!

    @IBOutlet weak var view_all: UIView!
    @IBOutlet weak var tag_List: TagListView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var height_tag_list: NSLayoutConstraint!
   
    //Profile
    @IBOutlet weak var view_typeBusiness: UIView!
    @IBOutlet weak var txt_businesscategory: UITextField!
    
    @IBOutlet weak var txt_businessId: UITextField!
    @IBOutlet weak var txt_nameBusiness: UITextField!
    @IBOutlet weak var txt_categoryBusiness: UITextField!
    @IBOutlet weak var txt_phoneBusiness: UITextField!
   
    @IBOutlet weak var lbl_textcount: UILabel!
    @IBOutlet weak var txt_description: UITextView!
    @IBOutlet weak var txt_taxCode: UITextField!
    @IBOutlet weak var txt_emailBusiness: UITextField!
    
    @IBOutlet weak var txt_addessBusiness: UITextField!
    
    @IBOutlet weak var txt_name_normalize: UITextField!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var lbl_city: UILabel!
    
    @IBOutlet weak var lbl_error_taxcode: UILabel!
    @IBOutlet weak var lbl_district: UILabel!
    
    @IBOutlet weak var lbl_ward: UILabel!
    public var isAllowEditing:Bool = false
    
    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var view_btn: UIView!
    
    @IBOutlet weak var lbl_error_bussiness_model: UILabel!
    @IBOutlet weak var lbl_error_phone: UILabel!
    @IBOutlet weak var lbl_error_email: UILabel!
    @IBOutlet weak var lbl_error_address: UILabel!
    @IBOutlet weak var lbl_error_business_name: UILabel!
    
    var viewModel = SettingAccountBusinessViewModel()
    var router = SettingAccountBusinessRouter()
    var imagecover = [UIImage]()
    var resources_path = [URL]()
    var selectedAssets = [PHAsset]()
    var imagecover2 = [UIImage]()
    var resources_path2 = [URL]()
    var selectedAssets2 = [PHAsset]()
    var ischeck = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        isAllowEditing = true
        checkValid()
        register()
        bindingtableview()
      
       
        // Do any additional setup after loading the view.
        lbl_error_bussiness_model.text = ""
        lbl_error_phone.text = ""
        lbl_error_email.text = ""
        lbl_error_address.text = ""
        lbl_error_business_name.text = ""
        
      
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutSide(_:)))
        tapGesture.cancelsTouchesInView = false
//        view.superview?.addGestureRecognizer(tapGesture) // Attach to the superview
        // OR
        UIApplication.shared.windows.first?.addGestureRecognizer(tapGesture) // Attach to the window
        
        txt_search.rx.controlEvent(.editingChanged)
                   .withLatestFrom(txt_search.rx.text)
                   .subscribe(onNext:{ [self]  query in
                       guard self != nil else { return }
                    
                       if viewModel.dataSearch.value.count == 0 {
                           var data = viewModel.dataArrayTypeBusiness.value
                           viewModel.dataSearch.accept(data)
                       }else {
//                           var dataSearch = viewModel.dataSearch.value
//                           var dataArray = viewModel.dataArrayTypeBusiness.value
//                           dataSearch.enumerated().forEach{ (index,value) in
//                               dataArray.enumerated().forEach{ (index1,value1) in
//                                   if value.id == value1.id && value.isSelected == ACTIVE {
//                                       dataArray[index1].isSelected = ACTIVE
//                                   }
//                               }
//                           }
//                           viewModel.dataArrayTypeBusiness.accept(dataArray)
//                           viewModel.dataFirst.accept(dataSearch)
                       }
                       let dataFirsts = viewModel.dataSearch.value
                       let cloneDataFilter = viewModel.dataArrayTypeBusiness.value
                       if !query!.isEmpty{
                           var filteredDataArray = cloneDataFilter.filter({
                               (value) -> Bool in
                               let str1 = query!.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               let str2 = value.name.uppercased().applyingTransform(.stripDiacritics, reverse: false)!
                               return str2.contains(str1)
                           })
                           viewModel.dataArrayTypeBusiness.accept(filteredDataArray)
                       }else{
                           viewModel.dataArrayTypeBusiness.accept(dataFirsts)
                             
                          
                       }
                       
        }).disposed(by: rxbag)
    }
    
    @objc private func handleTapOutSide(_ gesture: UITapGestureRecognizer) {
        let tapLocation1 = gesture.location(in: self.view_typeBusiness)
        let tapLocation2 = gesture.location(in: self.view_on_tableview)
        if  !view_typeBusiness.bounds.contains(tapLocation1) && !view_on_tableview.bounds.contains(tapLocation2) {
               // Handle touch outside of the view
            height_viewoftable.constant = 0
        }
//        else if view_typeBusiness.bounds.contains(tapLocation) {
//                    let height_ALL = CGFloat(20 + viewModel.dataArrayTypeBusiness.value.count * 40)
//                    height_viewoftable.constant = height_viewoftable.constant == 0 ? height_ALL:0
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
 

        getListTypeBusiness()
        getSupplierInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        view_btn.addShadow(shadowOffset: .zero, shadowOpacity: 0.5, shadowRadius: 10, color: .black)
        view_btn.roundCorners(corners: [.topLeft,.topRight], radius: 20)
    }

    @IBAction func btn_actionshooseAvatar(_ sender: Any) {
        ischeck = true
        chooseAvatar()
        
    }
    
   
    @IBAction func btn_choose_coverphoto(_ sender: Any) {
        ischeck = false
        chooseAvatar()
        
    }
    

    @IBAction func btn_makepoptoViewController(_ sender: Any) {
        viewModel.makepopViewController()
    }
    
    
    @IBAction func btn_actionChooseArea(_ sender: UIButton) {
        if isAllowEditing {self.presentAddressDialogOfAccountInforViewController(areaType: sender.titleLabel?.text ?? "")}
    }
    
    @IBAction func btn_showPopUp_TypeBusiness(_ sender: Any) {
        var dataFirst = viewModel.dataArrayTypeBusiness.value
        viewModel.dataFirst.accept(dataFirst)
        dLog(tag_List.intrinsicContentSize.height)
//        tableView.isHidden = tableView.isHidden == false
//        let height_tag = Int(tag_List.intrinsicContentSize.height) + 130
        let height_ALL = CGFloat(20 + viewModel.dataArrayTypeBusiness.value.count * 40)
//        heightview.constant = CGFloat(heightview.constant == height_ALL ? CGFloat(height_tag): height_ALL)
//        heightviewall.constant = view_all.layer.frame.height - 200 + heightview.constant
        height_viewoftable.constant = height_viewoftable.constant == 0 ? height_ALL:0
    }
    
    
    func checkValid() {
//        let maskPath = UIBezierPath(
//            roundedRect: view_on_tableview.bounds,
//                   byRoundingCorners: [.bottomLeft, .bottomRight],
//                   cornerRadii: CGSize(width: 10.0, height: 10.0) // Adjust the corner radius as needed
//               )
//
//               let maskLayer = CAShapeLayer()
//               maskLayer.path = maskPath.cgPath
//        view_on_tableview.layer.mask = maskLayer
        txt_name_normalize.isUserInteractionEnabled = false
        height_viewoftable.constant = 0
        tag_List.textFont = UIFont.systemFont(ofSize: 12,weight: .semibold)
//        tableView.isHidden = true
        tag_List.delegate = self
//        heightview.constant = 130
//        heighttable.constant = 0

        
        _ = txt_nameBusiness.rx.text.map{String($0!.prefix(51))}.map({(str) -> SupplierBusiness in
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.name = str ?? ""
            self.lbl_error_business_name.isHidden = true
            self.txt_nameBusiness.text = str
            if (self.txt_nameBusiness.isEditing){
                self.lbl_error_business_name.isHidden = str.count == 0 ? false : true
                if ((self.txt_nameBusiness.text?.trimmingCharacters(in: .whitespacesAndNewlines).count)! > 50){
                    self.lbl_error_business_name.text = "Tên doanh nghiệp tối đa 50 ký tự"
                    self.lbl_error_business_name.isHidden = false
                }else if (self.txt_nameBusiness.text!.count < 2 && self.txt_nameBusiness.text!.count > 0) {
                    self.lbl_error_business_name.text = "Tên doanh nghiệp ít nhất 2 ký tự"
                    self.lbl_error_business_name.isHidden = false
                }
            }else {
                self.lbl_error_business_name.isHidden = str.count == 0 ? false : true
            }
          
            dLog(cloneEmployeeInfor)
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
        _ = txt_categoryBusiness.rx.text.map{String($0!.prefix(50))}.map({(str) -> SupplierBusiness in
           var cloneEmployeeInfor = self.viewModel.supplierInfor.value
           cloneEmployeeInfor.website = str ?? ""

           return cloneEmployeeInfor
       }).bind(to: viewModel.supplierInfor)
    
        _ = txt_phoneBusiness.rx.text.map({(str) in
            if str!.count > 10 {
                JonAlert.show(message: "Số điện thoại tối đa là 10 số")
            }
            return str
        }).map{String($0!.prefix(10))}.map({(str) -> SupplierBusiness in
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.phone = str ?? ""
            self.txt_phoneBusiness.text = str
            self.lbl_error_phone.isHidden = true
            if (self.txt_phoneBusiness.isEditing){
                if (str.count == 0) {
                    self.lbl_error_phone.isHidden = false
                    self.lbl_error_phone.text = "Vui lòng nhập số điện thoại"
                }
                if (str.count > 0 && str.first != "0") {
                    self.lbl_error_phone.isHidden = false
                    self.lbl_error_phone.text = "Số đầu tiên phải là số 0"
                    
                }else if (str.count < 10 && str.count > 1){
                    self.lbl_error_phone.isHidden = false
                    self.lbl_error_phone.text = "Số điện thoại chưa đủ 10 số"
                }
            }else {
                if (str.count == 0){
                    self.lbl_error_phone.isHidden = false
                    self.lbl_error_phone.text = "Vui lòng nhập số điện thoại"
                }
            }
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
        
        _ = txt_emailBusiness.rx.text.map{String($0!.prefix(50))}.map({(str) -> SupplierBusiness in
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.email = str
            self.txt_emailBusiness.text = str
            if Utils.isEmailFormatCorrect(str){
                self.lbl_error_email.isHidden = true
            }else {
                self.lbl_error_email.isHidden = true
                if (str.count > 0){
                    self.lbl_error_email.isHidden = false
                    self.lbl_error_email.text = "Email không hợp lệ"
                }else if (str.count == 0 && self.txt_emailBusiness.isEditing) {
                    self.lbl_error_email.isHidden = false
                    self.lbl_error_email.text = "vui lòng nhập Email"
                }else {
                    self.lbl_error_email.isHidden = false
                }
            }
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
        
        _ = txt_addessBusiness.rx.text.map{String($0!.prefix(256))}.map({(str) -> SupplierBusiness in
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.address = str
            self.lbl_error_address.isHidden = true
          
            if self.txt_addessBusiness.isEditing {
                if (str.trim().count < 2 && str.count > 0) {
                    self.lbl_error_address.text = "Địa chỉ ít nhất 2 ký tự"
                    self.lbl_error_address.isHidden = false
                    self.txt_addessBusiness.text = Utils.blockSpace(str)
                }else if (str.count > 255) {
                    self.lbl_error_address.text = "Địa chỉ tối đa 255 ký tự"
                    self.lbl_error_address.isHidden = false
                    self.txt_addessBusiness.text = str
                }else if (str.count == 0) {
                    self.lbl_error_address.text = "Địa chỉ không được bỏ trống"
                    self.lbl_error_address.isHidden = false
                }
            }else {
                if (str.count == 0) {
                    self.lbl_error_address.text = "Địa chỉ không được bỏ trống"
                    self.lbl_error_address.isHidden = false
                }
           
            }
            
            
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
        _ = txt_description.rx.text.map{String($0!.prefix(1000))}.map({(str) ->
            SupplierBusiness in
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.description = str
            self.lbl_textcount.text = "\(str.count  ?? 0)/1000"
            self.txt_description.text = str
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
        _ = txt_taxCode.rx.text.map{(str) in
            
            if str!.count > 15 {
                JonAlert.showError(message: "Độ dài tối đa 15 ký tự")
            }
            return String(str!.prefix(255))
        }.map{String($0!.prefix(15))}.map({(str) ->
            SupplierBusiness in
            if str.count < 10 && self.txt_taxCode.isEditing {
                self.lbl_error_taxcode.isHidden = false
                self.lbl_error_taxcode.text = "Độ dài tối thiểu 10 ký tự"
            }
            self.txt_taxCode.text = str
            var cloneEmployeeInfor = self.viewModel.supplierInfor.value
            cloneEmployeeInfor.tax_code = str
            return cloneEmployeeInfor
        }).bind(to: viewModel.supplierInfor)
        
      
    }
    
    
    @IBAction func btn_UpdateBusiness(_ sender: Any) {
        presentDialogAccessUpdatepProfileBusiness()

    }
    
}
