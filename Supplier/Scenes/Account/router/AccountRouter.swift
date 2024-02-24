//
//  AccountRouter.swift
//  TECHRES-SUPPLIER
//
//  Created by Pham Khanh Huy on 21/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit

class AccountRouter: NSObject {
    var viewController:UIViewController{
        return createViewController()
    }
    
    
    var sourceView:UIViewController?
    private func createViewController() -> UIViewController{
        let view = AccountViewController(nibName: "AccountViewController", bundle: .main)
        return view
    }
    
    func setSourceView(_ sourceView: UIViewController?){
        guard let view = sourceView else {fatalError("")}
        self.sourceView = view
    }
    
    
    func navigateToAccountInforViewController(){
        let detailEmployeeViewController = DetailEmployeeRouter().viewController as! DetailEmployeeViewController
        detailEmployeeViewController.isAllowEditing = true
        detailEmployeeViewController.employeeInfor = ManageCacheObject.getCurrentUser()
        detailEmployeeViewController.moduleType = "UPDATE"
        sourceView?.navigationController?.pushViewController(detailEmployeeViewController, animated: true)
    }
    
    func navigateToPrivacyViewController(title_header:String, link_website:String){
        let loadWebLinkViewController = LoadWebLinkRouter().viewController as! LoadWebLinkViewController
        loadWebLinkViewController.title_header = title_header
        loadWebLinkViewController.link = link_website
        sourceView?.navigationController?.pushViewController(loadWebLinkViewController, animated: true)
    }
    
    func navigateToPopViewController(){
        sourceView?.navigationController?.popViewController(animated: true)
    }
    
    func navigateToSettingAccountBusiness(){
        let SettingAccountBusinessViewController = SettingAccountBusinessRouter().viewController
        sourceView?.navigationController?.pushViewController(SettingAccountBusinessViewController, animated: true)
    }
    
    func navigateToPolicyViewController(title_header:String, link_website:String){
        let loadWebLinkViewController = LoadWebLinkRouter().viewController as! LoadWebLinkViewController
        loadWebLinkViewController.title_header = title_header
        loadWebLinkViewController.link = link_website
        sourceView?.navigationController?.pushViewController(loadWebLinkViewController, animated: true)
    }
    
    func navigateToLoginViewController(){
        let loginViewController = LoginRouter().viewController
        sourceView?.navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    func navigateToChangePasswordViewController(){
        let changePasswordViewController = ChangePasswordRouter().viewController
        sourceView?.navigationController?.pushViewController(changePasswordViewController, animated: true)
    }
    
    func navigateToFeedBackViewController() {
        let FeedBackViewController = FeedBackRouter().viewController
        sourceView?.navigationController?.pushViewController(FeedBackViewController, animated: true)
    }
    
}
