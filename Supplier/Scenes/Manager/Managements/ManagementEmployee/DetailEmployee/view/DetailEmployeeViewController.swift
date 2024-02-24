//
//  DetailEmployeeViewController.swift
//  Techres-Seemt
//
//  Created by Nguyen Thanh Vinh on 19/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import Photos
import iOSDropDown
import JonAlert
class DetailEmployeeViewController: BaseViewController {

    var viewModel = DetailEmployeeViewModel()
    var router = DetailEmployeeRouter()
    public var employeeInfor = Account()
    public var isAllowEditing:Bool = false
    /*chỉ có duy nhất 2 loại module UPDATE and CREATE*/
    public var moduleType:String = "CREATE"
    

    @IBOutlet weak var navigate_back_view: UIView!
    @IBOutlet weak var btn_bar_view: UIView!
    

    
    
    
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var employee_view: UIView!
    
    
    @IBOutlet weak var lbl_employee_id: UILabel!
    
    @IBOutlet weak var title_view: UIView!
    @IBOutlet weak var btn_show_dropDown_title: UIButton!
    @IBOutlet weak var dropdown_title: DropDown!
    
    
    @IBOutlet weak var text_field_name: UITextField!
    @IBOutlet weak var text_field_identity_card: UITextField!
    
    @IBOutlet weak var male_radioBtn_icon: UIImageView!
    @IBOutlet weak var female_radioBtn_icon: UIImageView!
    @IBOutlet weak var lbl_birthday: UILabel!
    @IBOutlet weak var text_field_phone: UITextField!
    @IBOutlet weak var text_field_email: UITextField!
    @IBOutlet weak var text_field_address:UITextField!
    @IBOutlet weak var lbl_city: UILabel!
    @IBOutlet weak var lbl_district: UILabel!
    @IBOutlet weak var lbl_ward: UILabel!
    @IBOutlet weak var lbl_Tittle_Detail: UILabel!
    

    @IBOutlet weak var lbl_error_name: UILabel!
    @IBOutlet weak var lbl_error_cardId: UILabel!
    
    @IBOutlet weak var lbl_error_DOB: UILabel!
    @IBOutlet weak var lbl_error_phone: UILabel!
    @IBOutlet weak var lbl_error_email: UILabel!
    @IBOutlet weak var lbl_error_address: UILabel!
    
    @IBOutlet weak var lbl_error_choose_city: UILabel!
    
    @IBOutlet weak var lbl_error_choose_district: UILabel!
    
    @IBOutlet weak var lbl_error_choose_ward: UILabel!
    
    
    //Outlet btn-bar
    @IBOutlet weak var cancel_view: UIView!
    @IBOutlet weak var cancel_icon: UIImageView!
    @IBOutlet weak var lbl_cancel: UILabel!
    @IBOutlet weak var confirm_view: UIView!
//    @IBOutlet weak var confirm_icon: UIImageView!
    @IBOutlet weak var lbl_confirm: UILabel!
    
    @IBOutlet weak var height_of_btn_bar_view: NSLayoutConstraint!
    weak var timer: Timer?
    var categories = [SupplierRole]()
    var imagecover = [UIImage]()
    var resources_path = [URL]()
    var selectedAssets = [PHAsset]()
    var checkDailog = false
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        firstSetup()
        
        lbl_Tittle_Detail.text = "TẠO NHÂN VIÊN"
        
        if employeeInfor.id > 0 {
            lbl_Tittle_Detail.text = "THÔNG TIN NHÂN VIÊN"
            viewModel.detailEmployee.accept(employeeInfor)
            getDetailEmployee()
        }
        getSupplierRole()
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { [weak self] _ in
            self!.viewModel.isMessageShowing.accept(false)
        }
        
    }
    
    deinit {
        timer?.invalidate()
    }
    
    func showWarningMessage(content:String){
        if(!viewModel.isMessageShowing.value){
            JonAlert.show(message: content ,
                          andIcon: UIImage(named: "icon-tab-workplace"),
                          duration: 2.0)
            viewModel.isMessageShowing.accept(true)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
    
       
    }
    

    @IBAction func navigateBack(_ sender: Any) {
        checkDailog == true ? presentModalDialogAccessPopUp(type: 0): viewModel.makePopViewController()
 
        
    }
    
    
    @IBAction func btnUpdate(_ sender: Any) {
        _ = isEmployeeInforValid.take(1).subscribe(onNext: {[self] (isValid) in
            
            if isValid {
                switch moduleType {
                    case "UPDATE":
                        imagecover.count > 0 ? updateProfileWithAvatar() : UpdateProfileWithoutAvatar()
                    case "CREATE":
                        viewModel.dialogType.accept(0)
                        prensentDialogConfirm(content: "Bạn có chắc chắn thêm nhân viên này không?")
                    case "UPDATEEMPLOYEE":
                    self.presentModalDialogAccessUpdateEmployee(username: employeeInfor.username)
                    default:
                        return
                }
            }
        }).disposed(by: rxbag)

        UIView.animate(withDuration: 0.4, delay: 0, options: [.autoreverse] ,animations:{[self] in
            confirm_view.backgroundColor = ColorUtils.blue_700()
//            confirm_icon.image = UIImage(named: "icon-check-white")
            lbl_confirm.textColor = .white
        },completion: { [self] _ in
            confirm_view.backgroundColor = ColorUtils.blue_100()
//            confirm_icon.image = UIImage(named: "icon-check-green-008")
            lbl_confirm.textColor = ColorUtils.blue_700()
        })
    }
    
    
    @IBAction func actionChooseAvatar(_ sender: UIButton) {
       chooseAvatar()
    
    }
    

    @IBAction func actionToGender(_ sender: UIButton) {
     
            var cloneEmployeeInfor = viewModel.employeeInfor.value
            cloneEmployeeInfor.gender = sender.titleLabel?.text == "MALE" ? 1 : 0
            viewModel.employeeInfor.accept(cloneEmployeeInfor)
            male_radioBtn_icon.image = UIImage(named: sender.titleLabel?.text == "MALE" ? "icon-radio-checked" : "icon-radio-unchecked")
            female_radioBtn_icon.image = UIImage(named: sender.titleLabel?.text == "FEMALE" ? "icon-radio-checked" : "icon-radio-unchecked")
        checkDailog = true
    
    }
    
    
    @IBAction func actionChooseBirthDate(_ sender: Any) {
        showDateTimePicker(dateTimeData: viewModel.employeeInfor.value.birthday)
    }
    
    
    @IBAction func actionChooseArea(_ sender: UIButton) {
        self.presentAddressDialogOfAccountInforViewController(areaType: sender.titleLabel?.text ?? "")
    }
    

    
    func mapEmployeeData(employeeDetail: DetailProfileEmployee){
        avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: employeeDetail.avatar)), placeholder: UIImage(named: "image_default_user"))
        lbl_employee_id.text = String(employeeDetail.id)
        dropdown_title.text = employeeDetail.supplier_employee_position
        text_field_name.text = employeeDetail.name
        text_field_identity_card.text = employeeDetail.identity_card
        male_radioBtn_icon.image = UIImage(named: employeeDetail.gender == 1 ? "icon-radio-checked" : "icon-radio-unchecked")
        female_radioBtn_icon.image = UIImage(named: employeeDetail.gender == 0 ? "icon-radio-checked" : "icon-radio-unchecked")

        lbl_birthday.text = employeeDetail.birthday
        text_field_phone.text = employeeDetail.phone
        text_field_email.text = employeeDetail.email
        text_field_address.text = employeeDetail.address
        lbl_city.text = employeeDetail.city_name
        lbl_district.text = employeeDetail.district_name
        lbl_ward.text = employeeDetail.ward_name
    }
    
        
    private func firstSetup(){
        employee_view.isHidden = false
        btn_bar_view.isHidden =  false 
        height_of_btn_bar_view.constant =  80
        btn_bar_view.addShadow(shadowOffset: .zero, shadowOpacity: 0.7, shadowRadius: 10, color: .black)
        btn_bar_view.roundCorners(corners: [.topLeft,.topRight], radius: 20)
        dropdown_title.hideOptionsWhenSelect = true
        btn_show_dropDown_title.rx.tap.subscribe(onNext: { [weak self] in
            self!.dropdown_title.showList()
            self!.checkDailog = true
        }).disposed(by: rxbag)
        
        text_field_name.isUserInteractionEnabled =  true
        text_field_identity_card.isUserInteractionEnabled = true
        text_field_phone.isUserInteractionEnabled = true
        text_field_email.isUserInteractionEnabled = true
        text_field_address.isUserInteractionEnabled = true
        title_view.isUserInteractionEnabled = true
        
    
        
        if moduleType == "UPDATE" {
            lbl_confirm.text = "CẬP NHẬT"
            title_view.isUserInteractionEnabled = false
        } else if moduleType == "CREATE" {
//            confirm_icon.isHidden = true
            lbl_confirm.text = "TẠO NHÂN VIÊN"
            employee_view.isHidden = true
        } else if moduleType == "UPDATEEMPLOYEE"{
            lbl_confirm.text = "CẬP NHẬT"
//            employee_view.isHidden = true
        }
       
        mappingAndValidateData()
        hideAllError()
    }
    
    func hideAllError(){
        text_field_name.delegate = self
        text_field_email.delegate = self
        text_field_phone.delegate = self
        text_field_address.delegate = self
        text_field_identity_card.delegate = self
        
        lbl_error_name.isHidden = true
        lbl_error_cardId.isHidden = true
        lbl_error_DOB.isHidden = true
        lbl_error_phone.isHidden = true
        lbl_error_email.isHidden = true
        lbl_error_address.isHidden = true
        lbl_error_choose_city.isHidden = true
        lbl_error_choose_district.isHidden = true
        lbl_error_choose_ward.isHidden = true
    }
    
    
}


extension DetailEmployeeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
      dLog("ok")
        checkDailog = true
        return true
    }

}
