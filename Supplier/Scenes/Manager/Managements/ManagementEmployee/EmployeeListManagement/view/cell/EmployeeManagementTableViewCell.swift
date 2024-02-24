//
//  EmployeeManagementTableViewCell.swift
//  Techres-Seemt
//
//  Created by Kelvin on 11/04/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class EmployeeManagementTableViewCell: UITableViewCell {
    @IBOutlet weak var lbl_phone: UILabel!
    

    @IBOutlet weak var view_resetpassword: UIView!
    @IBOutlet weak var icon_resetpassword: UIImageView!
    
    @IBOutlet weak var image_status_ring: UIImageView!
    @IBOutlet weak var root_view_status_background: UIView!
    @IBOutlet weak var image_status: UIImageView!
    @IBOutlet weak var view_status: UIView!
    @IBOutlet weak var lbl_name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var view_status_row: UIView!
    var imageEnable: UIImage = UIImage(named: "fi-rr-lock")!
    var imageDisable: UIImage = UIImage(named: "fi-rr-unlock")!

    @IBOutlet weak var btn_changepassword_employee: UIButton!
    @IBOutlet weak var btnLock: UIButton!
    @IBOutlet weak var btnUnLock: UIButton!
    var typeLock = 1
    
    private(set) var disposeBag = DisposeBag()
           override func prepareForReuse() {
               super.prepareForReuse()
               disposeBag = DisposeBag()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    // MARK: - Variable -
    public var data: Account? = nil {
        didSet {
            lbl_name.text = data?.name
            lbl_phone.text = data?.supplier_employee_position // tên chức vụ
            avatar.kf.setImage(with: URL(string: Utils.getFullMediaLink(string: data?.avatar ?? "")), placeholder: UIImage(named: "image_default_user"))
            // KIỂM TRA QUYỀN QUẢN LÝ BẢNG LƯƠNG
//            if(Utils.checkSalaryTableEmployess(permission: ManageCacheObject.getCurrentUser().permissions)) {
//                dLog("vao day")
                if (data!.status == 1){
                    btnLock.isHidden = false
                    btnUnLock.isHidden = true
                    icon_resetpassword.isHidden = false
                    view_resetpassword.isHidden = false
                    image_status.image = imageDisable
                    lbl_name.textColor = ColorUtils.black()
                    view_status.backgroundColor = ColorUtils.GrayColor()
                    view_status_row.backgroundColor = ColorUtils.white()
                    root_view_status_background.backgroundColor = ColorUtils.GrayColor()
                    image_status_ring.isHidden = false
                    avatar.alpha = 1
                    if (data?.is_working == 1){
                        avatar.borderWidth = 1
                        avatar.borderColor = ColorUtils.green_online()
                    } else {
                        avatar.borderWidth = 1
                        avatar.borderColor = ColorUtils.GrayColor()
                    }
                }else {
                    btnLock.isHidden = true
                    btnUnLock.isHidden = false
                    icon_resetpassword.isHidden = true
                    view_resetpassword.isHidden = true
                    image_status.image = imageEnable
                    lbl_name.textColor = UIColor(hex: "A7A8AB")
                    view_status.backgroundColor = ColorUtils.white()
                    view_status_row.backgroundColor = ColorUtils.GrayColor()
                    root_view_status_background.backgroundColor = ColorUtils.white()
                    image_status_ring.isHidden = true
                    avatar.alpha = 0.5
                    avatar.borderWidth = 0
                }
        }
    }
    
    var viewModel: EmployeeListManagementViewModel? {
           didSet {
              
           }
    }
    
    @IBAction func navigateToDetailEmployeeViewController(_ sender: Any) {
        viewModel!.makeDetailEmployeeViewController(employeeList: data!)
    }
    
}
