//
//  AccountViewController.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import Kingfisher
import JonAlert
class AccountViewController: BaseViewController {
    var viewModel = AccountViewModel()
    var router = AccountRouter()
    
    @IBOutlet weak var switch_setting_account: UISwitch!
    @IBOutlet weak var user_avatar: UIImageView!
    @IBOutlet var parent_view: UIView!
    @IBOutlet weak var xiew: UIView!
    @IBOutlet weak var scroll_view: UIScrollView!
    @IBOutlet weak var content_scroll_view: UIView!
    @IBOutlet weak var height_of_content_scroll_view: NSLayoutConstraint!
    
    @IBOutlet weak var lbl_employee_full_name: UILabel!
    @IBOutlet weak var lbl_employee_role_name: UILabel!
    @IBOutlet weak var lbl_employee_username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let avatarLink = Utils.getFullMediaLink(string: ManageCacheObject.getCurrentUser().avatar)
        user_avatar.kf.setImage(with: URL(string:avatarLink),placeholder: UIImage(named: "image_default_user"))
        
        lbl_employee_full_name.text = ManageCacheObject.getCurrentUser().name
        lbl_employee_role_name.text = ManageCacheObject.getCurrentUser().employee_role_name
        lbl_employee_username.text = ManageCacheObject.getUsernameLogin()
    }

    @IBAction func actionNavigaToFeedBackViewController(_ sender: Any) {
        viewModel.makeFeedBackViewController()
    }
    

    @IBAction func actionNavigateToAccountInforViewController(_ sender: Any) {
        viewModel.makeAccountInforViewController()
    }
    
    @IBAction func btn_maketoSettingAccountViewController(_ sender: Any) {
        viewModel.makeToSettingAccountViewController()

    }
    
    @IBAction func actionPrivacy(_ sender: Any) {
        viewModel.title_header.accept("ĐIỀU KHOẢN SỬ DỤNG")
        viewModel.link_website.accept(Constants.CONFIG_LINKS.LINK_PRIVACY)
        viewModel.makePrivacyViewController()
    }
    
    @IBAction func actionPolicy(_ sender: Any) {
        viewModel.title_header.accept("CHÍNH SÁCH BẢO MẬT")
        viewModel.link_website.accept(Constants.CONFIG_LINKS.LINK_POLICY)
        viewModel.makePolicyViewController()
    }
    
    
    @IBAction func btn_Logout(_ sender: Any) {
        self.prensentDialogConfirm()
    }
    
    @IBAction func btn_ChangePassword(_ sender: Any) {
        viewModel.makeChangePasswordViewController()
    }
    
    
    @IBAction func actionAppReview(_ sender: Any) {
        reviewOnAppStore()
    }
    
    
    @IBAction func actionInfoApp(_ sender: Any) {
        openAppStore()
    }
    
    
    func openAppStore() {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id6449210071"),
            UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url, options: [:]) { (opened) in
                if(opened){
//                    JonAlert.show(message: "App Store Opened")
                }
            }
        } else {
//            JonAlert.show(message: "Can't Open URL on Simulator")
        
        }
    }
    
    func reviewOnAppStore() {
            guard let productURL = URL(string: APP_STORE_URL) else {
                return
            }
            
            var components = URLComponents(url: productURL, resolvingAgainstBaseURL: false)

            // 2.
            components?.queryItems = [
              URLQueryItem(name: "action", value: "write-review")
            ]

            // 3.
            guard let writeReviewURL = components?.url else {
              return
            }

            // 4.
            UIApplication.shared.open(writeReviewURL)
     }
    
    
  
}
