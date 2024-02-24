//
//  CustomTabItem.swift
//  CustomTabBarExample
//
//  Created by Jędrzej Chołuj on 18/12/2021.
//

import UIKit

enum CustomTabItem: String, CaseIterable {
    case general
    case manager
    case message
    case notification
    case utilities
}
 
extension CustomTabItem {
    var viewController: UIViewController {
        switch self {
        case .general:
            let view = ReportGeneralViewController(nibName: "ReportGeneralViewController", bundle: Bundle.main)
            return view
            
        case .manager:
            let view = ManagerViewController(nibName: "ManagerViewController", bundle: Bundle.main)
            return view
            
        case .message:
            let view = MessageViewController(nibName: "MessageViewController", bundle: Bundle.main)
            return view
            
        case .notification:
            let view = NotificationViewController(nibName: "NotificationViewController", bundle: Bundle.main)
            return view
            
        case .utilities:
            let view = AccountViewController(nibName: "AccountViewController", bundle: Bundle.main)
            return view
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .general:
            return UIImage(named: "icon-tabbar-general-report-gray")?.withTintColor(.gray_Light_Text().withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            
        case .manager:
            return UIImage(named: "icon-tabbar-workplace-gray")?.withTintColor(.gray_Light_Text().withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            
        case .message:
            return UIImage(named: "icon-tabbar-message-gray")?.withTintColor(.gray_Light_Text().withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            
        case .notification:
            return UIImage(named: "icon-tabbar-notification-gray")?.withTintColor(.gray_Light_Text().withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
            
        case .utilities:
            return UIImage(named: "icon-tabbar-account-gray")?.withTintColor(.gray_Light_Text().withAlphaComponent(0.4), renderingMode: .alwaysOriginal)
        }
    }
    
    var selectedIcon: UIImage? {
        switch self {
        case .general:
            return UIImage(named: "icon-tabbar-general-report-blue")
            
        case .manager:
            return UIImage(named: "icon-tabbar-workplace-blue")
            
        case .message:
            return UIImage(named: "icon-tabbar-message-blue")
       
        case .notification:
            return UIImage(named: "icon-tabbar-notification-blue")
            
        case .utilities:
            return UIImage(named: "icon-tabbar-account-blue")
        }
    }
    
    var name: String {
        if(self.rawValue.capitalized == "General"){
            return "Tổng quan"
        }else if(self.rawValue.capitalized == "Manager"){
            return "Quản trị"
        }else if(self.rawValue.capitalized == "Message"){
            return "Tin nhắn"
        }else if(self.rawValue.capitalized == "Notification"){
            return "Thông báo"
        }else if(self.rawValue.capitalized == "Utilities"){
            return "Tài khoản"
        }
        return self.rawValue.capitalized
    }
}

