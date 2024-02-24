//
//  CustomTabBarController+Extension.swift
//  SEEMT
//
//  Created by Kelvin on 01/07/2023.
//  Copyright © 2023 OVERATE-VNTECH. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift

extension CustomTabBarController{
    func setupManagerBagValue(bagValue:String){
        
         if let seemtTab = customTabBar.viewWithTag(1){
             if let containerView = seemtTab.viewWithTag(1){
                 
                 if let labelView = (containerView.viewWithTag(TAG_NOTIFICATION_BAGVALUE_MANAGER)) as? UILabel{
                     labelView.text = bagValue
                     labelView.isHidden = Int(bagValue) == DEACTIVE
                     labelView.backgroundColor = ColorUtils.orange_700()
                     labelView.textColor = .white
                 }
                

             }
         }
    }
    func setupMessageBagValue(bagValue:String){
        
         if let seemtTab = customTabBar.viewWithTag(2){
             if let containerView = seemtTab.viewWithTag(2){
                 
                 if let labelView = (containerView.viewWithTag(TAG_NOTIFICATION_BAGVALUE_MESSAGE)) as? UILabel{
                     labelView.text = bagValue
                     labelView.isHidden = Int(bagValue) == DEACTIVE
                     labelView.backgroundColor = ColorUtils.orange_700()
                     labelView.textColor = .white
                 }
                

             }
         }
    }
    func setupNotificationBagValue(bagValue:String){
        
         if let seemtTab = customTabBar.viewWithTag(3){
             if let containerView = seemtTab.viewWithTag(3){
                 
                 if let labelView = (containerView.viewWithTag(TAG_NOTIFICATION_BAGVALUE_NOTIFICATION)) as? UILabel{
                     labelView.text = bagValue
                     labelView.isHidden = Int(bagValue) == DEACTIVE
                     labelView.backgroundColor = ColorUtils.orange_700()
                     labelView.textColor = .white
                 }
                

             }
         }
    }
    
}
