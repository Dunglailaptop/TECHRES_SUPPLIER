//
//  ColorUtils.swift
//  ALOLINE
//
//  Created by kelvin on 4/10/2022.
//  Copyright © 2022 Kelvin. All rights reserved.
//

import Foundation
import UIKit
class ColorUtils{
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    static func toolbar()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
  
    
    static func white()->UIColor{
        return UIColor.white
    }
    static func black()->UIColor{
        return UIColor.black
    }
    static func grey()->UIColor{
        return hexStringToUIColor(hex: "#D0D0D0")
    }
    static func yellow()->UIColor{
        return hexStringToUIColor(hex: "#f7bc0e")
    }
    static func dark_yellow()->UIColor{
        return hexStringToUIColor(hex: "#f8df6b")
    }
    static func blue()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
    static func blueButton()->UIColor{
        return hexStringToUIColor(hex: "#0072bc")
    }
    
    static func lightBlueButton()->UIColor{
        return hexStringToUIColor(hex: "#EBF4FA")
    }
    
    static func lightBlueBackground()->UIColor{
        return hexStringToUIColor(hex: "#CCE3F1")
    }
    
    static func main_color()->UIColor{
        return hexStringToUIColor(hex: "#ffa233")
    }
    static func main_navigabar_color()->UIColor{
        return hexStringToUIColor(hex: "#fa8f0c")
    }
    
    static func red_color()->UIColor{
        return hexStringToUIColor(hex: "#E8002E")
    }
    
    static func red_black_color()->UIColor{
        return hexStringToUIColor(hex: "#570b0b")
    }
    static func red_spin_color()->UIColor{
        return hexStringToUIColor(hex: "#ffb8b8")
    }
    
    static func blue_color()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
    
    static func blackTransparent()->UIColor{
        
        let black = hexStringToUIColor(hex: "#000000")
        let blackOpacity = black.withAlphaComponent(0.7)
        return blackOpacity;
    }
    
    static func pending_color()->UIColor{
        return hexStringToUIColor(hex: "#418bca")
    }
    static func booking_activity()->UIColor{
        return hexStringToUIColor(hex: "#0072bc")
    }
    
    static func waiting_payment_color()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    
    static func waiting_completed_color()->UIColor{
        return hexStringToUIColor(hex: "#EA4335")
    }
    
    static func order_detail_pending()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    
    static func order_detail_waiting_completed_color()->UIColor{
        return hexStringToUIColor(hex: "#4285F4")
    }
    
    static func order_detail_done_color()->UIColor{
        return hexStringToUIColor(hex: "#34A853")
    }
    
    static func order_detail_canceled()->UIColor{
        return hexStringToUIColor(hex: "#EA4335")
    }
    
    static func groupChatMyMessageColor()->UIColor{
        return hexStringToUIColor(hex: "#d5f1ff")
    }
    
    
    static func likeColor()->UIColor{
        return hexStringToUIColor(hex: "#2f74b5")
    }
    
    static func loveColor()->UIColor{
        return hexStringToUIColor(hex: "#ee7470")
    }
    
    static func emojiColor()->UIColor{
        return hexStringToUIColor(hex: "#f2cc66")
    }
    
    static func colorMyMessage()->UIColor{
        return hexStringToUIColor(hex:"#E3F2FD")
    }
    
    static func whiteBackGroundColor()->UIColor{
        return hexStringToUIColor(hex:"#FFFFFF")
    }
    
    static func blackBackGroundColor()->UIColor{
        return hexStringToUIColor(hex:"#000000")
    }
    
    static func buttonSeeAll()->UIColor{
        return hexStringToUIColor(hex:"#FAFAFA")
    }
    
    
    static func lightGrayBackGroundColor()->UIColor {
        return hexStringToUIColor(hex:"")
    }
    
    static func lightGrayTableView()->UIColor{
        return hexStringToUIColor(hex: "#FAFAFA")
    }
    
    static func mediumGrayBackGroundColor() -> UIColor {
        return hexStringToUIColor(hex:"")
    }
    
    static func darkGrayBackGroundColor() -> UIColor {
        return hexStringToUIColor(hex:"")
    }
    
    static func warningBackGroundColor() -> UIColor {
        return hexStringToUIColor(hex:"#FFFF8D")
    }
    
    static func ghostWhiteColor() -> UIColor {
        return hexStringToUIColor(hex:"#F8F8FF")
    }
    
    
    
    static func grayColor() -> UIColor {
        return hexStringToUIColor(hex:"#BEBEBE")
    }
    
    static func titleNavigateGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#C5C6C9")
    }
    
    static func lightGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#D3D3D3")
    }
    
    static func dimGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#696969")
    }
    
    static func disableGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#ebebeb")
    }
    
    static func GrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#F1F2F5")
    }
    
    static func transparentBackGrounnd() -> UIColor {
        return hexStringToUIColor(hex:"#1A000000")
    }
    
    
    static func friendItemBackgroundColor() -> UIColor {
        return hexStringToUIColor(hex:"#D6D6D6")
    }
    
    static func shadownGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#90A4AE")
    }
    
    static func buttonGrayColor() -> UIColor {
        return hexStringToUIColor(hex:"#E7E8EB")
    }
    static func buttonOrangeColor() -> UIColor {
        return hexStringToUIColor(hex:"#FF8B00")
    }
    static func orangeBackgroundColor() -> UIColor {
        return hexStringToUIColor(hex:"#FFE3C2")
    }
    static func buttonGreen() -> UIColor{
        return hexStringToUIColor(hex: "#0071BB")
    }
    static func lableBlack() -> UIColor{
        return hexStringToUIColor(hex: "#28282B")
    }
    
    static func textLabelBlue() -> UIColor{
        return hexStringToUIColor(hex: "#0071BB")
    }
    
    static func navigate_color()->UIColor{
        return hexStringToUIColor(hex: "#FFA233")
    }
    
    static func random() -> UIColor {
            return UIColor(red: .random(in: 0...1),
                           green: .random(in: 0...1),
                           blue: .random(in: 0...1),
                           alpha: 1.0)
        }
    
    
    //========== define color status booking =========
    static func redTransparent()->UIColor{
    
        let black = hexStringToUIColor(hex: "#a83e32")
        let blackOpacity = black.withAlphaComponent(0.1)
        return blackOpacity;
    }
    static func greenTransparent()->UIColor{
    
        let black = hexStringToUIColor(hex: "#04b533")
        let blackOpacity = black.withAlphaComponent(0.1)
        return blackOpacity;
    }
    
    static func blueTransparent()->UIColor{
    
        let black = hexStringToUIColor(hex: "#0072bc")
        let blackOpacity = black.withAlphaComponent(0.1)
        return blackOpacity;
    }
    static func grayTransparent()->UIColor{
    
        let black = hexStringToUIColor(hex: "#f0f0f0")
        let blackOpacity = black.withAlphaComponent(0.6)
        return blackOpacity;
    }
    //Gray color
    static func gray_000()->UIColor{
        return hexStringToUIColor(hex: "FFFFFF")
    }
    static func gray_6()->UIColor{
        return hexStringToUIColor(hex: "F2F2F7")
    }
    static func gray_100() -> UIColor{
        return hexStringToUIColor(hex: "F5F6FA")
    }
    static func gray_200() -> UIColor{
        return hexStringToUIColor(hex: "F1F2F5")
    }
    static func gray_300() -> UIColor{
        return hexStringToUIColor(hex: "E7E8EB")
    }
    
    static func gray_400() ->UIColor{
        return hexStringToUIColor(hex: "C5C6C9")
    }
    
    static func gray_600()->UIColor{
        return hexStringToUIColor(hex: "7D7E81")
    }
    static func gray_700_color() -> UIColor {
            return hexStringToUIColor(hex: "#696A6C")
    }

    //orange color
    static func orange_000() -> UIColor{
        return hexStringToUIColor(hex: "#FCF0E7")
    }
    
    
    static func orange_200() -> UIColor{
        return hexStringToUIColor(hex: "FFF1E0")
    }
    
    static func orange_700() -> UIColor{
        return hexStringToUIColor(hex: "#E96012")
    }
    
    
    static func orange_transparent_color() -> UIColor {
            return hexStringToUIColor(hex:"#FFF8EF")
        }
 
    static func red_transparent_color() -> UIColor {
            return hexStringToUIColor(hex: "#FFE8EC")
        }
    
    //Green color
    
    static func green()->UIColor{
        return hexStringToUIColor(hex: "#00A534")
    }
    static func green_online()->UIColor{
        return hexStringToUIColor(hex: "#02bf54")
    }
    static func green_transparent()->UIColor{
        return hexStringToUIColor(hex: "#DFEEE2")
    }
    
    static func green_000() -> UIColor {
        return hexStringToUIColor(hex: "#E2F3ED")
    }
    static func green_007() -> UIColor {
        return hexStringToUIColor(hex: "#48B28D")
    }
    static func green_008() -> UIColor {
        return hexStringToUIColor(hex: "#2F9672")
    }
    
    
    static func green_100() -> UIColor {
        return hexStringToUIColor(hex: "#DFEEE2")
    }
    
    
    static func dark_green() -> UIColor {
        return hexStringToUIColor(hex: "#009688")
    }
    static func green_600() -> UIColor {
        return hexStringToUIColor(hex: "#00A534")
    }
    
    static func blue_first() -> UIColor {
        return hexStringToUIColor(hex: "2672BC")
    }
    
    static func green_export() -> UIColor {
        return hexStringToUIColor(hex: "3AC382")
    }
    
    static func water_import() -> UIColor {
        return hexStringToUIColor(hex: "43CEE3")
    }
    
    static func orange_now() -> UIColor {
        return hexStringToUIColor(hex: "F8A234")
    }
    
    static func pink_cancel() -> UIColor {
        return hexStringToUIColor(hex: "F65D70")
    }
    
    
    //Blue_color
    static func blue_brand_400()->UIColor{
        return hexStringToUIColor(hex: "#99C6E4")
    }
    
    static func mainly_blue() -> UIColor {
            return hexStringToUIColor(hex: "#46A4FD")
        }
    static func dark_blue() -> UIColor {
            return hexStringToUIColor(hex: "#2343A7")
        }
    static func blue_000() -> UIColor{
        return hexStringToUIColor(hex: "#E3ECF5")
    }
    static func blue_100() -> UIColor{
        return hexStringToUIColor(hex: "#C7D9EC")
    }
    static func blue_300() -> UIColor{
        return hexStringToUIColor(hex: "#B3D4EB")
    }
    static func blue_700() -> UIColor{
        return hexStringToUIColor(hex: "#1462B0")
    }
    
    static func blue_brand_200() -> UIColor{
        return hexStringToUIColor(hex: "#CCE3F1")
    }
    
    static func blue_brand_700() -> UIColor{
        return hexStringToUIColor(hex: "#0071BB")
    }
    
    
    //red color 
    static func red_800() -> UIColor{
        return hexStringToUIColor(hex: "#CA0020")
    }
    static func red_600() -> UIColor{
        return hexStringToUIColor(hex: "#E8002E")
    }
    static func red_000() -> UIColor{
        return hexStringToUIColor(hex: "#FFE8EC")
    }
    
    static func common_window_background_color() -> UIColor{
        return hexStringToUIColor(hex: "#E7E7E7")
    }
    
    
    static func chartColors() -> [UIColor] {
            return [
                UIColor(hex: "5470c6"),
                UIColor(hex: "c23531"),
                UIColor(hex: "62c87f"),
                UIColor(hex: "e76f00"),
                UIColor(hex: "91c7ae"),
                UIColor(hex: "749f83"),
                UIColor(hex: "fac858"),
                UIColor(hex: "f4e001"),
                UIColor(hex: "00a2ae"),
                UIColor(hex: "bdbcbb")
            ]
        }
}
