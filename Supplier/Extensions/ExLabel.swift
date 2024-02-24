//
//  ExLabel.swift
//  Swift-Extensionn
//
//  Created by Anand Nimje on 27/01/18.
//  Copyright © 2018 Anand. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


import UIKit

@IBDesignable
class DesignableCustomLabel: UILabel {
}

extension UILabel{
    
    func setLeft(){
        self.textAlignment = .left
    }
    
    func setRight(){
        self.textAlignment = .right
    }
    
    func attribute(_ with: String, effect: String){
        let mainString = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: self.font.fontName, size: self.font.pointSize)!]
        let effectString = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: self.font.pointSize)]
        
        let partOne = NSMutableAttributedString(string: with, attributes: mainString)
        let partTwo = NSMutableAttributedString(string: effect, attributes: effectString)
        
        let combination = NSMutableAttributedString()
        combination.append(partOne)
        combination.append(partTwo)
        self.attributedText = combination
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
    
    func setDiffColor(color: UIColor, range: NSRange) {
         let attText = NSMutableAttributedString(string: self.text!)
         attText.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
         attributedText = attText
    }
    
    func halfTextColorChange (fullText : String , changeText : String ) {
            let strNumber: NSString = fullText as NSString
            let range = (strNumber).range(of: changeText)
            let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: ColorUtils.blue_color() , range: range)
            self.attributedText = attribute
        }
    
}


